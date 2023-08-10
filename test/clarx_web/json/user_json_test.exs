defmodule ClarxWeb.UserJSONTest do
  use ClarxWeb.ConnCase, async: true

  import Clarx.Factories.UserFactory

  alias ClarxWeb.UserJSON

  describe "render/3 returns success" do
    setup [:build_user]

    test "with a list of users", %{user: user} do
      assert %{data: [user_data]} = UserJSON.index(%{users: [user]})

      assert user_data.id == user.id
      assert user_data.name == user.name
      assert user_data.email == user.email
      assert user_data.inserted_at == DateTime.to_iso8601(user.inserted_at)
      assert user_data.updated_at == DateTime.to_iso8601(user.updated_at)
    end

    test "with a single user", %{user: user} do
      assert %{data: user_data} = UserJSON.show(%{user: user})

      assert user_data.id == user.id
      assert user_data.name == user.name
      assert user_data.email == user.email
      assert user_data.inserted_at == DateTime.to_iso8601(user.inserted_at)
      assert user_data.updated_at == DateTime.to_iso8601(user.updated_at)
    end
  end

  defp build_user(_) do
    :user
    |> build()
    |> Map.put(:password, nil)
    |> then(&{:ok, user: &1})
  end
end
