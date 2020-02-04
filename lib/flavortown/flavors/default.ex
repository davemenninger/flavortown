defmodule Flavortown.Flavors.Default do
  def generate_stack(ref: ref, url: url) do
    "i'm some yaml or whatever that creates #{url} on branch #{ref}"
  end
end
