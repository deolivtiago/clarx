defmodule Clarx.Identity.Users.User do
  use Clarx.Schema

  @type t :: %__MODULE__{}

  @required_attrs ~w(name email password)a
  @optional_attrs ~w(inactive)a

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true, redact: true
    field :password_hash, :string
    field :inactive, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds an user

  ## Examples

      iex> build(%{field: value})
      {:ok, %User{}}

      iex> build(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec build(map) :: {:ok, __MODULE__.t()} | {:error, Ecto.Changeset.t()}
  def build(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> apply_action(:build)
  end

  @doc """
  Validates an user

  ## Examples

      iex> changeset(user, %{field: value})
      %Ecto.Changeset{}}

  """
  @spec changeset(__MODULE__.t(), map) :: Ecto.Changeset.t()
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, @required_attrs ++ @optional_attrs)
    |> validate_required(@required_attrs)
    |> unique_constraint(:id, name: :users_pkey)
    |> unique_constraint(:email)
    |> validate_length(:name, min: 2, max: 128)
    |> validate_length(:email, min: 3, max: 128)
    |> validate_length(:password, min: 6)
    |> update_change(:email, &String.downcase/1)
    |> validate_format(:email, ~r/^[a-z0-9\-._+&#$?!]+[@][a-z0-9\-._+]+$/)
    |> put_pass_hash()
  end

  defp put_pass_hash(%{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
