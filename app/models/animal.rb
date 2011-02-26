class Animal
  include Mongoid::Document
  include Mongoid::Timestamps

  @@valid_types = [
    :land,
    :water,
    :air,
  ].freeze

  field :name,        :type => String
  field :letter,      :type => String
  field :type,        :type => Symbol
  field :times_eaten, :type => Integer, :default => 0

  attr_accessible :name, :type

  validates :name, :length    => {:in => 2..100}
  validates :type, :inclusion => {:in => @@valid_types}

  before_save :set_letter

  def self.valid_types
    @@valid_types
  end

  def set_letter
    self.letter = self.name.first
  end
end
