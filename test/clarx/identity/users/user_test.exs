defmodule Clarx.Identity.Users.UserTest do
  use Clarx.DataCase, async: true

  import Clarx.Factories.UserFactory

  alias Clarx.Identity.Users.User
  alias Ecto.Changeset

  setup do
    :user
    |> params_for()
    |> then(&{:ok, attrs: &1})
  end

  describe "build/1 returns ok" do
    test "when attrs are valid", %{attrs: attrs} do
      {:ok, user} = User.build(attrs)

      assert user.name == attrs.name
      assert user.email == String.downcase(attrs.email)
      assert Argon2.verify_pass(user.password, user.password_hash)
    end
  end

  describe "build/1 returns error" do
    test "when attrs are invalid" do
      attrs = %{name: "?", email: "email.invalid", password: nil}

      {:error, changeset} = User.build(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.name, "should be at least 2 character(s)")
      assert Enum.member?(errors.email, "has invalid format")
      assert Enum.member?(errors.password, "can't be blank")
    end
  end

  describe "changeset/2 returns a valid changeset" do
    test "when name is valid", %{attrs: attrs} do
      changeset = User.changeset(%User{}, attrs)

      assert %Changeset{valid?: true, changes: changes} = changeset
      assert changes.name == attrs.name
    end

    test "when email is valid", %{attrs: attrs} do
      attrs = Map.put(attrs, :email, String.upcase(attrs.email))

      changeset = User.changeset(%User{}, attrs)

      assert %Changeset{valid?: true, changes: changes} = changeset
      assert changes.email == String.downcase(attrs.email)
    end

    test "when password is valid", %{attrs: attrs} do
      changeset = User.changeset(%User{}, attrs)

      assert %Changeset{valid?: true, changes: changes} = changeset
      assert Argon2.verify_pass(changes.password, changes.password_hash)
    end
  end

  describe "changeset/2 returns an invalid changeset" do
    test "when name is too short", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, "?")

      changeset = User.changeset(%User{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.name, "should be at least 2 character(s)")
    end

    test "when name is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, nil)

      changeset = User.changeset(%User{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.name, "can't be blank")
    end

    test "when name is not given", %{attrs: attrs} do
      attrs = Map.delete(attrs, :name)

      changeset = User.changeset(%User{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.name, "can't be blank")
    end

    test "when name is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, "")

      changeset = User.changeset(%User{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.name, "can't be blank")
    end

    test "when email is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :email, nil)

      changeset = User.changeset(%User{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.email, "can't be blank")
    end

    test "when email is not given", %{attrs: attrs} do
      attrs = Map.delete(attrs, :email)

      changeset = User.changeset(%User{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.email, "can't be blank")
    end

    test "when email is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :email, "")

      changeset = User.changeset(%User{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.email, "can't be blank")
    end

    test "when email has invalid format", %{attrs: attrs} do
      attrs = Map.put(attrs, :email, "email.invalid")

      changeset = User.changeset(%User{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.email, "has invalid format")
    end

    test "when email is too short", %{attrs: attrs} do
      attrs = Map.put(attrs, :email, "@")

      changeset = User.changeset(%User{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.email, "should be at least 3 character(s)")
    end

    test "when password is too short", %{attrs: attrs} do
      attrs = Map.put(attrs, :password, "?")

      changeset = User.changeset(%User{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.password, "should be at least 6 character(s)")
    end

    test "when password is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :password, nil)

      changeset = User.changeset(%User{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.password, "can't be blank")
    end

    test "when password is not given", %{attrs: attrs} do
      attrs = Map.delete(attrs, :password)

      changeset = User.changeset(%User{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.password, "can't be blank")
    end

    test "when password is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :password, "")

      changeset = User.changeset(%User{}, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.password, "can't be blank")
    end
  end
end
