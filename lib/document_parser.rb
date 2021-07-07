# DocumentParser class will parse the template
# raise errors if something went wrong
# and returns parsed content
require 'byebug'
class DocumentParser
  attr_accessor :clauses_hash, :sections_hash

  def initialize(clauses, sections)
    @clauses_hash = clauses
    @sections_hash = sections
  end

  def parse(file_name)
    file_data = File.open(file_name).readlines
    return file_data unless tags_present?(file_data.join)
    parse_content(file_data)
  rescue StandardError => e
    puts "\nDocument Parse Error:: #{e.message}"
  end

  def generate(content)
    delete_existing_file(file_path)
    File.open(file_path, 'w') do |f|
      f.write(content)
      f.close
    end
  rescue StandardError => e
    puts "\n#{e.message}"
  end

  private

  def tags_present?(data)
    data.include?("[CLAUSE-") || data.include?("[SECTION-")
  end

  def parse_content(file_data)
    file_data.map.with_index(1) do |line, index|
      if tags_present?(line)
        "#{parse_line(line.chomp, index)}\n"
      else
        line
      end
    end.join
  end

  def parse_line(line, i)
    line_data = line.split
    line_data.map do |data|
      if tags_present?(data)
        parse_tag(data, i)
      else
        data
      end
    end.join(' ')
  end

  def parse_tag(text, i)
    matched = match_tags(text)
    content = case matched[:tag]
              when 'CLAUSE'
                clause_content(matched[:id].to_i, i)
              when 'SECTION'
                section_content(matched[:id].to_i, i)
              end
    "#{content}#{text.gsub("[#{matched}]", '')}"
  end

  def match_tags(line)
    line.match /(?<tag>\w+)-(?<id>\d+)/
  end

  def clause_content(clause_id, line_number)
    clause = @clauses_hash.select { |ch| ch['id'] == clause_id }.last
    if clause.is_a?(Hash)
      clause['text']
    else
      raise StandardError, "Invalid tag [CLAUSE-#{clause_id}] in line #{line_number}."
    end
  end

  def section_content(section_id, line_number)
    section = @sections_hash.select { |ch| ch['id'] == section_id }.last
    if section.is_a?(Hash)
      clause_ids = section['clauses_ids']
      clause_ids.map { |cid| clause_content(cid, line_number) }.join(';')
    else
      raise StandardError, "Invalid tag [SECTION-#{section_id}] in line #{line_number}."
    end
  end

  def file_path
    if ENV.fetch('RUBY_ENV').eql?('test')
      'spec/files/tnc_document.txt'
    else
      'tmp/tnc_document.txt'
    end
  end

  def delete_existing_file(file_name)
    File.delete(file_name) if File.exist?(file_name)
  end
end