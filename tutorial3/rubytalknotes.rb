########## sX Makers Ruby Tutorial no 3 ############

#####################################################
# Here are my notes from the talk. We covered loops #
# (while/until, for, and the more common iterator)  #
# and hashes. If you have any questions, please     #
# reach out to me or to Brendan. Happy Rubying!!    #
#                                                   #
# Julian - cknight7@gatech.edu - @charles_jknight   #
#####################################################




############ PART 1 ####################################################

#  Last class, we covered basic concepts like variables and conditionals,
# and also some of the most common data types. Today we will dive into
# loops. I'm starting  with while loops instead of for loops for a reason
# that will hopefully be apparent shortly. All of this you can try out in
# a ruby shell by running `irb` in the command line.

#  This is a basic while loop. It continues to run the code between "do" and
# "end" until the condition (in this case, i<10) is met. This should be very
# familiar to anyone with some MATLAB experience.

i=0
while i<10 do
  i+=1
  puts i
end

# Here is the same sort of loop, but using the `gets` function that we learned
# about last time instead. 
x = gets.to_i
while x<10 do
    puts "#{x} isn't bigger than 10, stupid!"
    x=gets.to_i
end

# Wait a minute! What was that #{x} nonsense!?
# We talked about combining strings (called concatenation) using the + operator, like so:
name = "Julian"
puts "Hi, my name is " + name + "!"
#  This is totally valid, but if you need to put a lot of variables in your string, it can
# be annoying to type a bunch of plus signs. Instead, we can put the name of our variable
# inside curly braces with a pound sign in front, and ruby will put that in for us. In fact,
# Ruby will execute whatever you put in there, try and turn the return value into a string,
# and print that. If you have experience with Python or C (or maybe also Java?) you can use
# %d syntax as well: http://stackoverflow.com/questions/10357303/ruby-string-substitution

#Moving on...
#  Ruby tries (very successfully) to be readable enough that someone with no programming
# experience can read ruby code and get an idea of what the code does. It uses "syntactic
# sugar" to follow natural language as much as possible. 
#  For example, the `until` command works exactly as you'd expect. It is basically the same
# as a `while` loop, except that the loop ends when the condition becomes true, rather than 
# when it becomes false:

x=0
until x>10 do
    puts "give me a number bigger than 10"
    x=gets.to_i
end
puts x


# Even better, you can reorder your statement and squeeze it on one line if it flows better.
# This does essentially the same as above:
x=0
x=gets.to_i until x>10

# There is a similar structure for conditionals. Here is a normal conditional:
x=0
if x>10
    puts "big number"
else
    puts "small number"
end

# The `unless` is analagous to `until`  -- basically if !(CONDITION)
unless x>10
    puts "small number"
else
    puts "big number"
end

# and again, we can reorder those statements, too:
puts "can't login!" unless password == correct_password

#  At this point, we can make some improvements to our guessingGame
# from last week. We can make the program to continue to ask you to
# guess until you get it right. The source code is included in this
# repo.




############ PART 2 ####################################################

# Recall arrays:
x=[1,3,2,6,5,4]
x.last
x.length
x=x.sort

#  We can do for loops the same way as while loops. Again, this should
# look pretty familiar if you have experience with other languages. This
# loop goes through each element inside our array x, temporarily stores
# that value to i, and then does something with that value (in this case,
# simply print it):
for i in x do
    puts i
end

# Of course, what if we wanted to loop a lot more than 6 times? How about:
for i in 1..100 do
    puts i
end

# That `1..100` thing is what is called a Range:
(1..5).class    # => Range

#  If we run `1..5` in irb, though, it just returns that same Range. To get
# a better concept, let's convert it to an array:
(1..5).to_a

# Awesome. You can also do "exclusive" ranges, which leave out the final element.
(1..5)  #inclusive
(1...5) #exclusive

# Here is another one that works, all though it's a lot less pretty:
for i in 5.upto(10) do
    p i
end
#  "p" is just a shortcut for "puts" because we use "puts" all the time, and
# programmers are lazy and don't like typing. Whenever you see something like
# p "Hello", just think "puts" instead.

# So what are all these things?
[1,2,3].class       # => Array
(1..5).class        # => Range
5.upto(10).class    # => Enumerator
(1..5).to_a         # => Array

#  Of course, we've seen that `for` is quite happy with any of these data types.
# But what is this funky "Enumerator" thing? First, let me show you another
# Enumerator:
42.times do puts "meow" end
42.times.class      # => Enumerator

#  Woah! We just essentially did a for loop without ever using the word `for.` WTF?
# This is actually the more Rubyish way to do for loops, called iterators. Iterators
# take in Enumerators and act on each item (or items) individually. Bare with me
# through a few more examples for a second:
[7,12,3].each do |x|
    puts x
end

#  Ignore the "|x|" thing for just a minute, and let's look at everything else here.
# The stuff from "do" along to "end" is called a Block. And notice the "each" function.
# It does exactly what it sounds like it does: it takes each element from the array,
# and runs the code block on it. In fact:
[7,12,3].each.class     # => Enumerator

#  That's good, since  we know Iterators take in Enumerators. The each function also
# works for Ranges and a handful of other things too, probably. Now how about that |x|
# business? That simply tells Ruby what inputs are coming into the Block, and assigns
# them a variable so we can do stuff with them. In fact, the x functions exactly the
# same as "i" in "for i in (1..5)" and the "||" (called pipes) just separate these from
# our executing code.

