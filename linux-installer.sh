#!/bin/bash

OUTPUT="$(exec mix phx.gen.secret)"

export SECRET_KEY_BASE=$OUTPUT

# Generate release build

MIX_ENV=prod mix assets.deploy

MIX_ENV=prod mix release

# Generate files

cat > run << EOF
#!/bin/bash
# Ubuntu bug workaround (see e.g. https://github.com/reflex-frp/reflex-platform/issues/735)

export WEBKIT_DISABLE_COMPOSITING_MODE=1

exec bin/todo_app start
EOF

cat > elixir-desktop-todoapp.desktop << EOF
[Desktop Entry]
Version=0.1.0
Type=Application
Name=Todo App
Comment=Elixir Desktop Todoapp Demo
Icon=$HOME/.local/bin/todo_app/lib/todo_app-0.1.0/priv/static/images/icon.png
Exec=sh $HOME/.local/bin/todo_app/run
Path=$HOME/.local/bin/todo_app
Actions=
Categories=Development;
Keywords=elixir-desktop;
Terminal=false
StartupNotify=false
EOF

chmod +x run

mv run _build/prod/rel/todo_app/

cp -R _build/prod/rel/todo_app/ $HOME/.local/bin/

mv elixir-desktop-todoapp.desktop $HOME/.local/share/applications/

