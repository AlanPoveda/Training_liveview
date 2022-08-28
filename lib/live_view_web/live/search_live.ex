defmodule LiveViewWeb.SearchLive do
  use LiveViewWeb, :live_view
  alias LiveView.Stores

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        stores: [],
        cep: "",
        city: "",
        loading: false
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Find a Store</h1>
    <div id="search">
      <form phx-submit="search-cep">
      <input
        type="text"
        name="cep"
        value="<%= @cep %>"
        placeholder="Cep"
        autofocus autocomplete="off"
        <%= if @loading, do: "readonly" %>
      />

      <button type="submit">search</button>


      </form>

      <%= if @loading do %>
        <div>
          <h2> Loading... </h2>
        <div>
      <% end %>

      <div class="stores">
        <ul>
          <%= for store <- @stores do %>
            <li>
              <div class="first-line">
                <div class="name">
                  <%= store.name %>
                </div>
                <div class="status">
                  <%= if store.open do %>
                    <span class="open">Open</span>
                  <% else %>
                    <span class="closed">Closed</span>
                  <% end %>
                </div>
              </div>
              <div class="second-line">
                <div class="street">
                  <%= store.street %>
                </div>
              </div>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
    """
  end

  def handle_event("search-cep", %{"cep" => cep}, socket) do
    send(self(), {:cep_rearch, cep})

    socket =
      assign(socket,
        cep: cep,
        stores: [],
        loading: true
      )

    {:noreply, socket}
  end

  def handle_info({:cep_rearch, cep}, socket) do
    case Stores.search_by_cep(cep) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "No store whit the cep #{cep}")
          |> assign(stores: [], loading: false)

        {:noreply, socket}

      stores ->
        socket =
          socket
          |> assign(stores: stores, loading: false)

        {:noreply, socket}
    end
  end
end
