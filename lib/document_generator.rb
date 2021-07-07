# DocumentGenerator class is responsible to start the
# app execution, ask user to select dataset and template
# files from the list and generate the T&C document
require 'byebug'
require 'yaml'
require_relative 'document_parser'
class DocumentGenerator

  def execute
    select_dataset
    generate_document
  end

  private

  def select_dataset
    available_files = Dir['data/*.yml']
    prompt_message('dataset', available_files)
    loop do
      dataset_file = gets.chomp
      if available_files.include?(dataset_file)
        @dataset = YAML.load_file(dataset_file)['dataset']
        break
      else
        options = { input_file: dataset_file, invalid_input: true }
        prompt_message('dataset', available_files, options)
      end
    end
  end

  def generate_document
    available_files = Dir['data/*.txt']
    prompt_message('template', available_files)
    loop do
      template_file = gets.chomp
      if available_files.include?(template_file)
        document_parser = DocumentParser.new(@dataset['clauses'], @dataset['sections'])
        content = document_parser.parse(template_file)
        document_parser.generate(content)
        printf "\nA T&C Document has been generated in tmp folder.\n"
        break
      else
        options = { input_file: template_file, invalid_input: true }
        prompt_message('template', available_files, options)
      end
    end
  end

  def prompt_message(file_type, files, options = {})
    puts "Sorry wrong input #{options[:input_file]}." if options[:invalid_input]
    puts "Please enter a #{file_type} file from the below list:"
    files.each_with_index { |f, i| printf "#{i + 1}. #{f}\n"}
    printf "\n"
  end
end