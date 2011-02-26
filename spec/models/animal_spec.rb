require 'spec_helper'

describe Animal do
  it 'includes Mongoid::Document' do
    Animal.should include Mongoid::Document
  end

  it 'includes Mongoid::Timestamps' do
    Animal.should include Mongoid::Timestamps
  end

  it 'stores valid "type" values in @@valid_types' do
    Animal.class_variable_get(:@@valid_types).should == [
      :land,
      :water,
      :air,
    ]
  end

  it { should have_field(:name).of_type String }
  it { should have_field(:letter).of_type String }
  it { should have_field(:type).of_type Symbol }
  it { should have_field(:times_eaten).of_type(Integer).with_default_value_of 0 }

  describe 'field mass-assignment' do # {{{
    it 'allows "name" to be set' do
      Animal.new(:name => 'asdf').name.should == 'asdf'
    end

    it %q(doesn't allow "letter" to be set) do
      Animal.new(:letter => 'x').letter.should_not == 'x'
    end

    it 'allows "type" to be set' do
      Animal.new(:type => :land).type.should equal :land
    end

    it %q(doesn't allow "times_eaten" to be set) do
      Animal.new(:times_eaten => 123).times_eaten.should_not be 123
    end
  end # }}}

  describe '"name" validations' do # {{{
    describe 'with 1 character' do # {{{
      it 'is invalid' do
        Animal.new(:name => 'x').should have(1).error_on :name
      end
    end # }}}

    describe 'with 2 characters' do # {{{
      it 'is invalid' do
        Animal.new(:name => 'xx').should have(0).errors_on :name
      end
    end # }}}

    describe 'with 100 characters' do # {{{
      it 'is invalid' do
        Animal.new(:name => 'x' * 100).should have(0).errors_on :name
      end
    end # }}}

    describe 'with 101 character' do # {{{
      it 'is invalid' do
        Animal.new(:name => 'x' * 101).should have(1).error_on :name
      end
    end # }}}
  end # }}}

  describe '"type" validations' do # {{{
    describe 'with an invalid value' do # {{{
      it 'is invalid' do
        Animal.new(:type => :foo).should have_at_least(1).error_on :type
      end
    end # }}}

    it { should validate_inclusion_of(:type).to_allow Animal.valid_types }
  end # }}}

  describe '.valid_types' do # {{{
    it 'returns @@valid_types' do
      Animal.valid_types.should == Animal.class_variable_get(:@@valid_types)
    end
  end # }}}
end
