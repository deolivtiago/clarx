defmodule Clarx.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", "DROP EXTENSION citext"

    create table(:users) do
      add :name, :string, size: 128, null: false
      add :email, :citext, null: false
      add :password_hash, :string, null: false
      add :inactive, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
