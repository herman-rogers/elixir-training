defmodule Blackjack.RoundServer do
  use GenServer

  @type id :: integer
  @type player :: %{id: Round.player_id(), callback_mod: module, callback_arg: callback_arg}
  @type callback_arg :: any

  def start_link(round_id, players) do
    GenServer.start_link(
      RoundServer,
      {round_id, Enum.map(players, & &1.id)},
      name: round_id
    )
  end

  def init(init_arg) do
    {:ok, init_arg}
  end
end
