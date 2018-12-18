module Coreference
  def coreferences
    self.xpath("//coreference//coreference").map{|c| coref_nok_to_blob(c)}
  end

  def coreferences_with_pos
    self.xpath("//coreference//coreference").map{|c| coref_nok_to_blob(c, true)}
  end

  def coref_nok_to_blob input, with_pos_tags=nil
    {
      representative: coref_representative_nok_to_blob(input, with_pos_tags),
      mentions: coref_mentions_nok_to_blob(input, with_pos_tags)
    }
  end

  def coref_representative_nok_to_blob input, with_pos_tags=nil   
    coref_mention_nok_to_blob(
      input
      .children
      .select{|m| 
        m.name == 'mention' && m.attributes['representative'] 
      }
      .first,
      false,
      with_pos_tags
    )
  end

  def coref_mentions_nok_to_blob input, with_pos_tags=nil
    input
    .children
    .select{|m|
      m.name == 'mention'
    }
    .map{|m| coref_mention_nok_to_blob(m, true, with_pos_tags)}
  end

  def coref_mention_nok_to_blob input, add_representative_flag=nil, with_pos_tags=nil
    add_representative_flag ? 
      with_representative_flag(
        coref_mention(input, with_pos_tags),
        input
      ) : 
      coref_mention(input, with_pos_tags)
  end

  def coref_mention input, with_pos_tags=nil
    coref_blob = Hash[
      input
      .children
      .select{|v| v.class == Nokogiri::XML::Element}
      .map{|v| [v.name.to_sym, to_i_based_on_field_name(v.text, v.name)]}
    ]
    with_pos_tags ? add_pos_tags_to(coref_blob) : coref_blob 
  end

  def with_representative_flag input, parent
    parent.name == 'mention' && parent.attributes['representative'] ? 
      input.merge({ representative: true }) : input
  end

  def to_i_based_on_field_name input, field_name
    field_name == 'text' ? input : input.to_i
  end

  def add_pos_tags_to coref_blob
    coref_blob.merge({
      pos: self
        .sentences[coref_blob[:sentence] - 1]
        .tokens
        .each_with_index
        .select{|s, i| i >= coref_blob[:start] - 1 && i < coref_blob[:end] - 1 }
        .map{|t, i| t.pos.text }
    })
  end
end