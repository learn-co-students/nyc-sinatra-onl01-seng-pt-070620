class LandmarksController < ApplicationController
  get '/landmarks' do
    erb :"/landmarks/index"
  end

  get '/landmarks/new' do
    erb :"/landmarks/new"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])
    erb :"landmarks/show"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by(id: params[:id])
    erb :"landmarks/edit"
  end

  post '/landmarks' do
    @landmark = Landmark.new(name: params[:landmark_name], year_completed: params[:landmark_year_completed])
    if @landmark.valid?
      @landmark.save

      redirect "landmarks/#{@landmark.id}"
    end
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])

    @landmark.update(name: params[:name], year_completed: params[:year_completed])

    erb :"landmarks/#{@landmark.id}"
  end
end
