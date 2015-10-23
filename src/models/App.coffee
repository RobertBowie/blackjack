# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'all', @onPlayerEvent, @
    @get('dealerHand').on 'all', @onDealerEvent, @


  onPlayerEvent: (event) ->
    if event is 'bust' then @trigger 'dealerWin', @
    if event is 'stand' then @get('dealerHand').playDealer()

  onDealerEvent: (event) ->
    player = @get('playerHand')
    dealer = @get('dealerHand')
    if event is 'bust' then @trigger 'playerWin', @
    if event is 'stand'
      if player.bestScore() > dealer.bestScore()
        @trigger 'playerWin', @
      else if dealer.bestScore() > player.bestScore()
        @trigger 'dealerWin', @
      else
        @trigger 'push', @