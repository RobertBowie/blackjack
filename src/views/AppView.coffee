class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="new-hand">Next Hand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .new-hand': -> @model.newHand()

  initialize: ->
    @render()
    @model.on 'playerWin', -> console.log 'Player Wins!'
    @model.on 'dealerWin', -> console.log 'Dealer Wins!'
    @model.on 'push', -> console.log 'Push!'
    @model.on 'change', @render, @

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

