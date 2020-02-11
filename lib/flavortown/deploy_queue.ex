defmodule Flavortown.DeployQueue do
  use GenServer

  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

  def enqueue(update) do
    GenServer.call(__MODULE__, {:enqueue, update})
  end

  def dequeue do
    GenServer.call(__MODULE__, {:dequeue})
  end

  def length do
    GenServer.call(__MODULE__, {:length})
  end

  @impl true
  def init(_) do
    {:ok, :queue.new()}
  end

  @impl true
  def handle_call({:enqueue, update}, _from, queue) do
    {:reply, "something", :queue.in(update, queue)}
  end

  @impl true
  def handle_call({:length}, _from, queue) do
    # NOTE: this is O(n)
    {:reply, :queue.len(queue), queue}
  end

  @impl true
  def handle_call({:dequeue}, _from, queue) do
    case :queue.out(queue) do
      {{:value, head}, queue} -> {:reply, head, queue}
      {:empty, queue} -> {:reply, nil, queue}
    end
  end
end
