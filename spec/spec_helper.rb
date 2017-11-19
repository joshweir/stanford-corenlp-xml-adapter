require "bundler/setup"
require "stanford_corenlp_xml_adapter"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  def valid_xml
    %{<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet href="CoreNLP-to-HTML.xsl" type="text/xsl"?>
<root>
  <document>
    <sentences>
      <sentence id="1" sentimentValue="2" sentiment="Neutral">
        <tokens>
          <token id="1">
            <word>Hello</word>
            <lemma>hello</lemma>
            <CharacterOffsetBegin>0</CharacterOffsetBegin>
            <CharacterOffsetEnd>5</CharacterOffsetEnd>
            <POS>UH</POS>
            <NER>O</NER>
            <Speaker>PER0</Speaker>
          </token>
          <token id="2">
            <word>world</word>
            <lemma>world</lemma>
            <CharacterOffsetBegin>6</CharacterOffsetBegin>
            <CharacterOffsetEnd>11</CharacterOffsetEnd>
            <POS>NN</POS>
            <NER>O</NER>
            <Speaker>PER0</Speaker>
          </token>
          <token id="3">
            <word>!</word>
            <lemma>!</lemma>
            <CharacterOffsetBegin>11</CharacterOffsetBegin>
            <CharacterOffsetEnd>12</CharacterOffsetEnd>
            <POS>.</POS>
            <NER>O</NER>
            <Speaker>PER0</Speaker>
          </token>
        </tokens>
        <parse>(ROOT (S (VP (NP (INTJ (UH Hello)) (NP (NN world)))) (. !))) </parse>
        <dependencies type="basic-dependencies">
          <dep type="root">
            <governor idx="0">ROOT</governor>
            <dependent idx="2">world</dependent>
          </dep>
          <dep type="discourse">
            <governor idx="2">world</governor>
            <dependent idx="1">Hello</dependent>
          </dep>
        </dependencies>
        <dependencies type="collapsed-dependencies">
          <dep type="root">
            <governor idx="0">ROOT</governor>
            <dependent idx="2">world</dependent>
          </dep>
          <dep type="discourse">
            <governor idx="2">world</governor>
            <dependent idx="1">Hello</dependent>
          </dep>
        </dependencies>
        <dependencies type="collapsed-ccprocessed-dependencies">
          <dep type="root">
            <governor idx="0">ROOT</governor>
            <dependent idx="2">world</dependent>
          </dep>
          <dep type="discourse">
            <governor idx="2">world</governor>
            <dependent idx="1">Hello</dependent>
          </dep>
        </dependencies>
      </sentence>
      <sentence id="2" sentimentValue="2" sentiment="Neutral">
        <tokens>
          <token id="4">
            <word>I</word>
            <lemma>I</lemma>
            <POS>UH</POS>
            <NER>O</NER>
            <Speaker>PER0</Speaker>
          </token>
          <token id="5">
            <word>am</word>
            <lemma>am</lemma>
            <POS>NN</POS>
            <NER>O</NER>
            <Speaker>PER0</Speaker>
          </token>
          <token id="6">
            <word>Josh</word>
            <lemma>josh</lemma>
            <POS>NN</POS>
            <NER>O</NER>
            <Speaker>PER0</Speaker>
          </token>
          <token id="7">
            <word>.</word>
            <lemma>.</lemma>
            <POS>.</POS>
            <NER>O</NER>
            <Speaker>PER0</Speaker>
          </token>
        </tokens>
        <parse>(ROOT (S (VP (NP (INTJ (UH Hello)) (NP (NN world)))) (. !))) </parse>
        <dependencies type="basic-dependencies">
          <dep type="root">
            <governor idx="0">ROOT</governor>
            <dependent idx="2">world</dependent>
          </dep>
          <dep type="discourse">
            <governor idx="2">world</governor>
            <dependent idx="1">Hello</dependent>
          </dep>
        </dependencies>
        <dependencies type="collapsed-dependencies">
          <dep type="root">
            <governor idx="0">ROOT</governor>
            <dependent idx="2">world</dependent>
          </dep>
          <dep type="discourse">
            <governor idx="2">world</governor>
            <dependent idx="1">Hello</dependent>
          </dep>
        </dependencies>
        <dependencies type="collapsed-ccprocessed-dependencies">
          <dep type="root">
            <governor idx="0">ROOT</governor>
            <dependent idx="2">world</dependent>
          </dep>
          <dep type="discourse">
            <governor idx="2">world</governor>
            <dependent idx="1">Hello</dependent>
          </dep>
        </dependencies>
      </sentence>
    </sentences>
  </document>
</root>}
  end

  def invalid_xml
    %{This is< invalid xml!}
  end

  def valid_xml_no_doc
    %{<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet href="CoreNLP-to-HTML.xsl" type="text/xsl"?>
<root>
  <notdocument>
    some text..
  </notdocument>
</root>}
  end

  def valid_xml_no_sentences
    %{<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet href="CoreNLP-to-HTML.xsl" type="text/xsl"?>
<root>
  <document>
    dummy text
  </document>
</root>}
  end
end
