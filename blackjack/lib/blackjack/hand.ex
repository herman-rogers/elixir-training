defmodule Blackjack.Hand do
  alias __MODULE__

  defstruct [:cards, :score]

  @type t :: %Hand{cards: [Blackjack.Deck.card], score: nil | 4..21}

  @spec new() :: t
  def new() do
    %Hand{cards: [], score: nil}
  end
end
