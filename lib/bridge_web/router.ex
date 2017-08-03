defmodule BridgeWeb.Router do
  use BridgeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :ensure_user_id
    plug :put_user_token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BridgeWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Users are identified by a UUID that is automatically assigned.
  #
  # These UUIDs are stored via a cookie. When the cookie is present, this
  # function is a NOP. When the cookie is absent, this function generates it.
  defp ensure_user_id(conn, _) do
    unless get_session(conn, :user_id) do
      conn = put_session(conn, :user_id, UUID.uuid4())
    end
    assign(conn, :user_id, get_session(conn, :user_id))
  end

  defp put_user_token(conn, _) do
    user_id = conn.assigns[:user_id]
    token = Phoenix.Token.sign(conn, "user token", user_id)
    assign(conn, :user_token, token)
  end
end
