require "spec_helper"

RSpec.describe NokogiriMiscellaneousMixins do
  let(:valid_doc) {
    StanfordCorenlpXmlAdapter.doc valid_xml
  }
  let(:valid_doc_no_sentences) {
    StanfordCorenlpXmlAdapter.doc valid_xml_no_sentences
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

  describe "#tokens" do
    it "extracts tokens from a doc" do
      expected = ["Hello", "world", "!", "I", "am", "Josh", "."]
      expect(valid_doc.tokens.map{|t| t.xpath(".//word").text}).to eq expected
    end

    it "extracts tokens from a sentence" do
      expected = ["I", "am", "Josh", "."]
      expect(valid_doc
              .sentences[1]
              .tokens
              .map{|t| t.xpath(".//word").text})
        .to eq expected
    end

    it "returns empty array when no tokens exist" do
      expect(valid_doc_no_sentences.tokens.length).to eq 0
    end
  end

  describe "#_words" do
    it "extracts words from a doc" do
      expected = ["Hello", "world", "!", "I", "am", "Josh", "."]
      expect(valid_doc._words.map{|t| t.text}).to eq expected
    end

    it "returns empty array when no words exist" do
      expect(valid_doc_no_sentences._words.length).to eq 0
    end
  end

  describe "#_word" do
    it "extracts a word from a token" do
      expected = ["I", "am", "Josh", "."]
      expect(valid_doc
              .sentences[1]
              .tokens
              .map{|t| t._word.text})
        .to eq expected
    end
  end

  describe "#pos" do
    it "extracts a part-of-speech tag from a token" do
      expected = ["PRP", "VBP", "NNP", "."]
      expect(valid_doc
              .sentences[1]
              .tokens
              .map{|t| t.pos.text})
        .to eq expected
    end
  end

  it "extracts a ner tag from a token" do
    expected = ["O", "O", "PERSON", "O"]
    expect(valid_doc
            .sentences[1]
            .tokens
            .map{|t| t.ner.text})
      .to eq expected
  end
end
