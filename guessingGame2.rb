won = false
#while true do
#while !won
until won do
    correct_num = rand(10) + 1
    puts  "Please enter a number between 1-10"
    user_number = gets.to_i

    if user_number == correct_num
	    puts "You were right!"
	    #break
	    won=true
    else
	    puts "You were wrong! The correct number was " + correct_num.to_s
    end
end
