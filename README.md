<div align="center">

# Elixir Desktop Todoapp

#### Elixir Todo App using the Desktop library with LiveView to create a desktop app

<br />

<img src="docs/screenshot_elexir-desktop-todoapp.gif" width="50%">

<br />

![GitHub License](https://img.shields.io/github/license/emarifer/elixir-desktop-todoapp) ![Static Badge](https://img.shields.io/badge/Elixir-%3E=1.18-6e4a7e) ![Static Badge](https://img.shields.io/badge/Erlang/OTP-%3E=27-B83998) ![Static Badge](https://img.shields.io/badge/PhoenixFramework-%3E=1.7.21-fd4f00)

</div>

---

### 📖 Explanation

This is a sample desktop application that uses web technology for the `UI`. Developing desktop applications with a web interface is becoming the standard for such applications because they provide a pleasant `UX`, to which the user is already accustomed, and they allow developers to reuse knowledge and even some of the code they have already used in the backend of a website or the interface.

Frameworks/libraries such as [`ElectronJS`](https://www.electronjs.org/) (for JavaScript/NodeJS, although there is some rejection from some devs due to the size of its executables and the high resource consumption it demands from our machine), [`Tauri`](https://v2.tauri.app/) (for `Rust`) or [`Wails`](https://wails.io/) (for `Golang`), to mention the most used/recent technologies, are good examples of this. All of them have the advantage, in addition to the aforementioned advantages, of being fairly mature and proven libraries. However, they use a different language (JavaScript, Rust, Golang, etc.) for the backend than the frontend (which will likely be a JS framework [`React`, `Svelte`, `Vue`, `SolidJS`, etc.] or even Vanilla JavaScript).

In this case, we use the [`Desktop`](https://hexdocs.pm/desktop/readme.html) library. While Desktop is not as mature or widely used a library as the ones mentioned (among other things, because `Elixir` or other languages ​​on the `BEAM VM` are less popular), it has the enormous advantage of "fully wrapping" an application made with the [`Phoenix`](https://hexdocs.pm/phoenix/Phoenix.html) + [`Liveview`](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html) framework. That is, we can "dump directly" the full potential of a Web application that we have already developed with Phoenix-Liveview directly into the desktop application, all by adding just over four lines of code and without leaving Elixir/Phoenix, in an astonishingly easy way.

`Desktop`, like the aforementioned libraries for other languages, allows for easy integration with the operating system and its windowing system by easily adding `native menu bars`, `pop-ups`, or `notifications` (see the [example application](https://github.com/elixir-desktop/desktop-example-app)). Unfortunately, this is not true for the latest versions of Phoenix-Liveview like the ones we use here (Phoenix v1.7.21 & Liveview v1.0). This results in the fact that when trying to create an application menu module in `XML`, as shown in the sample example, we receive a compiler warning (`cannot import Phoenix.HTML.sigil_e/2 because it is undefined or private`), which results in a runtime error.

However, the library works perfectly on older versions of Phoenix-Liveview(`Phoenix v1.7`, `Liveview v0.20`, `phoenix_html v3.3` y `phoenix_view v2.0`) if we choose to forgo the latter advantages offered by the versions we use here. However, it should be noted that the main [`contributor`](https://github.com/dominicletz) to the development of this library [`promises to update`](https://github.com/elixir-desktop/deployment/issues/7#issuecomment-2619596018) it to make it compatible with the latest versions of Phoenix-Liveview.

Another topic that is considerably less mature than those mentioned above is the bundling of build artifacts and assets for distribution of executables. In this regard, here you can see the status of the library's [`roadmap`](https://hexdocs.pm/desktop/readme.html#status-roadmap) and what its authors intend to accomplish.

Let's hope this fantastic project for the Elixir ecosystem continues to develop 🙏.

---

### 👨‍🚀 Getting Started

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

---

### 📚 Learn more

  * You can see an excellent talk by its author about the `Elixir Desktop` library at [`Code BEAM V EU 2021`](https://codesync.global/conferences/code-beam-sto-2021/): https://www.youtube.com/watch?v=P6b-2RnPKBs
  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

---

### Happy coding 😀!!
