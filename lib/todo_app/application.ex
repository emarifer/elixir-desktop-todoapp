defmodule TodoApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TodoAppWeb.Telemetry,
      TodoApp.Repo,
      {Ecto.Migrator,
       repos: Application.fetch_env!(:todo_app, :ecto_repos), skip: skip_migrations?()},
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

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") != nil
  end
end

# export WEBKIT_DISABLE_COMPOSITING_MODE=1
