# frozen_string_literal: true

RSpec.configure do |config|
  include ActionDispatch::TestProcess
  config.include FactoryBot::Syntax::Methods
end
