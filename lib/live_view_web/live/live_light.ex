defmodule LiveViewWeb.LiveLight do
  use LiveViewWeb, :live_view


  def mount(_params, _session, socket) do
    socket = assign(socket, :brig, 10)
    {:ok, socket}
  end


  def render(assigns) do
    ~L"""
    <h1> Renderizar a luz </h1>

    <div>
      <%= @brig %>
    </div>

      <button phx-click="on"> UP </button>
      <button phx-click="up"> + </button>
      <button phx-click="down"> - </button>
      <button phx-click="off"> Down  </button>

    """
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brig, 100)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brig, 0)
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brig, &(&1+10))
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brig, &(&1 - 10))
    {:noreply, socket}
  end

end
