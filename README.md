# stanford-corenlp-xml-adapter

[![Build Status](https://travis-ci.org/joshweir/stanford-corenlp-xml-adapter.svg?branch=master)](https://travis-ci.org/joshweir/stanford-corenlp-xml-adapter) [![Coverage Status](https://coveralls.io/repos/github/joshweir/stanford-corenlp-xml-adapter/badge.svg?branch=master)](https://coveralls.io/github/joshweir/stanford-corenlp-xml-adapter?branch=master)

Nokogiri based Ruby adapter to the output returned by Stanford CoreNLP XML Server.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stanford_corenlp_xml_adapter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stanford_corenlp_xml_adapter

## Usage

Stanford CoreNLP XML Server output:

```ruby
xml_str =
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
```

Retrieve the doc as a Nokogiri object:

```ruby
doc = StanfordCorenlpXmlAdapter.doc xml_str
```

Search the `doc`:

```ruby
#doc sentences
doc.sentences

#doc tokens
doc.tokens

#tokens within a particular sentence
tokens = doc.sentences[1].tokens

#token word
tokens[0]._word
#token part-of-speech
tokens[0].pos
#token ner
tokens[0].ner

#token words within a partiuclar sentence
doc.sentences[1]._words

#doc can be used as a nokogiri object
doc.sentences.map{|s|
  s.xpath("tokens//token//word").map(&:text).join(' ')
}
```

## Development

After checking out the repo, create a docker volume for bundle cache `docker volume create --name bundle_cache` then run `bin/docker-web-dev` to auto install dependencies that are not yet installed and drop you into shell. Then, run `rspec` to run the tests. To run guard: `bin/docker-web-dev-guard`.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joshweir/stanford_corenlp_xml_adapter.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
