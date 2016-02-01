require_relative 'blackjack.rb'

puts "Welcome to the casino"
puts "Press enter to begin game"
gets

@game = Game.new
@game.deal_cards

puts "Your hand"
@game.players[1].hand.cards.each { |c| puts c.name }
puts "The dealer's showing card"
puts @game.players[0].hand.cards.first.name

if @game.players[1].hand.score == 21
  puts "Blackjack! You win!"
  puts "Enter to exit"
  gets
  exit
elsif @game.players[0].hand.score == 21
  puts "Dealer wins with am opening blackjack"
  puts "Enter to exit"
  gets
  exit
end

@game.players[@game.turn].take_turn while @game.winner == :none

puts "##Score##"
puts "Dealer: #{@game.players[0].hand.score}"
puts "You: #{@game.players[1].hand.score}"

puts "House wins again" if @game.winner.is_dealer?
puts "You are a winner" if @game.winner.is_user?
