require "spec_helper"

RSpec.describe NokogiriMixins do
  let(:valid_doc) {
    StanfordCorenlpXmlAdapter.doc(valid_xml)
  }
  let(:valid_doc_no_sentences) {
    StanfordCorenlpXmlAdapter.doc(valid_xml_no_sentences)
  }

  describe "#sentences" do
    it "extracts sentences from a doc" do
      expected = ["Hello world !", "I am Josh ."]
      expect(valid_doc
              .sentences
              .map{|s| s.xpath("tokens//token//word").map(&:text).join(' ')})
        .to eq expected
    end

    it "returns empty array when no sentences exist" do
      expect(valid_doc_no_sentences.sentences.length).to eq 0
    end
  end
end
