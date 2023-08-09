defmodule Clarx.Identity.Users.User.List do
  # credo:disable-for-this-file Credo.Check.Readability.ModuleDoc
  # credo:disable-for-this-file Credo.Check.Readability.Specs

  alias Clarx.Identity.Users.User
  alias Clarx.Repo

  def call, do: Repo.all(User)
end
