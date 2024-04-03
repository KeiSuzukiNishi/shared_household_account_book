class ErrorsController < ApplicationController
    def not_found
      render status: :not_found, template: 'errors/not_found'
    end
  end