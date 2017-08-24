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

class Car < ApplicationRecord
  before_validation :upper, :check_vin

  validates :make, :model, :year, :vin, presence: true
  validates :vin, length: {is: 17}
  validates :vin, uniqueness: true
  validates :make, uniqueness: {scope: [:model, :year]}
  validates :year, inclusion: {in: 1900..2020, message: 'is not between 1900 and 2020'}
  validates :category, inclusion: {in: ['CAR', 'SPORT', 'SUV', 'TRUCK']}
  validates :cylinders, inclusion: {in: [4, 6, 8, 12], message: 'is not one of 4, 6, 8 or 12'}

  private

  def upper
    self.vin = self.vin.upcase if self.vin
    self.category = self.category.upcase if self.category
  end

  def check_vin
    self.errors.add(:vin, 'invalid representation') if self.vin && self.vin !~ /^[0-9A-Z]{17}$/
  end
end