class FiguresController < ApplicationController

	get '/figures' do
		@figures = Figure.all
		erb :'figures/index'
	end

	get '/figures/new' do
		erb :'figures/new'
	end

	get '/figures/:id' do 
		@figure = Figure.find(params[:id])
		erb :'figures/show'
	end

	get '/figures/:id/edit' do
		@figure = Figure.find(params[:id])
		erb :'figures/edit'
	end

	get '/figures/:slug' do
		@figure = Figure.find_by_slug(params[:slug])
		erb :'figures/show'
	end

	post '/figures/new' do

		@figure =  Figure.find_by(name: params[:figure][:name])
		
		if @figure == nil
			@figure = Figure.create(name: params[:figure][:name])
		end

		if params[:title][:name] != ""
			@title = Title.create(name: params[:title][:name])
			@figure.titles << @title
		end

		if params[:landmark][:name] != ""
			@landmark = Landmark.create(name: params[:landmark][:name])
			@figure.landmarks << @landmark
		end
		
		if params[:figure][:title_ids]
			params[:figure][:title_ids].each do |title_id|
				@title = Title.find(title_id.to_i)
				@figure.titles << @title
			end
		end

		if params[:figure][:landmark_ids]
			params[:figure][:landmark_ids].each do |landmark_id|
				@landmark = Landmark.find(landmark_id.to_i)
				@figure.landmarks << @landmark
			end
		end

		redirect to "/figures/#{@figure.slug}"
	end

	patch '/figures/:id' do 

		@figure = Figure.find(params[:id])
		@figure.name = params[:figure][:name]
		@figure.save

		if params[:figure][:landmark_ids]
			params[:figure][:landmark_ids].each do |landmark_id|
				@landmark = Landmark.find(landmark_id.to_i)
				@figure.landmarks << @landmark
			end
		end

		if params[:landmark][:name] != ""
			@landmark = Landmark.create(name: params[:landmark][:name])
			@figure.landmarks << @landmark
		end

		if params[:title][:name] != ""
			@title = Title.create(name: params[:title][:name])
			@figure.titles << @title
		end

		if params[:figure][:title_ids]
			params[:figure][:title_ids].each do |title_id|
				@title = Title.find(title_id.to_i)
				@figure.titles << @title
			end
		end

		redirect to "/figures/#{@figure.id}"
	end


end