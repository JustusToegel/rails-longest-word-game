require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ""
    10.times do
      letter = ('A'..'Z').to_a.sample
      @letters << letter
    end
  end

  def score
    # Alle Buchstaben in ausreichender Zahl vorhanden
    # englisches Wort
    # für jeden Buchstaben in der Antwort:
    # finde den Index der ersten Instanz des Buchstabens in letters
    # lösche den Wert an jener Stelle
    letters = params[:letters].chars
    letters_present = true
    params[:useranswer].upcase.chars.each do |answ_letter|
      index = letters.index(answ_letter)
      if index
        letters.delete_at(index)
      else
        letters_present = false
        break
      end
    end
    if letters_present
      # TODO: make API call
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:useranswer]}").read
      found = JSON.parse(response)["found"]

    else
      # display: can't make that word blablabla
    end
  end
end
