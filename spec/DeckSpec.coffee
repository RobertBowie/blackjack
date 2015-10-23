assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe '.dealPlayer()', ->
    it 'should create a new hand', ->
      assert.strictEqual hand.length, 2
      dealerHand = deck.dealDealer()
      assert.strictEqual dealerHand.length, 2

  describe '.hit()', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      last = deck.last()
      hand.hit()
      assert.strictEqual last, hand.last()
      assert.strictEqual deck.length, 49

    it 'should add a card to the hand', ->
      len = hand.length
      hand.hit()
      assert.strictEqual hand.length, len + 1

    it 'should bust when over 21', ->
      busted = false
      hand.on 'bust', -> busted = true
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      assert.strictEqual busted, true