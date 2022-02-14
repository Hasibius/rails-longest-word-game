class PagesController < ApplicationController
  require "open-uri"

  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @word = params[:word].upcase
    @letters = params[:slova]
    check = @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    json = JSON.parse(response)
    @answer = if check
                if json['found']
                  'Congrats!'
                else
                  'Sorry, English plz'
                end
              else
                'Sorry, those letters are not on the grid'
              end
  end
end
