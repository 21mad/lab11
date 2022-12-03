require 'rails_helper'

RSpec.describe Calculation, type: :model do
  let(:calc_valid) { 
    Calculation.new(
      array: '23 6 49',
      max_seg: '3 32',
      segments: '23 33 32',
      seg_count: 3,
      created_at: DateTime.now,
      updated_at:DateTime.now + 1.second
    ) 
  }

  it "is valid with valid attributes" do
    expect(calc_valid).to be_valid
  end

  it "is not valid without an array" do
    calc_valid.array = nil
    expect(calc_valid).to_not be_valid
  end

  it "raises error with same array" do
    expect(Calculation.create(
      array: '23 6 49',
      max_seg: '3 32',
      segments: '23 33 32',
      seg_count: 3,
      created_at: DateTime.now,
      updated_at:DateTime.now + 2.second
    ).errors.nil?).to eq(false)
  end
end