#  This is much closer to THE RUBY WAY than the `for` loops we were doing earlier, but
# we still aren't quite there. We can replace the "do" and "end" stuff with curly brackets
# (again, remember programmers are lazy!):

[7,12,3].each { |x|
    p x     #same as "puts x"
}

#  Not so bad, right? Ruby (unlike Python, for example) doesn't usually care about whitespace,
# so we can run these all onto one line. Notice the different types of Enumerators we can use.
(0..5).each {|x| p x}
0.upto(5) {|x| p x}
5.times {|x| p x}

#  There are some other handy Enuemerator functions out there. For example, each_line does
# exactly what you might expect. It takes in a multi-line string, and feeds each line into
# the block one at a time. 

paragraph = """This here paragraph
is a pretty cool guy
he spans multiple lines
and doesn't afraid of anything"""

paragraph.each_line { |line| puts line.chomp.reverse }

# This does the same as
for line in paragraph.split("\n") do        #"\n" is the code for a newline character
    puts line.chomp.reverse
end

#  The reverse function does exactly what you'd expect. The chomp function removes any extra
# newline characters. The split command will divide a string into an array of strings, using
# whatever argument you give it as a delimiter. To split on spaces, for example:
"Georgia Institute of Technology".split(" ").each {|word| puts word}

# It can also split every character:
"Julian".split("").each{|c| puts c}

#  I won't go into any more detail on these string functions for now. You can play with them
# on your own. Also, check out reject:
x=(1..100)
x.include?(75)
x.include?(750)
x.reject {|s| s<75}

# and also this cool example from Wikipedia:
"Nice Day Isn't It?".downcase.split("").uniq.sort.join



############ PART 3 ####################################################


#  Arrays aren't picky about data types, so we can have any data types
# we want, all in the same array:
x=[0, "string", [1,2,3]]
x.last
x.last.first

# But of course, handling different data types at once like this can
# be difficult. 
x.sort  # Throws an error


#  Arrays are pretty handy, but if you are using several different data types,
# there is something that is a little more handy: a hash (also called a
# dictionary, a structure, or an associative array in other languages).
#  Let's say we want to store data about pets. Specifically, their name, type,
# gender, and age. Most of these are strings, but age is an integer. Here is
# one way to do that:

pet1 = { "type" => "cat", "name" => "milo", "gender" => "male", "age" => 12 }

#  The part before the => (called a rocket) is called the key and the part after
# is the value. We can get data back out of this hash using the key:
pet1["name"]        # => "milo"
pet1["type"]        # => "cat"


# Ruby will actually evaluate whatever is inside the square brackets, and try
# to use that for the key.
key = "age"
pet1[key]
key = "gender"
pet1[key]

#  Notice that here, all our keys are strings. In fact, keys can be any datatype
# we like:

x = { 3.14159 => "a string", [1,2,3] => 13, {1=>2}=>"hash"}
#  The fist key is a float (decimal number), the second is an array, and the craaaziest
# of all, the last is a hash that points to a string in our hash. Hashes in hashes!
# Turtles all the way down!
x[(1..3).to_a]


#  Practically speaking, though, the vast majority of the time, we want to just use names
# to identify the items in our hash. We could use strings for this, but typing all those
# quotation marks is a pain (lazy!) and actually take up extra space in memory. For this
# reason, Ruby has Symbols. Symbols look kind of like variables, but they start with a
# colon, and they don't actually store any data. They are simply a name for different
# keys in our hash. They more-or-less only exist for this purpose.

:symbol.class       # => Symbol

pet1 = { :type => "cat", :name => "milo", :gender => "male", :age => 12 }
pet1[:name]         # => "milo"

#  That's a lot to type (lazy! see a pattern yet?), so this is the much more common
# shorthand for above:

pet2 = {type: "lobster", name: "rubicon", gender: "male", age: 2}
pet2[:name]         # => "rubicon"

#  Isn't that pleasant? If you have experience with Javascript, this will look very familiar
# (this is basically exactly the same as JSON, but with symbols).
#  We've got one more thing to look at. What if we want to pass our hash into an iterator?
# It's pretty simple. The block just needs to list both the key and the value as inputs.

pet2.each{ |key, value| puts "#{key}\t#{value}" }       # "\t" is the code for a tab character


#  We covered a few different kinds of loops, including the more Ruby Way of using iterators
# and code blocks, and we covered hashes. Both of these have some features that are unique to
# Ruby, and both are super common in Ruby code. To test out our new knowledge, I had prepared
# a script to scrape data from the play history on the WREK website into an array of hashes.
# We didn't quite get that far in class, but the source code is here in the repo if you want
# to take a look at it.

#  One last thing, if you are looking for an online Ruby tutorial, I HIGHLY recommend
# "why's (poignant) guide to Ruby" which is free online, and guaranteed to be absolutely
# nothing like any other programming tutorial ever. I won't spoil anything, but suffice
# to say that Why captures and indeed embodies the style and culture of Ruby. I recommend it
# even to people who don't want to learn Ruby. 
#                   [ http://mislav.uniqpath.com/poignant-guide/ ]
