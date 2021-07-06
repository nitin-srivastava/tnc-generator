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
end