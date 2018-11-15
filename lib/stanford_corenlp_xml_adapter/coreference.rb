module Coreference
  def coreferences
    self.xpath("//coreference//coreference").map{|c| coref_nok_to_blob(c)}
  end

  def coref_nok_to_blob input
    {
      representative: coref_representative_nok_to_blob(input),
      mentions: coref_mentions_nok_to_blob(input)
    }
  end

  def coref_representative_nok_to_blob input      
    coref_mention_nok_to_blob(
      input
      .children
      .select{|m| 
        m.name == 'mention' && m.attributes['representative'] 
      }
      .first
    )
  end

  def coref_mentions_nok_to_blob input    
    input
    .children
    .select{|m|
      m.name == 'mention'
    }
    .map{|m| coref_mention_nok_to_blob(m, true)}
  end

  def coref_mention_nok_to_blob input, add_representative_flag=nil
    add_representative_flag ? 
      with_representative_flag(
        coref_mention(input),
        input
      ) : 
      coref_mention(input)
  end

  def coref_mention input
    Hash[
      input
      .children
      .select{|v| v.class == Nokogiri::XML::Element}
      .map{|v| [v.name.to_sym, to_i_based_on_field_name(v.text, v.name)]}
    ]
  end

  def with_representative_flag input, parent
    parent.name == 'mention' && parent.attributes['representative'] ? 
      input.merge({ representative: true }) : input
  end

  def to_i_based_on_field_name input, field_name
    field_name == 'text' ? input : input.to_i
  end
end