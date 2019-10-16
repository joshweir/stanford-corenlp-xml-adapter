module DependencyParse
  def basic_dependencies(doc, sentence_index)
    dependencies_for_type doc, sentence_index, "basic-dependencies"
  end

  def collapsed_dependencies(doc, sentence_index)
    dependencies_for_type doc, sentence_index, "collapsed-dependencies"
  end

  def collapsed_ccprocessed_dependencies(doc, sentence_index)
    dependencies_for_type doc, sentence_index, "collapsed-ccprocessed-dependencies"
  end

  def enhanced_dependencies(doc, sentence_index)
    dependencies_for_type doc, sentence_index, "enhanced-dependencies"
  end

  def enhanced_plus_plus_dependencies(doc, sentence_index)
    dependencies_for_type doc, sentence_index, "enhanced-plus-plus-dependencies"
  end

  def dependencies_for_type(doc, sentence_index, type)
    sentence = doc.sentences[sentence_index]
    sentence_tokens = sentence.tokens
    dependency_parse_nok_to_blob(
      sentence.xpath(".//dependencies[@type=\"#{type}\"]"),
      sentence_tokens.map { |t| t.pos.text },
      sentence_tokens.map { |t| t.ner.text },
    )
  end

  def dependency_parse_nok_to_blob(dep_parse_input, pos_tags_input, ner_tags_input)
    dep_parse_input
      .children
      .select { |dep| dep.name == "dep" }
      .each_with_index
      .map { |dep| dependency_nok_to_blob(dep, pos_tags_input, ner_tags_input) }
  end

  def dependency_nok_to_blob(dep_parse_input, pos_tags_input, ner_tags_input)
    {
      type: dep_parse_input.attributes["type"].value,
      extra: dep_parse_input.attributes["extra"].value,
      governor: dependency_slice_nok_to_blob(
        "governor", dep_parse_input, pos_tags_input, ner_tags_input
      ),
      dependent: dependency_slice_nok_to_blob(
        "dependent", dep_parse_input, pos_tags_input, ner_tags_input
      ),
    }
  end

  def dependency_slice_nok_to_blob(name, dep_parse_input, pos_tags_input, ner_tags_input)
    dep = dep_parse_input.children
      .select { |dep| dep.name == name }
      .first
    idx = dep.attributes["idx"].value.to_i
    pos = idx > 0 ? pos_tags_input[idx - 1] : nil
    ner = idx > 0 && ner_tags_input[idx - 1] != "O" ? ner_tags_input[idx - 1] : nil
    {
      idx: idx,
      value: dep.text,
      pos: pos,
      ner: ner,
    }
  end
end
