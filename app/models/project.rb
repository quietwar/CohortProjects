class Projects < ApplicationRecord

	
  	 
  	get '/new', to:  'projects#new'
	validates :genius, :completed, :description, :comments, 
	validates :projectname, 
	
end
