defmodule FirestormData.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :title, :string

    timestamps()
  end

  def changeset(category, params \\ %{}) do
    category
    |> cast(params, [:title])
  end

  # stuff like this probably doesn't belong in the schema
  def get_recent_threads(category) do
    import Ecto.Query

    # I think I put this in the wrong file
    FirestormData.Thread
      |> join(:left_lateral, [t], p in fragment("select thread_id, inserted_at from posts where posts.thread_id = ? order by posts.inserted_at desc limit 1", t.id))
      |> order_by([t, p], [desc: p.inserted_at])
      |> select([t], t)
      |> limit(3)
  end
end
