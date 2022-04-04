defmodule Blackjack.RoundServer do
  use GenServer
  import Supervisor.Spec

  @round_supervisor Blackjack.RoundsSupervisor

  @type id :: integer
  @type player :: %{id: Round.player_id, callback_mod: module, callback_arg: callback_arg}
  @type callback_arg :: any

  def init(init_arg) do
    {:ok, init_arg}
  end

  def child_spec() do
    supervisor(
      DynamicSupervisor,
      [
        [supervisor(__MODULE__, [], function: :start_supervisor)],
        [strategy: :one_for_one, name: @round_supervisor]
      ]
    )
  end

  def start_link(round_id, players) do
    GenServer.start_link(
      __MODULE__,
      {round_id, Enum.map(players, &(&1.id))},
      name: service_name(round_id)
    )
  end

  def init({round_id, player_ids}) do
    {:ok,
    player_ids
    |> Round.start()
  }
  end

  defp service_name(round_id) do
    Blackjack.service_name({__MODULE__, round_id})
  end

  # @spec start_playing(id, [player]) :: Supervisor.on_start_child
  # @spec start_playing(id :: any, [player] :: any) :: Supervisor.on_start_child
  # def start_playing(round_id, players), do:
  # end


  # @spec child_spec() :: Supervisor.Spec.spec
  # def child_spec() do
  # supervisor(
  #   Supervisor,
  #   [
  #     [supervisor(__MODULE__, [], function: :start_supervisor)],
  #     [strategy: :simple_one_for_one, name: @round_supervisor]
  #   ]
  # )
  # end

  # @spec start_playing(id, [player]) :: Supervisor.on_start_child
  # def start_playing(round_id, players) do
  #   Supervisor.start_child(@round_supervisor, [round_id, players])
  # end

end
