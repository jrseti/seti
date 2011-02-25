class PatternMark < ActiveRecord::Base
  belongs_to :pattern
  belongs_to :assignment
end
