class Journal < ApplicationRecord
  has_many :entries, :dependent => :destroy
end