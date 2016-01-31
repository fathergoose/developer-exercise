# The Plan #

## Player
- [x] Is either a dealer or user (` @dealer `)
- [ ] has a hand
- [ ] has turn actions #hit or #stay

## Game
- [ ] Has players
- [ ] Has a turn state (who's turn is it?)
- [ ] Has a deck (possibly many if we are at a casino)
- [ ] Has winner

## Hand
- [ ] Has a score ` @score = cards.each { |c| sum = sum + c.value }` or something like that
  - I think there is some kind of ruby array sum method
- [ ] Is blackjack?
- [ ] Is bust?
