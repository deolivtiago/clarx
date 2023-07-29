defmodule Clarx.Schema do
  @moduledoc """
  Define a module to be used as base schema.
  """

  # credo:disable-for-next-line
  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @timestamps_opts [type: :utc_datetime]
    end
  end
end
