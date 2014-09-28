class InterpretData
  RAW = {
    "John Ferguson" => "john.ferguson@alphasights.com",
    "Damon Aw" => "damon.aw@alphasights.com",
    "Linda Li" => "linda.li@alphasights.com",
    "Larry Page" => "larry.p@google.com",
    "Sergey Brin" => "s.brin@google.com",
    "Steve Jobs" => "s.j@apple.com"
  }

  def uniq_patterns
    initial_results.each_with_object({}) do |(domain, patterns), results|
      results[domain] = patterns.uniq
    end
  end

  private

  def initial_results
    RAW.each_with_object({}) do |(name, email), results|
      part_address, domain = email.split('@')
      first_name = part_address.split('.')[0]
      last_name = part_address.split('.')[1]
      results[domain] ||= []
      results[domain] << case
      when first_name.length > 1 && last_name.length > 1
        'first_name_dot_last_name'
      when first_name.length > 1 && last_name.length == 1
        'first_name_dot_last_initial'
      when first_name.length == 1 && last_name.length > 1
        'first_initial_dot_last_name'
      when first_name.length == 1 && last_name.length == 1
        'first_initial_dot_last_initial'
      else
        nil
      end
    end
  end

end

#InterpretData.new.uniq_patterns
