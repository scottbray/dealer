require 'rails_helper'

RSpec.describe CarsController, type: :controller do
    render_views
    
    describe 'GET /cars/:id' do
        it 'displays a car' do
            car1 = Car.first
            get :show, params: {id: car1.id}
            car2 = assigns(:car)
            expect(car2.id).to eql(car1.id)
            expect(response.status).to eql(200)
            expect(response.body).to include(car2.vin)
        end
        
    end
end
