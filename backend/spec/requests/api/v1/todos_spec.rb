require 'swagger_helper'

RSpec.describe 'api/v1/todos', type: :request do

  path '/api/v1/todos' do

    get 'get todo list' do
      consumes 'application/json'
      produces 'application/json'
      response 200, 'todo list' do
        schema type: :array, items: {
          type: :object,
          properties: {
            name: { type: :string },
            done: { type: :boolean },
          },
          required: [:name, :done]
        }
        run_test!
      end
    end
  end
end
