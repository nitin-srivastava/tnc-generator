require 'spec_helper'
require_relative '../lib/document_generator'

RSpec.describe DocumentGenerator do
  subject { DocumentGenerator.new }

  describe '#execute' do
    let(:dataset_output_msg) do
      "Please enter a dataset file from the below list:\n1. data/dataset.yml\n\n"
    end
    let(:output_msg) do
      "Please enter a template file from the below list:\n1. data/template_one.txt\n2. data/template_two.txt\n\n"
    end
    let(:file_name) { 'spec/files/tnc_document.txt' }
    after do
      File.delete(file_name) if File.exist?(file_name)
    end

    context 'when wrong dataset file has entered then' do
      let(:input_file) { "test_file.yml\n" }
      let(:wrong_input_msg) do
        "#{dataset_output_msg}Sorry wrong input #{input_file.chomp}.\n#{dataset_output_msg}"
      end

      before do
        allow(subject).to receive(:gets).and_return(input_file)
        allow(subject).to receive(:generate_document).and_return(true)
        allow(subject).to receive(:loop).and_yield
      end

      it 'prompt wrong input message' do
        expect { subject.execute }.to output(wrong_input_msg).to_stdout
      end
    end

    context 'when wrong file entered then' do
      let(:input_file) { "test_file.txt\n" }
      let(:wrong_input_msg) do
        "#{dataset_output_msg}#{output_msg}Sorry wrong input test_file.txt.\n#{output_msg}"
      end

      before do
        allow(subject).to receive(:gets).and_return("data/dataset.yml", input_file)
        allow(subject).to receive(:loop).and_yield
      end

      it 'prompt wrong input message' do
        expect { subject.execute }.to output(wrong_input_msg).to_stdout
      end
    end

    context 'when a valid file entered then' do
      let(:input_file) { "data/template_one.txt\n" }
      let(:print_msg) do
        "#{dataset_output_msg}#{output_msg}\nA T&C Document has been generated in tmp folder.\n"
      end

      before do
        allow(subject).to receive(:gets).and_return("data/dataset.yml", input_file)
        allow(subject).to receive(:loop).and_yield
      end

      it 'prints T&C Document has been generated in tmp folder message' do
        expect { subject.execute }.to output(print_msg).to_stdout
      end
    end
  end
end