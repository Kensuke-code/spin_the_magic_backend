# == Schema Information
#
# Table name: attractions
#
#  id            :bigint           not null, primary key
#  name          :string
#  scraping_name :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  area_id       :bigint           not null
#
# Indexes
#
#  index_attractions_on_area_id  (area_id)
#
# Foreign Keys
#
#  fk_rails_...  (area_id => areas.id)
#
require "test_helper"

class AttractionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
