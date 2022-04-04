defmodule Blackjack do
  def start do
    IO.inspect("START GAME")
    rounds = :"round_#{:erlang.unique_integer()}"
    player_ids = Enum.map(1..5, &:"player_#{&1}")

    Blackjack.Server.start_link(rounds, player_ids)
  end
end

defmodule Blackjack.Server do
  use GenServer

  alias Blackjack.AutoPlayer

  def init({round_id, player_ids}) do
    {:ok, %{
      round_id: round_id,
      players: player_ids |> Enum.map(&{&1, AutoPlayer.new()}) |> Enum.into(%{})
    }}
  end

  def start_link(round_id, player_ids) do
    GenServer.start_link(__MODULE__, {round_id, player_ids}, name: round_id)
  end

  @spec player_spec(any, any) :: %{callback_args: any, callback_mod: Blackjack.Server, id: any}
  def player_spec(round_id, player_id) do
    %{id: player_id, callback_mod: __MODULE__, callback_args: round_id}
  end

end

defmodule Blackjack.AutoPlayer do
  alias Blackjack.Hand

  def new(), do: Hand.new()
end
