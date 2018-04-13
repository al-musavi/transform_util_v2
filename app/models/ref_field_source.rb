class RefFieldSource < ApplicationRecord
	belongs_to :dest_field
	has_many :compares
end
