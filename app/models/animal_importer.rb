class AnimalImporter
  attr_reader :filename

  def initialize(filename)
    raise ArgumentError, 'The "filename" arg must be a String' unless filename.is_a? String
    raise ArgumentError, 'The "filename" arg must be a readable file' unless File.readable? filename

    @filename = filename
  end

  def import
    animals = File.open(@filename).readlines

    animals.each do |animal|
      animal.chomp!
      name, type = animal.split /,/
      name.downcase!
      type = type.to_sym

      if Animal.where(:name => name).count > 0
        puts "Skipping #{name} (#{type})"
        next
      end

      new_animal          = Animal.new :name => name, :type => type
      new_animal.approved = true
      new_animal.save

      puts "Failed to create #{name} (#{type}): #{new_animal.errors}" unless new_animal.persisted?
    end
  end
end
