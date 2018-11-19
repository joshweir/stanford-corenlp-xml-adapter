require "nokogiri"
require "stanford_corenlp_xml_adapter/version"
require "stanford_corenlp_xml_adapter/nokogiri_misc_mixins"
require "stanford_corenlp_xml_adapter/coreference"
require "stanford_corenlp_xml_adapter/dependency_parse"

include DependencyParse

class Nokogiri::XML::Document
  include NokogiriMiscellaneousMixins
  include Coreference
end

class Nokogiri::XML::Element
  include NokogiriMiscellaneousMixins
  #include DependencyParse
end

module StanfordCorenlpXmlAdapter
  class InvalidXML < StandardError; end

  class << self
    def doc doc
      begin
        doc = Nokogiri::XML(doc) {|config| config.strict}
      rescue Nokogiri::XML::SyntaxError => e
        raise InvalidXML, "#{e.message} xml: #{doc}"
      end
      raise InvalidXML,
            "document node does not exist! xml: #{doc}" unless
        document_node_exists?(doc)
      doc
    end

    private

    def document_node_exists? doc
      doc.xpath("//root//document").length > 0
    end
  end
end
