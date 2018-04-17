class DestField < ApplicationRecord
	has_many :ref_field_sources


	def ref_field_source_name
		self.ref_field_sources[0].name
	end

end
