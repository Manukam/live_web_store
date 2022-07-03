defmodule LiveWebStoreWeb.ShopLive do
  use LiveWebStoreWeb, :live_view
  alias LiveWebStore.Products
  alias LiveWebStoreWeb.Router.Helpers, as: Routes

  @impl true
  def mount(_params, _session, socket) do
    products = Products.list_products()
    {:ok, assign(socket, products: products)}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <%= render_search_form(assigns) %> <%# added %>
    <%= render_products(assigns) %>
  """
  end

  def load_products(socket, query \\ nil) do
    IO.inspect({ "Search query", query })

    socket

    |> assign(:query, query)
    |> assign(:products, Products.list_products(query))
  end

  def render_products(assigns) do
    ~L"""
    <ul id="myUL">
    <%= if !is_nil(@query) && String.length(@query) > 0 do %>
      <%= for product <- @products do %>
        <li phx-click = "click <%= product.sku %> " class="editable-field"> <a <%= link product.title, to: Routes.product_path(@socket, :show, product.sku)%></a></li>
      <% end %>
    <% end %>
    </ul>
    """
  end

  def render_search_form(assigns) do
    ~L"""
    <%= form_for :search, "#",[phx_change: "search"], fn f -> %>
    <%= text_input f, :query, value: @query, placeholder: "Search for Products" %>
  <% end %>
    """
  end

  @impl true
  def handle_event("search", %{"search" => %{"query" => query}}, socket) do
    {:noreply, push_patch(socket, to: Routes.product_path(socket, :index, query: query))}
  end

  def handle_event("click" <> id, _, socket) do
    {:noreply, push_patch(socket, to: Routes.product_path(socket, :show, id: id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    query = params |> Map.get("query")

    {:noreply, socket |> load_products(query) }
  end

end
