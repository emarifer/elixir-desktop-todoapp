defmodule Mix.Tasks.App.Installer do
  use Mix.Task

  @impl Mix.Task
  def run(_command_line_args) do
    version = Mix.Project.config()[:version]

    home = Desktop.OS.home()

    path = Path.join([home, ".local/share/applications", "elixir-desktop-todoapp.desktop"])

    desktop_content = """
    [Desktop Entry]
    Version=#{version}
    Type=Application
    Name=Todo App v#{version}
    Comment=Elixir Desktop Todoapp Demo v#{version}
    Icon=#{home}/.local/bin/todo_app/lib/todo_app-#{version}/priv/static/images/icon.png
    Exec=sh #{home}/.local/bin/todo_app/run
    Path=#{home}/.local/bin/todo_app
    Actions=
    Categories=Development;
    Keywords=elixir-desktop;
    Terminal=false
    StartupNotify=false
    """

    run_content = """
    #!/bin/bash
    # Ubuntu bug workaround (see e.g. https://github.com/reflex-frp/reflex-platform/issues/735)

    export WEBKIT_DISABLE_COMPOSITING_MODE=1

    exec bin/todo_app start
    """

    Mix.env(:prod)
    Mix.Task.run("assets.deploy")

    Mix.Task.run("release")

    File.write!("_build/prod/rel/todo_app/run", run_content)
    File.chmod("_build/prod/rel/todo_app/run", 0o777)

    File.write!(path, desktop_content)

    File.cp_r("_build/prod/rel/", Path.join([home, ".local/bin/"]))
  end
end

# REFERENCES:
# https://mintcore.co/blog/2017/11/getting-elixir-app-version-from-command-line
# https://stackoverflow.com/questions/41656482/how-do-i-run-a-mix-task-from-within-a-mix-task
# https://askubuntu.com/questions/518259/understanding-chmod-symbolic-notation-and-use-of-octal

# def run(_command_line_args) do
#   Mix.Shell.cmd("mix phx.gen.secret", &System.put_env("SECRET_KEY_BASE", &1))
#   System.get_env("SECRET_KEY_BASE") |> IO.inspect(label: "SECRET_KEY_BASE")
# end
