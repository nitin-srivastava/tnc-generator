# DocumentParser class will parse the template
# rails errors if something went wrong
# and return the content to generate the document
require 'byebug'
class DocumentParser
  attr_accessor :clauses_hash, :sections_hash

  def initialize(clauses, sections)
    @clauses_hash = clauses
    @sections_hash = sections
  end
end