# frozen_string_literal: true

class ReportsController < ApplicationController
  def index; end

  def place
    redirect_to action: :index, row: params[:row], column: params[:column], direction: params[:direction]
  end

  def move
    row, column = Report::Move.call(params[:row].to_i, params[:column].to_i, params[:direction])
    redirect_to action: :index, row: row, column: column, direction: params[:direction]
  end

  def change_direction
    direction = Report::Rotate.call(params[:command], params[:direction])
    redirect_to action: :index, row: params[:row], column: params[:column], direction: direction
  end
end
