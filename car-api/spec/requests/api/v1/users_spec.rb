require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  path '/api/v1/users' do
    get('List all users') do
      tags 'Users'
      let(:Authorization) { '<token-here>' }

      response(200, 'Successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'Authentication Failed') do
        let(:Authorization) { 'Invalid' }
        run_test!
      end
    end

    post('Create User') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, required: true, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              name: { type: :string },
              nickname: { type: :string },
              password: { type: :string }
            }
          }
        }
      }

      response(201, 'created') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'Authentication Failed') do
        let(:Authorization) { 'Invalid' }
        run_test!
      end

      response(422, 'Invalid User') do
        let(:user) { 'Invalid' }
        run_test!
      end
    end

    path '/api/v1/users/{id}' do
      parameter name: 'id', in: :path, required: true, type: :string, description: 'id'

      get('Show User') do
        tags 'Users'

        let(:Authorization) { 'Bearer <token-here>' }
        response(200, 'Successful') do
          let(:id) { '12' }
          after do |example|
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end
          run_test!
        end

        response(401, 'Authentication Failed') do
          let(:Authorization) { 'Invalid' }
          run_test!
        end

        response(404, 'User not found') do
          let(:id) { 'Invalid Id' }
          run_test!
        end
      end

      delete('Delete User') do
        tags 'Users'

        response(200, 'Successful') do
          let(:id) { '123' }

          after do |example|
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end
          run_test!
        end
        response(401, 'Authentication Failed') do
          let(:Authorization) { 'Invalid' }
          run_test!
        end

        response(403, 'Only the owner of the user can delete it.') do
          let(:id) { 'Invalid' }
          run_test!
        end
      end

      patch('Update User') do
        tags 'Users'
        consumes 'application/json'
        parameter name: :user, required: false, in: :body, schema: {
          type: :object,
          properties: {
            user: {
              type: :object,
              properties: {
                email: { type: :string },
                name: { type: :string },
                nickname: { type: :string },
                password: { type: :string }
              }
            }
          }
        }

        response(200, 'Successful') do
          let(:id) { '123' }

          after do |example|
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end
          run_test!
        end

        response(401, 'Authentication Failed') do
          let(:Authorization) { 'Invalid' }
          run_test!
        end

        response(422, 'Invalid User') do
          let(:user) { 'Invalid User' }
          run_test!
        end
      end
    end
  end
end
