# == Schema Information
#
# Table name: cars
#
#  id           :integer          not null, primary key
#  make         :string           not null
#  model        :string           not null
#  year         :integer          not null
#  vin          :string           not null
#  color        :string           default("black")
#  category     :string           default("car")
#  cylinders    :integer          default(4)
#  displacement :float            default(0.0)
#  mpg          :integer          default(0)
#  hp           :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Car, type: :model do
  describe '.new' do
    it 'instantiates a Car object' do
      c = Car.new
      expect(c.is_a?(Car)).to be true
      expect(c.attributes.keys.count).to eql(13)
    end
  end

  describe '#save' do
    context 'happy path' do
      it 'saves a car' do
        c = Car.new(make: 'Ford', model: 'Fusion', year: 2015, vin: '0123456789abcdefg', category: 'car', cylinders: 4)
        c.save
        expect(c.id).to_not be_nil
        expect(c.vin).to eql('0123456789ABCDEFG')
        expect(c.category).to eql('CAR')
        expect(c.created_at).to_not be_nil
        expect(c.updated_at).to_not be_nil
      end
    end
    context 'invalid data' do
      it 'missing model, year - will not save' do
        c = Car.new(make: 'Ford', vin: 'abcd')
        c.save
        expect(c.id).to be_nil
        expect(c.errors[:model].first).to eql("can't be blank")
        expect(c.errors[:year].first).to eql("can't be blank")
      end
      it 'vin number is too short - will not save' do
        c = Car.new(make: 'Ford', model: 'Fusion', year: 2015, vin: 'abcd')
        c.save
        expect(c.id).to be_nil
        expect(c.errors[:vin].second).to eql("is the wrong length (should be 17 characters)")
      end
      it 'vin number has incorrect syntax - will not save' do
        c = Car.new(make: 'Ford', model: 'Fusion', year: 2015, vin: '*12345678@ABC#EFZ')
        c.save
        expect(c.id).to be_nil
        expect(c.errors[:vin].first).to eql("invalid representation")
      end
      it 'vin number already taken - will not save' do
        c = Car.new(make: 'Ford', model: 'Fusion', year: 2015, vin: 'A0000000000000001')
        c.save
        expect(c.id).to be_nil
        expect(c.errors[:vin].first).to eql("has already been taken")
      end
      it 'make, model, year already taken - will not save' do
        c = Car.new(make: 'Toyota', model: 'Camry', year: 2015, vin: 'B0000000000000001')
        c.save
        expect(c.id).to be_nil
        expect(c.errors[:make].first).to eql("has already been taken")
      end
      it 'year is too old - will not save' do
        c = Car.new(make: 'Toyota', model: 'Camry', year: 1800, vin: 'B0000000000000001')
        c.save
        expect(c.id).to be_nil
        expect(c.errors[:year].first).to eql("is not between 1900 and 2020")
      end
      it 'category is invalid - will not save' do
        c = Car.new(make: 'Toyota', model: 'Camry', year: 1800, vin: 'B0000000000000001', category: 'bad')
        c.save
        expect(c.id).to be_nil
        expect(c.errors[:category].first).to eql("is not included in the list")
      end
      it 'cylinders is invalid - will not save' do
        c = Car.new(make: 'Toyota', model: 'Camry', year: 1800, vin: 'B0000000000000001', cylinders: 5)
        c.save
        expect(c.id).to be_nil
        expect(c.errors[:cylinders].first).to eql("is not one of 4, 6, 8 or 12")
      end
    end
  end
end