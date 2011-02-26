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
  field :types,       :type => Array,   :default => []
  field :times_eaten, :type => Integer, :default => 0
  field :approved,    :type => Boolean, :default => false

  attr_accessible :name, :types

  validates :name,  :length  => {:in => 2..100}
  validates :types, :subset  => {:in => @@valid_types}

  before_save :set_letter

  def self.valid_types
    @@valid_types
  end

  def set_letter
    self.letter = self.name.first
  end
end
