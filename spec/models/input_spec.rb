require 'rails_helper'

describe Input do
  let(:input) {Input.new(in_fruit_1: "apple", in_obj_2: "stop_sign", in_city_3: "chicago", in_time_4: "8a", in_id_5: "9617", in_date_6: "43165", in_amt_7: "21", in_bruise_8: "Not Bruised", in_size_9: "Large")}

  describe "validates" do
    it "has a valid in_fruit_1" do
      input.valid?
      expect(input.errors[:in_fruit_1]).to be_empty
    end
    it "has a valid in_obj_2" do
      input.valid?
      expect(input.errors[:in_obj_2]).to be_empty
    end
  end
end