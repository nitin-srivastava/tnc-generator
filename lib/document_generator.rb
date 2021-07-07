# DocumentGenerator class is responsible to start the
# app execution, ask user to select dataset and template
# files from the list and generate the T&C document
require 'byebug'
require 'yaml'
class DocumentGenerator

  def execute
    available_files = Dir['data/*.yml']
    prompt_message(available_files)
    loop do
      dataset_file = gets.chomp
      if available_files.include?(dataset_file)
        @dataset = YAML.load_file(dataset_file)['dataset']
        break
      else
        prompt_message(available_files, invalid_input: true)
      end
    end
  end

  private

  def prompt_message(files, invalid_input = false)
    puts "Sorry wrong input." if invalid_input
    puts "Please enter a dataset file from the below list:"
    files.each_with_index { |f, i| printf "#{i + 1}. #{f}\n"}
    printf "\n"
  end
end