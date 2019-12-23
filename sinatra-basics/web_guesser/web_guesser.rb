require 'sinatra'
require 'sinatra/reloader'

secret_number = rand(100)
old_secret_number = 0
@@remaining_guess = 5
old_remaining_guess = 0

get '/' do
  user_guess = params["guess"]
  message = check_guess(user_guess, secret_number)
  
  is_cheat = params["cheat"] == "true" ? true : false
  
  erb :index, :locals => { :secret_number => secret_number, :message => message, :old_secret_number => old_secret_number, :remaining_guess => @@remaining_guess, :old_remaining_guess => old_remaining_guess, :is_cheat => is_cheat }
  
  if(user_guess)
    @@remaining_guess -= 1
  end
  
  if(@@remaining_guess < 1)
    old_secret_number = secret_number
    secret_number = rand(100)
    @@remaining_guess = 5
    message = ["You couldn't finish it in 5 guesses! Secret was #{old_secret_number} New secret and guesses have been reset", "red", secret_number]
  end
  
  if message[0] && message[0] == "You got it right!"
    old_secret_number = secret_number
    secret_number = rand(100)
    old_remaining_guess = @@remaining_guess
    @@remaining_guess = 5
  end
  
  erb :index, :locals => { :secret_number => secret_number, :message => message, :old_secret_number => old_secret_number, :remaining_guess => @@remaining_guess, :old_remaining_guess => old_remaining_guess, :is_cheat => is_cheat }
end


private
  def check_guess(user_guess, secret_number)
    if(user_guess && user_guess.to_i == secret_number)
      ans_message = "You got it right!"
      font_color = "green"
    elsif user_guess && user_guess.to_i < secret_number && (secret_number - user_guess.to_i < 5)
      ans_message = "Number a little low"
      font_color = "pink"
    elsif user_guess && user_guess.to_i < secret_number
      ans_message = "Number too low"
      font_color = "red"
    elsif user_guess && user_guess.to_i > secret_number && (user_guess.to_i - secret_number < 5)
      ans_message = "Number a little high"
      font_color = "pink"
    elsif user_guess && user_guess.to_i > secret_number
      ans_message = "Number too high"
      font_color = "red"
    else
      ans_message = ""
    end
    return ans_message, font_color, secret_number
  end