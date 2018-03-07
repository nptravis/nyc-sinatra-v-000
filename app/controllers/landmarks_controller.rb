class LandmarksController < ApplicationController

	get '/landmarks' do
		@landmarks = Landmark.all
		erb :'landmarks/index'
	end

	get '/landmarks/new' do
		erb :'landmarks/new'
	end

	post '/landmarks/new' do
		@landmark =  Landmark.find_by(name: params[:landmark][:name])
		
		if @landmark == nil
			@landmark = Landmark.create(name: params[:landmark][:name])
			@landmark.year_completed = params[:landmark][:year_completed].to_i
			@landmark.save
		end
		erb :'landmarks/show'
	end

	get '/landmarks/:id' do
		@landmark = Landmark.find(params[:id])
		erb :'landmarks/show'
	end

	get '/landmarks/:id/edit' do 
		@landmark = Landmark.find(params[:id])
		erb:'landmarks/edit'
	end

	patch '/landmarks/:id' do
		@landmark = Landmark.find(params[:id])
		@landmark.name = params[:landmark][:name]
		@landmark.year_completed = params[:landmark][:year_completed].to_i
		@landmark.save

		redirect to "/landmarks/#{@landmark.id}"
	end

end
