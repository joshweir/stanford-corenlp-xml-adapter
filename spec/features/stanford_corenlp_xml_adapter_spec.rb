require "spec_helper"
require "stanford_corenlp_xml_adapter"

module StanfordCorenlpXmlAdapter
  RSpec.describe StanfordCorenlpXmlAdapter do
    let(:valid_doc) { StanfordCorenlpXmlAdapter.doc(valid_xml) }
    it "extracts sentences from a doc" do
      expected = ["Hello world !", "I am Josh ."]
      expect(valid_doc
              .sentences
              .map{|s| s.xpath("tokens//token//word").map(&:text).join(' ')})
        .to eq expected
    end

    it "extracts tokens from a doc" do
      expected = ["Hello", "world", "!", "I", "am", "Josh", "."]
      expect(valid_doc.tokens.map{|t| t._word.text}).to eq expected
    end

    it "extracts tokens from a sentence" do
      expected = ["I", "am", "Josh", "."]
      expect(valid_doc
              .sentences[1]
              .tokens
              .map{|t| t._word.text})
        .to eq expected
    end

    it "extracts part-of-speech tag from a token"
  end
end
