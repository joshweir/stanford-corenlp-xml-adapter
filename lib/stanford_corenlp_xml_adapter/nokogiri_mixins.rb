module NokogiriMixins
  def sentences
    self.xpath("//sentences//sentence")
  end

  def tokens
    self.xpath(".//tokens//token")
  end

  def _words
    self.xpath(".//word")
  end

  def _word
    self.at_xpath(".//word")
  end

  def pos
    self.at_xpath(".//POS")
  end

  def ner
    self.at_xpath(".//NER")
  end
end
