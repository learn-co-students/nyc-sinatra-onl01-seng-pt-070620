class LandmarksController < ApplicationController
  get '/landmarks' do
    erb :"/landmarks/index"
  end
end
