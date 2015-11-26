class ResultsController < ApplicationController
  def index
  end

  def notam
    notam = params[:notam]
    path = 'public/notam.txt'
    File.open(path, 'w+') do |f|
      f.write(notam)
    end
    redirect_to results_url
  end
end
