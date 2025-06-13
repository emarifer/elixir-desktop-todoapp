defmodule Mix.Tasks.App.Dev do
  use Mix.Task

  @impl Mix.Task
  def run(_command_line_args) do
    Mix.Shell.cmd("WEBKIT_DISABLE_COMPOSITING_MODE=1 iex -S mix", &IO.write(&1))
  end
end

# THIS IS THE BASH SCRIPT FOR LINUX EQUIVALENT TO THIS MIX TASK:

#!/bin/bash

# Ubuntu bug workaround (see e.g. https://github.com/reflex-frp/reflex-platform/issues/735)
# export WEBKIT_DISABLE_COMPOSITING_MODE=1

# exec iex -S mix
