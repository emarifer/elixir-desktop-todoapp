defmodule TodoApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # generates a keyword list of type ==>
    # `[database: "/home/your_home_dir/.config/todo_app/database.sqlite3"]`
    Application.put_env(:todo_app, TodoApp.Repo,
      database: Path.join(config_dir(), "/database.sqlite3")
    )

    # {Ecto.Migrator,
    #    repos: Application.fetch_env!(:todo_app, :ecto_repos), skip: skip_migrations?()},

    children = [
      TodoAppWeb.Telemetry,
      TodoApp.Repo,
      {Ecto.Migrator, repos: Application.fetch_env!(:todo_app, :ecto_repos), skip: false},
      {DNSCluster, query: Application.get_env(:todo_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TodoApp.PubSub},
      # Start a worker by calling: TodoApp.Worker.start_link(arg)
      # {TodoApp.Worker, arg},
      # Start to serve requests, typically the last entry
      TodoAppWeb.Endpoint,
      {Desktop.Window,
       [
         app: :todo_app,
         id: TodoAppWindow,
         title: "TodoApp",
         size: {575, 675},
         icon: "static/images/icon.png",
         url: &TodoAppWeb.Endpoint.url/0
       ]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TodoApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TodoAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # defp skip_migrations?() do
  #   # By default, sqlite migrations are run when using a release
  #   System.get_env("RELEASE_NAME") != nil
  # end

  defp config_dir() do
    Path.join([Desktop.OS.home(), ".config", "todo_app"])
  end
end

# export WEBKIT_DISABLE_COMPOSITING_MODE=1

# REFERENCES:
# https://github.com/asdf-vm/asdf-erlang/issues/203#issuecomment-1519137578
# export KERL_CONFIGURE_OPTIONS="--without-javac --enable-wx --enable-webview"
# https://hexdocs.pm/desktop/getting_started.html#gnu-linux
# https://github.com/version-fox/vfox-erlang/issues/9
# https://hexdocs.pm/desktop/your_first_desktop_app.html
# https://copier-coder.com/creer-une-application-windows-avec-elixir-desktop/
#
# https://asdf-vm.com/guide/getting-started.html

# git clone -b deployment https://github.com/emarifer/elixir-desktop-todoapp.git

# mix deps.get

# mix phx.gen.secret

# export SECRET_KEY_BASE=????

# mix assets.deploy

# mix desktop.installer
