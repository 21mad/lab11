class Calculation < ApplicationRecord
    validates_presence_of :array
    validates_presence_of :max_seg
    validates_presence_of :segments
    validates_presence_of :seg_count
    validates_presence_of :updated_at
    validates_presence_of :created_at

    validates_uniqueness_of :array
end
