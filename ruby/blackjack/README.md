# The Plan #

## Player
- [x] Is either a dealer or user (` @dealer `)
- [x] has a hand
- [x] has turn actions #hit or #stay
- [ ] may ` take_trun `
- [ ] has statuses playing, bust, blackjack

## Game
- [ ] Cards are dealt to players when game starts
- [x] Has players
- [x] Has a turn state (who's turn is it?)
- [x] Has a deck (possibly many if we are at a casino)
- [ ] Has winner

## Hand
- [x] Has a score ` @score = cards.each { |c| sum = sum + c.value }` or something like that
  - I think there is some kind of ruby array sum method
- [ ] Is blackjack?
- [ ] Is bust?
