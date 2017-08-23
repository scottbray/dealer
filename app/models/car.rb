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
    before_validation :upper_vin, :check_vin
    
    validates :make, :model, :year, :vin, presence: true
    validates :vin, length: {is: 17}
    
    private
    
    def upper_vin
        self.vin = self.vin.upcase if self.vin
    end
    
    def check_vin
        self.errors.add(:vin, 'invalid representation') if self.vin && self.vin !~ /^[0-9A-Z]{17}$/
    end
end
