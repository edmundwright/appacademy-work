require 'deck'

describe Deck do
  let(:deck) { Deck.new }
  let(:card1) { Card.new(:hearts, :king) }
  let(:card2) { Card.new(:spades, :three) }

  describe "#initialize" do
    it "initializes an array of cards" do
      expect(deck.cards.all? { |card| card.is_a?(Card) }).to be true
    end

    it "initializes with 52 cards" do
      expect(deck.cards.count).to eq(52)
    end

    it "initializes with unique cards" do
      values = deck.cards.map { |card| card.value }.uniq
      suits = deck.cards.map { |card| card.suit }.uniq
      expect(values.length).to eq(13)
      expect(suits.length).to eq(4)
    end
  end

  describe "#take" do
    it "returns correct number of cards" do
      expect(deck.take(3).length).to eq(3)
      expect(deck.take(3).all? { |el| el.is_a?(Card) }).to be true
    end

    it "removes cards from deck" do
      deck.take(3)
      expect(deck.cards.length).to eq(49)
    end
  end

  describe "#deal" do
    it "returns correct number of cards" do
      expect(deck.deal(3).length).to eq(3)
      expect(deck.deal(3).all? { |el| el.is_a?(Card) }).to be true
    end

    it "removes cards from deck" do
      deck.deal(3)
      expect(deck.cards.length).to eq(49)
    end
  end

  describe "#return" do
    it "returns given cards to the deck" do
      deck_before = deck.cards
      deck.return([card1, card2])
      expect(deck.cards).to eq(deck_before + [card1, card2])
    end
  end
end
