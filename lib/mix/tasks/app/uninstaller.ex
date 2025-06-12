defmodule Mix.Tasks.App.Uninstaller do
  use Mix.Task

  @impl Mix.Task
  def run(_command_line_args) do
    home = Desktop.OS.home()
    path = Path.join([home, ".local/share/applications", "elixir-desktop-todoapp.desktop"])

    File.rm!(path)
    File.rm_rf!(Path.join([home, ".local/bin/todo_app/"]))
    File.rm_rf!(Path.join([home, ".config/todo_app/"]))
    File.rm_rf!("_build/prod")
  end
end
