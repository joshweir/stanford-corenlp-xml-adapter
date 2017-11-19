require "spec_helper"
require "stanford_corenlp_xml_adapter"

RSpec.describe StanfordCorenlpXmlAdapter do
  it "has a version number" do
    expect(StanfordCorenlpXmlAdapter::VERSION).not_to be nil
  end

  describe ".doc" do
    it "returns a Nokogiri object" do
      expect(StanfordCorenlpXmlAdapter.doc(valid_xml).class)
        .to eq Nokogiri::XML::Document
    end

    it "raises exception if the input doc is not " +
        "empty and not valid xml" do
      expect{StanfordCorenlpXmlAdapter.doc(invalid_xml)}
        .to raise_exception StanfordCorenlpXmlAdapter::InvalidXML
    end

    it "raises exception if the input doc does not " +
        "contain <document> node" do
      expect{StanfordCorenlpXmlAdapter.doc(valid_xml_no_doc)}
        .to raise_exception StanfordCorenlpXmlAdapter::InvalidXML
    end
  end
end
