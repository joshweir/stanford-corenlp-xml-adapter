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
          <token id="1">
            <word>I</word>
            <lemma>I</lemma>
            <CharacterOffsetBegin>13</CharacterOffsetBegin>
            <CharacterOffsetEnd>14</CharacterOffsetEnd>
            <POS>PRP</POS>
            <NER>O</NER>
            <Speaker>PER0</Speaker>
          </token>
          <token id="2">
            <word>am</word>
            <lemma>be</lemma>
            <CharacterOffsetBegin>15</CharacterOffsetBegin>
            <CharacterOffsetEnd>17</CharacterOffsetEnd>
            <POS>VBP</POS>
            <NER>O</NER>
            <Speaker>PER0</Speaker>
          </token>
          <token id="3">
            <word>Josh</word>
            <lemma>Josh</lemma>
            <CharacterOffsetBegin>18</CharacterOffsetBegin>
            <CharacterOffsetEnd>22</CharacterOffsetEnd>
            <POS>NNP</POS>
            <NER>PERSON</NER>
            <Speaker>PER0</Speaker>
          </token>
          <token id="4">
            <word>.</word>
            <lemma>.</lemma>
            <CharacterOffsetBegin>22</CharacterOffsetBegin>
            <CharacterOffsetEnd>23</CharacterOffsetEnd>
            <POS>.</POS>
            <NER>O</NER>
            <Speaker>PER0</Speaker>
          </token>
        </tokens>
        <parse>(ROOT (S (NP (PRP I)) (VP (VBP am) (NP (NNP Josh))) (. .))) </parse>
        <dependencies type="basic-dependencies">
          <dep type="root">
            <governor idx="0">ROOT</governor>
            <dependent idx="3">Josh</dependent>
          </dep>
          <dep type="nsubj">
            <governor idx="3">Josh</governor>
            <dependent idx="1">I</dependent>
          </dep>
          <dep type="cop">
            <governor idx="3">Josh</governor>
            <dependent idx="2">am</dependent>
          </dep>
        </dependencies>
        <dependencies type="collapsed-dependencies">
          <dep type="root">
            <governor idx="0">ROOT</governor>
            <dependent idx="3">Josh</dependent>
          </dep>
          <dep type="nsubj">
            <governor idx="3">Josh</governor>
            <dependent idx="1">I</dependent>
          </dep>
          <dep type="cop">
            <governor idx="3">Josh</governor>
            <dependent idx="2">am</dependent>
          </dep>
        </dependencies>
        <dependencies type="collapsed-ccprocessed-dependencies">
          <dep type="root">
            <governor idx="0">ROOT</governor>
            <dependent idx="3">Josh</dependent>
          </dep>
          <dep type="nsubj">
            <governor idx="3">Josh</governor>
            <dependent idx="1">I</dependent>
          </dep>
          <dep type="cop">
            <governor idx="3">Josh</governor>
            <dependent idx="2">am</dependent>
          </dep>
        </dependencies>
      </sentence>
    </sentences>
    <coreference>
      <coreference>
        <mention representative="true">
          <sentence>2</sentence>
          <start>3</start>
          <end>4</end>
          <head>3</head>
          <text>Josh</text>
        </mention>
        <mention>
          <sentence>2</sentence>
          <start>1</start>
          <end>2</end>
          <head>1</head>
          <text>I</text>
        </mention>
      </coreference>
    </coreference>
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
