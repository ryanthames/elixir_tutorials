defmodule Firestorm.Forums.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Firestorm.Forums.User


  schema "users" do
    field :email, :string
    field :name, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :name])
    |> validate_required([:username, :email, :name])
  end
end
