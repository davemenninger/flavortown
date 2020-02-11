defmodule Flavortown.Flavors.Default do
  def generate_cloud_templates(%{ref: ref, url: url} = task) do
    "i'm some yaml or whatever that creates #{url} on branch #{ref}"
  end
end
