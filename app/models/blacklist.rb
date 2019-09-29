# frozen_string_literal: true

class Blacklist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Blacklist

  self.table_name = 'blacklist'
end
