defmodule Clarx.Identity.Users do
  @moduledoc """
  The Identity.Users context
  """

  alias Clarx.Identity.Users.User

  @doc """
  Returns a list of users

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  @spec list_users :: list
  defdelegate list_users, to: User.List, as: :call

  @doc """
  Gets an user

  ## Examples

      iex> get_user(value)
      {:ok, %User{}}

      iex> get_user(bad_value)
      {:error, %Ecto.Changeset{}}

  """
  @spec get_user(term) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  defdelegate get_user(id), to: User.Get, as: :call

  @doc """
  Creates an user

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_user(map) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  defdelegate create_user(user_attrs), to: User.Create, as: :call

  @doc """
  Updates an user

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_user(User.t(), map) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  defdelegate update_user(user, user_attrs), to: User.Update, as: :call

  @doc """
  Deletes an user

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_user(User.t()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  defdelegate delete_user(user), to: User.Delete, as: :call
end
