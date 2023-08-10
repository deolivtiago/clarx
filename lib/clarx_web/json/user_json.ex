defmodule ClarxWeb.UserJSON do
  @moduledoc """
  JSON for rendering user data
  """
  alias Clarx.Identity.Users.User

  @doc """
  Renders a list of users.
  """
  @spec index(map) :: map
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  @spec show(map) :: map
  def show(%{user: user}), do: %{data: data(user)}

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      inactive: user.inactive,
      inserted_at: DateTime.to_iso8601(user.inserted_at),
      updated_at: DateTime.to_iso8601(user.updated_at)
    }
  end
end
