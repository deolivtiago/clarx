defmodule ClarxWeb.UserController do
  @doc """
  Controller for handling users
  """
  use ClarxWeb, :controller

  alias Clarx.Identity.Users

  action_fallback ClarxWeb.FallbackController

  @doc """
  Handles request to list users.
  """
  @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
  def index(conn, _params) do
    users = Users.list_users()

    render(conn, :index, users: users)
  end

  @doc """
  Handles request to create user.
  """
  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"user" => user_params}) do
    with {:ok, user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/users/#{user}")
      |> render(:show, user: user)
    end
  end

  @doc """
  Handles request to get user.
  """
  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Users.get_user(id) do
      render(conn, :show, user: user)
    end
  end

  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()

  @doc """
  Handles request to update user.
  """
  def update(conn, %{"id" => id, "user" => user_params}) do
    with {:ok, user} <- Users.get_user(id),
         {:ok, user} <- Users.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  @doc """
  Handles request to delete user.
  """
  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    with {:ok, user} <- Users.get_user(id),
         {:ok, _user} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
