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

  @impl true
  def init(_) do
    {:ok, :queue.new()}
  end

  @impl true
  def handle_call({:enqueue, update}, _from, queue) do
    {:reply, "something", :queue.in(update, queue)}
  end

  @impl true
  def handle_call({:dequeue}, _from, queue) do
    {{:value, head}, queue} = :queue.out(queue)
    {:reply, head, queue}
  end
end
