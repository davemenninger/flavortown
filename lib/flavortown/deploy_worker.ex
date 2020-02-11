defmodule Flavortown.DeployWorker do
  use GenServer

  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

  @impl true
  def init(state) do
    schedule_work()
    {:ok, state}
  end

  @impl true
  def handle_info(:work, state) do
    # Do the desired work here
    IO.puts("worker checking for work")

    IO.puts("queue length: " <> Integer.to_string(Flavortown.DeployQueue.length()))

    case Flavortown.DeployQueue.dequeue() do
      %{flavor: _flavor, url: _url, ref: _ref} = task -> deploy(task)
      nil -> IO.puts("no work")
    end

    # TODO reenqueue failures, etc

    # Reschedule once more
    schedule_work()

    {:noreply, state}
  end

  defp schedule_work do
    # secs * minutes * hours * milliseconds
    Process.send_after(self(), :work, 9 * 1 * 1 * 1000)
  end

  defp deploy(%{flavor: flavor, url: _url, ref: _ref} = task) do
    IO.puts("deploying this task:")
    IO.inspect(task)

    templates = apply(flavor, :generate_cloud_templates, [task])
    IO.inspect("templates: " <> templates)
  end
end
