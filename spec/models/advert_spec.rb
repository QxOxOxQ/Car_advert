# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Advert, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
  end

  describe 'active record' do
    it { is_expected.to belong_to(:user) }
  end
end
