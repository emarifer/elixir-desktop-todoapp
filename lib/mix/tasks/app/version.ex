defmodule Mix.Tasks.App.Version do
  use Mix.Task

  def run(_) do
    IO.puts(Mix.Project.config()[:version])
  end
end

# REFERENCES:
# https://mintcore.co/blog/2017/11/getting-elixir-app-version-from-command-line
