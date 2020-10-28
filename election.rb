#assuming states are actually toss ups

states = [{FL: 29}, {GA: 16}, {NC: 15}, {OH: 18}, {IA: 6}, {ME: 1}, {AZ: 11}]
margin_of_victory = []
num_states_won_by_biden = []

#Welcome to a naive statistical model of the election. In this model, 
#we consider each state with a margin of polling less than 5% to be a tossup. This means, by definition, that every state
#has an (almost) equal probability to go toward Joe Biden or Donald Trump."
#Each state is treated as a coin flip. For each cylce, Biden has a 55% of
#winning the given state while trump has a 45%. Thus, this model is slightly favored
#toward Biden considering his average lead in the state polls acorss the toss up states."

128000.times do |round|
  puts "---------------------------------"
  states_biden_win = []
  states_trump_win = []
  num_won_biden = 0
  num_won_trump = 0
  biden = 279
  trump = 163
  puts "#{round + 1} Round:"
  puts "\n"
  states.each do |state|
    electoral_votes = state.values[0]
    if (rand(1..100)) <= 55
      states_biden_win.push(state.keys[0])
      biden += electoral_votes
      num_won_biden += 1
    else 
      states_trump_win.push(state.keys[0])
      trump += electoral_votes
      num_won_trump += 1
    end
  end


  if states_biden_win != []
    puts "States Biden Wins:"
    states_biden_win.each do |state|
      puts state
    end
  else
    puts "States Biden Wins:"
    puts "None"
  end
  puts "Number of States Biden Wins: #{num_won_biden}"
  puts "\n"

  if states_trump_win != []
    puts "States Trump Wins:"
    states_trump_win.each do |state|
      puts state
    end
  else
    puts "States Trump Wins:"
    puts "None"
  end

  puts "Number of States Trump Wins: #{num_won_trump}"
  puts "\n"

  num_states_won_by_biden.push(num_won_biden)
  puts "Biden Total Electoral Count: #{biden}"
  puts "Trump Total Electoral Count: #{trump}"
  difference = biden - trump
  puts "Biden Wins By: #{difference}"
  margin_of_victory.push(difference)
end

puts "---------------------------------"
puts "Summary Results"
puts "\n"
avg_num_states_won = num_states_won_by_biden.inject(:+).to_f / num_states_won_by_biden.size
puts "Average number of states Biden wins: #{avg_num_states_won.round}"
puts "Average number of states Trump wins: #{7 - avg_num_states_won.round}"
avg_margin_of_vic = margin_of_victory.inject(:+).to_f / margin_of_victory.size
puts "\n"
mode_margin_of_vic = Hash.new(0)
margin_of_victory.each do |difference|
  mode_margin_of_vic[difference] += 1
end

hash_of_top_differences = {}
top = 10
10.times do
  val = mode_margin_of_vic.max_by{ |k,v| v}
  mode_margin_of_vic.delete(val[0])
  hash_of_top_differences[val[0]] = val[1]
end

puts "Top ten most likely outcomes:"
puts "\n"
count = 1

hash_of_top_differences.each do |elec, times|
  puts "Number #{count}"
  puts "Electoral College Difference: #{elec}"
  puts "Number of Times in Simulation: #{times}"
  puts "\n"
  count += 1
end

keys = hash_of_top_differences.keys
max = keys.max
min = keys.min

puts "Range of #{top} most likely electoral college margin of victory: #{min}-#{max}"
puts "Average (across all outcomes) electoral college margin of victory: #{avg_margin_of_vic.round}"

number = 0
margin_of_victory.each do |value|
  if value < 210 && value > 99
    number += 1
  end
end

one_ten = 0
margin_of_victory.each do |value|
  if value < 150 && value > 99
    one_ten += 1
  end
end

one_fifty = 0
margin_of_victory.each do |value|
  if value < 210 && value > 149
    one_fifty += 1
  end
end

probability = (number / 128000.0)
val = (one_ten / 128000.0)
val_two = (one_fifty / 128000.0)

puts "Probability of making money: #{probability}"
puts "Probability of making from 100 to 149: #{val}"
puts "Probability of making from 150 to 209: #{val_two}"

puts "---------------------------------"
puts "\n"

