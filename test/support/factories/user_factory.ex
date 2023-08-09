defmodule Clarx.Factories.UserFactory do
  use ExMachina.Ecto, repo: Clarx.Repo

  # credo:disable-for-this-file Credo.Check.Readability.ModuleDoc
  # credo:disable-for-this-file Credo.Check.Readability.Specs

  alias Clarx.Identity.Users.User

  def user_factory do
    password = Base.encode64(:crypto.strong_rand_bytes(32), padding: false)

    %User{
      id: Faker.UUID.v4(),
      name: Faker.Person.name(),
      email: Faker.Internet.email(),
      password: password,
      password_hash: Argon2.hash_pwd_salt(password),
      inserted_at: Faker.DateTime.backward(366),
      updated_at: DateTime.utc_now()
    }
  end
end
