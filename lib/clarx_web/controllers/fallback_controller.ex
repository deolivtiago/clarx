defmodule ClarxWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ClarxWeb, :controller

  @doc """
  Handles changeset errors
  """
  @spec call(Plug.Conn.t(), {:error, Ecto.Changeset.t()}) :: Plug.Conn.t()
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: ClarxWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end
end
