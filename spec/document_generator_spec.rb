require 'spec_helper'
require_relative '../lib/document_generator'

RSpec.describe DocumentGenerator do
  subject { DocumentGenerator.new }

  let(:dataset_output_msg) do
    "Please enter a dataset file from the below list:\n1. data/dataset.yml\n\n"
  end

  describe '#execute' do
    let(:input_file) { "test_file.yml\n" }
    let(:wrong_input_msg) do
      "#{dataset_output_msg}Sorry wrong input.\n#{dataset_output_msg}"
    end

    before do
      allow(subject).to receive(:gets).and_return(input_file)
      allow(subject).to receive(:loop).and_yield
    end

    it 'prompt wrong input message' do
      expect { subject.execute }.to output(wrong_input_msg).to_stdout
    end
  end
end