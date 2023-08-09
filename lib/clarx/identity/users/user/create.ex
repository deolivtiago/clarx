defmodule Clarx.Identity.Users.User.Create do
  # credo:disable-for-this-file Credo.Check.Readability.ModuleDoc
  # credo:disable-for-this-file Credo.Check.Readability.Specs

  alias Clarx.Identity.Users.User
  alias Clarx.Repo

  def call(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
