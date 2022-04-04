defmodule Blackjack.RoundServer do
  use GenServer
  import Supervisor.Spec

  @round_supervisor Blackjack.RoundsSupervisor

  @type id :: integer
  @type player :: %{id: Round.player_id(), callback_mod: module, callback_arg: callback_arg}
  @type callback_arg :: any

  def init(init_arg) do
    {:ok, init_arg}
  end

  def child_spec() do
    # supervisor(
    # DynamicSupervisor,
    # [
    # [supervisor(__MODULE__, [], function: :start_supervisor)],
    # [strategy: :one_for_one, name: @round_supervisor]
    # ]
    # )

    children = [
      {
        DynamicSupervisor,
        strategy: :one_for_one, name: @round_supervisor
      }
    ]
  end

  def start_link(round_id, players) do
    GenServer.start_link(
      __MODULE__,
      {round_id, Enum.map(players, & &1.id)},
      name: service_name(round_id)
    )
  end

  def init({round_id, player_ids}) do
    {:ok}
  end

  defp service_name(round_id) do
    # Blackjack.service_name({__MODULE__, round_id})
  end
end
