class Compare < ApplicationRecord
	belongs_to :ref_field_source
	belongs_to :dest_field
end
