class FiguresController < ApplicationController
  get '/figures' do
    erb :"/figures/index"
  end

  get '/figures/new' do
    erb :"/figures/new"
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])

    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])

    erb :"figures/edit"
  end

  # post '/figures' do
  #   @figure = Figure.create(name: params[:figure_name])
  #   # binding.pry


  #     if params[:landmark][:name] != "" && params[:landmark][:year_completed] != ""
  #       @figure.landmarks.build(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
  #     elsif params[:figure][:landmark_ids] != nil
  #       landmark = Landmark.find_by(id: params[:figure][:landmark_ids].first)
      
  #       @figure.landmarks << landmark
  #     end

  #     if params[:title][:name] != ""
  #       @figure.titles.build(name: params[:title][:name])
  #     elsif params[:figure][:title_ids] != nil
  #       title = Title.find_by(id: params[:figure][:title_ids].first)

  #       @figure.titles << title
  #     end
  #     @figure.save

  #   redirect "figure/#{@figure.id}"
  # end

  post '/figures' do
    @figure = Figure.create(params['figure'])
    unless params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    unless params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  patch '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    @figure.update(name: params[:figure][:name])

      if params[:title][:name].empty?
        title = Title.find_by(id: params[:figure][:title_ids].first)
        @figure.titles << title
      end

      if params[:landmark][:name].empty?
        landmark = Landmark.find_by(id: params[:figure][:landmark_ids].first)
        @figure.landmarks << landmark
      end
  end

end
