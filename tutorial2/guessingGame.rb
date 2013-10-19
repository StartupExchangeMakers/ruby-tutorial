## The guessing game from tutorial 2, updated to loop until you guess the right number
#  We could also use 'while true' and a 'break' statement to accomplish the same task

won = false
correct_num = rand(10) + 1

until won    
    puts  "Please enter a number between 1-10"

    user_number = gets.to_i

    if user_number == correct_num
	    puts "You were right! The number was #{correct_num}"
	    won = true
    else
	    puts "Nope! Try again"
    end

end
