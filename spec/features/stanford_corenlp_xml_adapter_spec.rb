require "spec_helper"
require "stanford_corenlp_xml_adapter"

module StanfordCorenlpXmlAdapter
  RSpec.describe StanfordCorenlpXmlAdapter do
    let(:valid_doc) { StanfordCorenlpXmlAdapter.doc valid_xml }
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

    it "extracts words from a doc" do
      expected = ["Hello", "world", "!", "I", "am", "Josh", "."]
      expect(valid_doc._words.map{|t| t.text}).to eq expected
    end

    it "extracts tokens from a sentence" do
      expected = ["I", "am", "Josh", "."]
      expect(valid_doc
              .sentences[1]
              .tokens
              .map{|t| t._word.text})
        .to eq expected
    end

    it "extracts a part-of-speech tag from a token" do
      expected = ["PRP", "VBP", "NNP", "."]
      expect(valid_doc
              .sentences[1]
              .tokens
              .map{|t| t.pos.text})
        .to eq expected
    end

    it "extracts a ner tag from a token" do
      expected = ["O", "O", "PERSON", "O"]
      expect(valid_doc
              .sentences[1]
              .tokens
              .map{|t| t.ner.text})
        .to eq expected
    end

    it "extracts the dependency parsed basic-dependencies" do
      expected = [
        {
          type: 'root',
          governor: {
            idx: 0,
            value: 'ROOT'
          },
          dependent: {
            idx: 3,
            value: 'Josh'
          }
        },
        {
          type: 'nsubj',
          governor: {
            idx: 3,
            value: 'Josh'
          },
          dependent: {
            idx: 1,
            value: 'I'
          }
        },
        {
          type: 'cop',
          governor: {
            idx: 3,
            value: 'Josh'
          },
          dependent: {
            idx: 2,
            value: 'am'
          }
        }
      ]
      expect(valid_doc
              .sentences[1]
              .basic_dependencies)
        .to eq expected
    end

    it "extracts the dependency parsed collapsed-dependencies" do
      expected = [
        {
          type: 'root',
          governor: {
            idx: 0,
            value: 'ROOT'
          },
          dependent: {
            idx: 3,
            value: 'Josh'
          }
        },
        {
          type: 'nsubj',
          governor: {
            idx: 3,
            value: 'Josh'
          },
          dependent: {
            idx: 1,
            value: 'I'
          }
        },
        {
          type: 'cop',
          governor: {
            idx: 3,
            value: 'Josh'
          },
          dependent: {
            idx: 2,
            value: 'am'
          }
        }
      ]
      expect(valid_doc
              .sentences[1]
              .collapsed_dependencies)
        .to eq expected
    end

    it "extracts the dependency parsed collapsed-ccprocessed-dependencies" do
      expected = [
        {
          type: 'root',
          governor: {
            idx: 0,
            value: 'ROOT'
          },
          dependent: {
            idx: 3,
            value: 'Josh'
          }
        },
        {
          type: 'nsubj',
          governor: {
            idx: 3,
            value: 'Josh'
          },
          dependent: {
            idx: 1,
            value: 'I'
          }
        },
        {
          type: 'cop',
          governor: {
            idx: 3,
            value: 'Josh'
          },
          dependent: {
            idx: 2,
            value: 'am'
          }
        }
      ]
      expect(valid_doc
              .sentences[1]
              .collapsed_ccprocessed_dependencies)
        .to eq expected
    end

    it "extracts the dependency parsed enhanced-dependencies" do
      expected = [
        {
          type: 'root',
          governor: {
            idx: 0,
            value: 'ROOT'
          },
          dependent: {
            idx: 3,
            value: 'Josh'
          }
        },
        {
          type: 'nsubj',
          governor: {
            idx: 3,
            value: 'Josh'
          },
          dependent: {
            idx: 1,
            value: 'I'
          }
        },
        {
          type: 'cop',
          governor: {
            idx: 3,
            value: 'Josh'
          },
          dependent: {
            idx: 2,
            value: 'am'
          }
        }
      ]
      expect(valid_doc
              .sentences[1]
              .enhanced_dependencies)
        .to eq expected
    end

    it "extracts the dependency parsed enhanced-plus-plus-dependencies" do
      expected = [
        {
          type: 'root',
          governor: {
            idx: 0,
            value: 'ROOT'
          },
          dependent: {
            idx: 3,
            value: 'Josh'
          }
        },
        {
          type: 'nsubj',
          governor: {
            idx: 3,
            value: 'Josh'
          },
          dependent: {
            idx: 1,
            value: 'I'
          }
        },
        {
          type: 'cop',
          governor: {
            idx: 3,
            value: 'Josh'
          },
          dependent: {
            idx: 2,
            value: 'am'
          }
        }
      ]
      expect(valid_doc
              .sentences[1]
              .enhanced_plus_plus_dependencies)
        .to eq expected
    end

    it "extracts the coreferences" do
      expected = [
        {
          representative: {
            sentence: 2,
            start: 3,
            end: 4,
            head: 3,
            text: "Josh"
          },
          mentions: [
            {
              sentence: 2,
              start: 3,
              end: 4,
              head: 3,
              text: "Josh",
              representative: true
            },
            {
              sentence: 2,
              start: 1,
              end: 2,
              head: 1,
              text: "I"
            }
          ]
        }
      ]
      expect(valid_doc.coreferences)
        .to eq expected
    end
  end
end
