defmodule Clarx.Identity.Users.User.Delete do
  # credo:disable-for-this-file Credo.Check.Readability.ModuleDoc
  # credo:disable-for-this-file Credo.Check.Readability.Specs

  alias Clarx.Identity.Users.User
  alias Clarx.Repo

  def call(%User{} = user), do: Repo.delete(user)
end
