require 'yaml'

def get_random_word(text_file)
  all_words = []
  File.open(text_file, "r") do |f|
    f.readlines.each do |line|
      chomp_line = line.chomp
      all_words << chomp_line if chomp_line.size > 5 and chomp_line.size < 12
    end
  end
  
  return all_words[rand(all_words.size)].downcase
end

def get_puzzle_word(random_word)
  check = false
  i = 0
  f = 1
  puzzle_word_array = []
  loop_blank_letter = 0
  
  random_word.split("").each do |letter|
    break if i >= random_word.size
    
    if check
      puzzle_word_array[i] = random_word[i]
      check = false
      i += 1
      next
    end
    
    while loop_blank_letter < f do
      break if i >= random_word.size
      puzzle_word_array[i] = "_"
      i += 1
      loop_blank_letter += 1
    end
    loop_blank_letter = 0 # next while loop must be 0
    f += 1
    check = true
  end
  
  return puzzle_word_array.join("")
end

def get_puzzle_word_with_spaces(puzzle_word)
  puzzle_word.split("").join(" ")
end

def run_puzzle(random_word, puzzle_word, puzzle_spaces_word, guesses, username)
  puts "Your Word: [ " + puzzle_spaces_word + " ] (#{guesses} guess(es) left)"
  
  dup_random_word = random_word
  
  saved_check = false
  
  (0..guesses - 1).each do
    print "Type now: "
    user_input = gets.chomp.downcase
    if user_input == "!save"
      d = YAML::dump(random_word: random_word, puzzle_word: puzzle_word, puzzle_spaces_word: puzzle_spaces_word, guesses: guesses)
      File.open("users/#{username}.yaml", "w+") do |f|
        f.puts d
      end
      puts "Saved! Bye"
      saved_check = true
      break
    end
    
    user_input = user_input[0]
    guesses -= 1
    
    if dup_random_word.include? user_input
      dup_random_word = (dup_random_word.split("") - user_input.split("")).join("")
      
      puts "Good Input! Keep Going..."
      puts
      
      random_word.split("").each_with_index do |n, i|
        if user_input == n
          puzzle_word[i] = random_word[i]
          puzzle_spaces_word = get_puzzle_word_with_spaces(puzzle_word)
        end
      end
      
    else
      puts "Bad Input! Try Again...\n"
      puts
    end
    
    puts "Your word: [ " + puzzle_spaces_word + " ] (#{guesses} left)"
    
    if puzzle_word == random_word
      puts "You won! Did it in #{10 - guesses} guesses"
      
      # Delete old user data if ane
      File.delete("users/#{username}.yaml")
      break
    end
  end
  
  if puzzle_word != random_word and !saved_check
    puts "You lost: The word was: #{random_word}"
  end
end

def start_game(random_word, puzzle_word, puzzle_spaces_word, guesses, username)
  user_file_existance = File.exists? "users/#{username}.yaml"
  if user_file_existance
    puts "  type !new for starting new game(this will delete old data if any) or !load to continue old game"
  
    print "  input: "
    user_input = gets.chomp.downcase
    puts
    
    if user_input == "!new"
      puts "Deleting old data..."
      
      File.delete("users/#{username}.yaml")
      
      run_puzzle(random_word, puzzle_word, puzzle_spaces_word, guesses, username)
      
    elsif user_input == "!load"
      old_data = ""
      File.open("users/#{username}.yaml", "r") do |f|
        old_data = f.read
      end
      parse_data = YAML::load(old_data)
      run_puzzle(parse_data[:random_word], parse_data[:puzzle_word], parse_data[:puzzle_spaces_word], parse_data[:guesses], username)
      
    else
      puts "Wrong input! Closing app! restart and try again..."
    end
  else
    puts "  First time user, starting new game. Type anytime !save to save the game."
    puts
    run_puzzle(random_word, puzzle_word, puzzle_spaces_word, guesses, username)
  end
end

text_file = "5desk.txt"

random_word = get_random_word(text_file)

puzzle_word = get_puzzle_word(random_word)

puzzle_spaces_word = get_puzzle_word_with_spaces(puzzle_word)

guesses = 10

puts <<LOB
  Welcome to Hangman Game!
  ------------------------
  
  You'll be given a word to guess and you must supply an alphabet and make guesses.
  You'll have 10 guesses. If you make it till the end, you'll get a surprise!
  If you lose, don't worry, Keep trying until you win!
  While guessing, you can always type "!save". This will save your game and you can come back later.
  After you save your game press "!load" after saving your username.
  
  So let's start...
  
  First, enter your username(all lowercase)
LOB

print "  username: "
username = gets.chomp.downcase
puts

start_game(random_word, puzzle_word, puzzle_spaces_word, guesses, username)
