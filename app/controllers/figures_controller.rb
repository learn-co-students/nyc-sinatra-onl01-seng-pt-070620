class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :"/figures/index"
  end 

  post '/figures' do 
    @title = params[:title]
    @title_ids = params[:figure][:title_ids]
    @landmark = params[:landmark]
    @landmark_ids = params[:figure][:landmark_ids]

    @figure = Figure.create(:name => params[:figure][:name])
    if !@title[:name].empty?
      title = Title.create(:name => @title[:name])
      @figure.titles << title
    end 
    if @title_ids
      @title_ids.each do |id| 
        title = Title.find(id)
        @figure.titles << title
      end 
    end 
    if !@landmark[:name].empty?
      landmark = Landmark.create(:name => @landmark[:name])
      @figure.landmarks << landmark
    end 
    if @landmark_ids
      @landmark_ids.each do |id|
        landmark = Landmark.find(id)
        @figure.landmarks << landmark
      end 
    end 

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end 

  get '/figures/new' do 
    @titles = Title.all
    @landmarks = Landmark.all 
    erb :"figures/new"
  end 

  get '/figures/:id/edit' do 
    @figure = Figure.find_by(id: params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/edit'
  end 

  patch '/figures/:id' do 
    @title = params[:title]
    @title_ids = params[:figure][:title_ids]
    @landmark = params[:landmark]
    @landmark_ids = params[:figure][:landmark_ids]

    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]

    if @title_ids
      @figure.titles.clear
      @title_ids.each do |id|
        title = Title.find(id)
        @figure.titles << title
      end 
    end 
    if !@title[:name].empty?
      title = Title.create(:name => @title[:name])
      @figure.titles << title
    end 
    if @landmark_ids
      @figure.landmarks.clear
      @landmark_ids.each do |id|
        landmark = Landmark.create(:name => @landmark[:name])
        @figure.landmarks << landmark
      end
    end 
    if !@landmark[:name].empty?
      landmark = Landmark.create(:name => @landmark[:name])
      @figure.landmarks << landmark
    end 
      @figure.save 
      redirect to "figures/#{@figure.id}"
  end 

    get '/figures/:id' do 
      @figure = Figure.find_by(id: params[:id])
      erb :"figures/show"
    end 



end
