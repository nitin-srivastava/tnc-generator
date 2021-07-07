require 'spec_helper'
require_relative '../lib/document_parser'

RSpec.describe DocumentParser do
  let(:clauses) do
    [{"id"=>1, "text"=>"The quick brown fox"},
     {"id"=>2, "text"=>"jumps over the lazy dog"},
     {"id"=>3, "text"=>"And dies"},
     {"id"=>4, "text"=>"The white horse is white"}]
  end
  let(:sections) do
    [{"id"=>1, "clauses_ids"=> [1, 2]},
     {"id"=>2, "clauses_ids"=> [3, 4]},
     {"id"=>3, "clauses_ids"=> [2]},
     {"id"=>4, "clauses_ids"=> [1, 4]}]
  end
  subject { DocumentParser.new(clauses, sections) }

  describe '#initialize' do
    it 'initialize the attrs' do
      expect(subject).to be_a(DocumentParser)
      expect(subject.clauses_hash).not_to be_nil
      expect(subject.sections_hash).not_to be_nil
    end
  end

  describe '#parse' do
    context 'when successful then' do
      it 'returns the contents' do
        content = subject.parse('spec/files/valid_template.txt')
        expect(content).to include("A T&C Document\n")
        expect(content).to include("This document is made of plaintext.\n")
        expect(content).to include("Is made of And dies.\n")
        expect(content).to include("Is made of The white horse is white.\n")
        expect(content).to include("Is made of The quick brown fox;jumps over the lazy dog.\n")
        expect(content).to include("Your legals.")
      end
    end

    context 'when template has no tags then' do
      it 'returns the contents' do
        content = subject.parse('spec/files/template_without_tags.txt')
        expect(content).to include("A T&C Document\n")
        expect(content).to include("This document is made of plaintext.\n")
        expect(content).to include("Your legals.")
      end
    end

    context 'when an invalid CLAUSE exist then' do
      it 'raise the error' do
        expect do
          subject.parse('spec/files/template_with_invalid_clause.txt')
        end.to output("\nDocument Parse Error:: Invalid tag [CLAUSE-8] in line 3.\n").to_stdout
      end
    end

    context 'when an invalid SECTION exist then' do
      it 'raise the error' do
        expect do
          subject.parse('spec/files/template_with_invalid_section.txt')
        end.to output("\nDocument Parse Error:: Invalid tag [SECTION-5] in line 3.\n").to_stdout
      end
    end
  end

  describe 'generate' do
    let(:content) { subject.parse('spec/files/valid_template.txt') }
    let(:file_name) { 'spec/files/tnc_document.txt' }
    after do
      File.delete(file_name) if File.exist?(file_name)
    end

    context 'successful' do
      before do
        expect(File.exist?(file_name)).to be_falsey
        subject.generate(content)
      end

      it 'generates a tnc_document.txt file having passed contents' do
        expect(File.exist?(file_name)).to be_truthy
        expect(File.open(file_name).read).to eq(content)
      end
    end

    context 'unsuccessful' do
      before do
        allow(File).to receive(:open).and_raise(StandardError.new("Something went wrong."))
      end

      it 'generates a tnc_document.txt file having passed contents' do
        expect do
          subject.generate('Test message')
        end.to output("\nSomething went wrong.\n").to_stdout
        expect(File.exist?(file_name)).to be_falsey
      end
    end
  end
end