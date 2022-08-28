defmodule LiveViewWeb.LiveSales do
  use LiveViewWeb, :live_view
  alias LiveView.Sales

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    socket = socket_events(socket)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <h1>Sales Dashboard</h1>
    <div id="dashboard">
    <div class="stats">
    <div class="stat">
      <span class="value">
        <%= @new_orders %>
      </span>
      <span class="name">
        New Orders
      </span>
    </div>
    <div class="stat">
      <span class="value">
        $<%= @sales_amount %>
      </span>
      <span class="name">
        Sales Amount
      </span>
    </div>
    <div class="stat">
      <span class="value">
        <%= @satisfaction %>%
      </span>
      <span class="name">
        Satisfaction
      </span>
    </div>
    </div>
    <button phx-click="refresh">
    Refresh
    </button>
    </div>
    """
  end

  def handle_event("refresh", _, socket) do
    socket = socket_events(socket)
    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    socket = socket_events(socket)
    {:noreply, socket}
  end

  defp socket_events(socket) do
    assign(
      socket,
      new_orders: Sales.new_orders(),
      sales_amount: Sales.sales_amount(),
      satisfaction: Sales.satisfaction()
    )
  end
end
