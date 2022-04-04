defmodule Blackjack.Deck do
  @type card :: %{suit: suit, rank: rank}
  @type suit :: :spades | :hearts | :diamonds | :clubs
  @type rank :: 2..10 | :jack | :queen | :king | :ace

  @cards for suit <- [:spades, :hearts, :diamonds, :clubs],
             rank <- [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace],
             do: %{suit: suit, rank: rank}

  def shuffle_deck() do
    Enum.shuffle(@cards)
  end
end
