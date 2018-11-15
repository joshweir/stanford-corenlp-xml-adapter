module DependencyParse
  def basic_dependencies
    dependencies_for_type 'basic-dependencies'
  end

  def collapsed_dependencies
    dependencies_for_type 'collapsed-dependencies'
  end

  def collapsed_ccprocessed_dependencies
    dependencies_for_type 'collapsed-ccprocessed-dependencies'
  end

  def collapsed_ccprocessed_dependencies
    dependencies_for_type 'collapsed-ccprocessed-dependencies'
  end

  def enhanced_dependencies
    dependencies_for_type 'enhanced-dependencies'
  end

  def enhanced_plus_plus_dependencies
    dependencies_for_type 'enhanced-plus-plus-dependencies'
  end

  def dependencies_for_type type
    dependency_parse_nok_to_blob(
      self.xpath(".//dependencies[@type=\"#{type}\"]")
    )
  end

  def dependency_parse_nok_to_blob input
    input
    .children
    .select{|dep| dep.name == 'dep'}
    .map{|dep| dependency_nok_to_blob(dep)}
  end

  def dependency_nok_to_blob input
    {
      type: input.attributes['type'].value,
      governor: dependency_slice_nok_to_blob('governor', input),
      dependent: dependency_slice_nok_to_blob('dependent', input)
    }
  end

  def dependency_slice_nok_to_blob name, input
    dep = input.children
      .select{|dep| dep.name == name}
      .first
    {
      idx: dep.attributes['idx'].value.to_i,
      value: dep.text
    }
  end
end