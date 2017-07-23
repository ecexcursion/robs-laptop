
#this is a file for learning about methods

#7/22/2017


def hello(name)
  10.times do | i |
    i = puts "hello #{name}"
  end
  # more code
end

def hello2(name='Rob')
  10.times do
    puts name + "."
  end
  # more code
end

hello("Rob")
hello("Greg")

hello2("Zander")
hello2
hello2



puts "hello Rob again!"

#more code

# return.rb

def add_three(number)
  number + 3
end

returned_value = add_three(4)
puts returned_value

puts 8.times
