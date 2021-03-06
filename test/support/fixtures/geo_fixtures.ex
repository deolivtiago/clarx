defmodule Clarx.GeoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Clarx.Geo` context.
  """

  @doc """
  Generate a unique country code.
  """
  def unique_country_code, do: "some code#{System.unique_integer([:positive])}"

  @doc """
  Generate a country.
  """
  def country_fixture(attrs \\ %{}) do
    {:ok, country} =
      attrs
      |> Enum.into(%{
        code: unique_country_code(),
        name: "some name"
      })
      |> Clarx.Geo.create_country()

    country
  end

  @doc """
  Generate a unique state code.
  """
  def unique_state_code, do: "some code#{System.unique_integer([:positive])}"

  @doc """
  Generate a state.
  """
  def state_fixture(attrs \\ %{}) do
    {:ok, state} =
      attrs
      |> Enum.into(%{
        code: unique_state_code(),
        name: "some name"
      })
      |> Clarx.Geo.create_state()

    state
  end

  @doc """
  Generate a city.
  """
  def city_fixture(attrs \\ %{}) do
    {:ok, city} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Clarx.Geo.create_city()

    city
  end
end
