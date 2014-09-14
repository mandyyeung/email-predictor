require 'json'

class GenerateSeeds
  def data_array
    file = File.read('db/advisors.json')
    data = JSON.parse(file)
    data.inject([]) do |array, advisor| # advisor = [name, email]
      array << Hash[*advisor[1].split('@').reverse.flatten]
      array # [["alphasights.com", "john.ferguson"],...]
    end
  end

  def find_pattern(format)
    name = format.split('.')
    case
    when (name[0].length > 1 && name[1].length > 1)
      'first_name.last_name'
    when name[0].length > 1 && name[1].length == 1
      'first_name.last_initial'
    when name[0].length == 1 && name[1].length > 1
      'first_initial.last_name'
    else
      'first_initial.last_initial'
    end
  end

  def company_formats
    data = data_array
    data.each do |advisor|
      advisor.each_pair do |domain, name|
        advisor[domain] = find_pattern(name)
      end
    end
    data.uniq # [{"alphasights.com"=>"first_name.last_name"},...]
  end

  def seed_data
    data = company_formats
    data.inject([]) do |seed_data, hash|
      seed_data << %{Domain.where(domain: '#{hash.keys.first}').first_or_create.patterns << Pattern.where(pattern: '#{hash.values.first}').first_or_create}
      seed_data
    end
  end

  def write_seeds
    File.open('db/seeds.rb', 'w+') do |f|
      f.puts seed_data
    end
  end
end

GenerateSeeds.new.write_seeds
