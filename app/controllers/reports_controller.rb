# frozen_string_literal: true

class ReportsController < ApplicationController
  def index; end

  def place
    redirect_with_params(params[:row], params[:column], params[:direction])
  end

  def move
    row, column = Report::Move.call(params[:row].to_i, params[:column].to_i, params[:direction])
    redirect_with_params(row, column, params[:direction])
  end

  def change_direction
    direction = Report::Rotate.call(params[:command], params[:direction])
    redirect_with_params(params[:row], params[:column], direction)
  end

  private

  def redirect_with_params(row, column, direction)
    redirect_to action: :index, row: row, column: column, direction: direction
  end
end
