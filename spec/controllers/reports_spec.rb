# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #place' do
    it 'redirects to index with correct parameters' do
      get :place, params: { row: 1, column: 2, direction: 'NORTH' }
      expect(response).to redirect_to(action: :index, row: 1, column: 2, direction: 'NORTH')
    end
  end

  describe 'GET #move' do
    it 'redirects to index with updated position' do
      get :move, params: { row: 0, column: 1, direction: 'SOUTH' }
      expect(response).to redirect_to(action: :index, row: 0, column: 2, direction: 'SOUTH')
    end
  end

  describe 'GET #change_direction' do
    it 'redirects to index with updated direction' do
      get :change_direction, params: { row: 1, column: 2, direction: 'NORTH', command: 'LEFT' }
      expect(response).to redirect_to(action: :index, row: 1, column: 2, direction: 'WEST')
    end
  end
end