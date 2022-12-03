class Calculation < ApplicationRecord
    validates_presence_of :array
    validates_presence_of :max_seg
    validates_presence_of :segments
    validates_presence_of :seg_count

    validates :array, uniqueness: { message: '- уникальность нарушена' }
end
