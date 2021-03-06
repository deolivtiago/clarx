defmodule Clarx.Geo.Country do
  use Clarx.Schema
  import Ecto.Changeset
  alias Clarx.Geo.State

  schema "countries" do
    field :code, :string
    field :name, :string
    has_many :states, State, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:id, :name, :code])
    |> validate_required([:name, :code])
    |> unique_constraint(:code)
    |> validate_length(:code, max: 5)
    |> validate_length(:name, max: 150)
    |> update_change(:code, &String.upcase/1)
    |> cast_assoc(:states)
  end
end
