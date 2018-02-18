require 'rails_helper'

describe ProductsController do
  describe 'GET index' do
    let!(:product1) { create :product }
    let!(:product2) { create :product }

    it 'assigns @products' do
      get :index
      expect(assigns(:products)).to eq [product1, product2]
    end
  end
end