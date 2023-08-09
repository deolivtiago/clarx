defmodule Clarx.Identity.Users.User.Get do
  # credo:disable-for-this-file Credo.Check.Readability.ModuleDoc
  # credo:disable-for-this-file Credo.Check.Readability.Specs

  alias Clarx.Identity.Users.User
  alias Clarx.Repo

  def call(email: email) do
    User
    |> Repo.get_by!(email: String.downcase(email))
    |> then(&{:ok, &1})
  rescue
    _error ->
      %User{}
      |> Ecto.Changeset.change(%{email: email})
      |> Ecto.Changeset.add_error(:email, "not found")
      |> then(&{:error, &1})
  end

  def call(id) do
    User
    |> Repo.get!(id)
    |> then(&{:ok, &1})
  rescue
    _error ->
      %User{}
      |> Ecto.Changeset.change(%{id: id})
      |> Ecto.Changeset.add_error(:id, "not found")
      |> then(&{:error, &1})
  end
end
