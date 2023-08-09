defmodule Clarx.Identity.Users.User.Update do
  # credo:disable-for-this-file Credo.Check.Readability.ModuleDoc
  # credo:disable-for-this-file Credo.Check.Readability.Specs

  alias Clarx.Identity.Users.User
  alias Clarx.Repo

  def call(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end
end
