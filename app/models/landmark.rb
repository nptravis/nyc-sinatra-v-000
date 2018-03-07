class Landmark <ActiveRecord::Base
	belongs_to :figure
	include Slugify

end
