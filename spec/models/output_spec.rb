require 'rails_helper'

describe Output
 do
  let(:output) {Input.new(out_color_1: "Really Good Apple", out_shape_2: "octagon", out_state_3: "illinois", out_daytime_4: "morning", out_id_5: "9617", out_date_6: "43165", out_amt_7: "21", input_id: 1)}

  describe "validates" do
    it "has a valid out_color_1" do
      input.valid?
      expect(output.errors[:out_color_1]).to be_empty
    end
    it "has a valid out_shape_2" do
      output.valid?
      expect(input.errors[:out_shape_2]).to be_empty
    end
  end
end