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
      input_number = gets.chomp.to_i
      if (1..available_files.length).include?(input_number)
        dataset_file = available_files[input_number - 1]
        @dataset = YAML.load_file(dataset_file)['dataset']
        break
      else
        options = { input_number: input_number, invalid_input: true }
        prompt_message('dataset', available_files, options)
      end
    end
  end

  def generate_document
    available_files = Dir['data/*.txt']
    prompt_message('template', available_files)
    loop do
      input_number = gets.chomp.to_i
      if (1..available_files.length).include?(input_number)
        template_file = available_files[input_number - 1]
        document_parser = DocumentParser.new(@dataset['clauses'], @dataset['sections'])
        content = document_parser.parse(template_file)
        document_parser.generate(content)
        printf "\nA T&C Document has been generated in tmp folder.\n"
        break
      else
        options = { input_number: input_number, invalid_input: true }
        prompt_message('template', available_files, options)
      end
    end
  end

  def prompt_message(file_type, files, options = {})
    puts "Sorry wrong input #{options[:input_number]}.\n" if options[:invalid_input]
    puts "Please select a #{file_type} file number from the below list:"
    files.each_with_index { |f, i| printf "#{i + 1}. #{f}\n"}
  end
end