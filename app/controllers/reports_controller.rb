# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
  end

  def place
    redirect_to action: :index, row: params[:row], column: params[:column], direction: params[:direction]
  end

  def move
    row, column = Report::Move.call(params[:row].to_i, params[:column].to_i, params[:direction])
    redirect_to action: :index, row: row, column: column, direction: params[:direction]
  end

  def right
    direction = Report::Rotate.call('RIGHT', params[:direction])
    redirect_to action: :index, row: params[:row], column: params[:column], direction: direction
  end

  def left
    direction = Report::Rotate.call('LEFT', params[:direction])
    redirect_to action: :index, row: params[:row], column: params[:column], direction: direction
  end
end
