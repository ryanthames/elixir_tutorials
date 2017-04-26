defmodule FirestormData.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  schema "threads" do
    field :title, :string
    belongs_to :category, FirestormData.Category

    timestamps()
  end

  def changeset(thread, params \\ %{}) do
    thread
    |> cast(params, [:category_id, :title])
  end

  def posted_in_by_user(user) do
    import Ecto.Query
    alias FirestormData.{Post, Thread}

    Post
    |> where([p], p.user_id == ^user.id)
    |> join(:inner, [p], t in Thread, p.thread_id == t.id)
    |> select([p, t], t)
  end
end
