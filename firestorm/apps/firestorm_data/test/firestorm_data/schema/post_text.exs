defmodule PostTest do
  alias FirestormData.{User, Category, Thread, Post, Repo}
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    {:ok, category} = %Category{title: "Elixir"} |> Repo.insert
    {:ok, otp} = %Thread{title: "OTP is neat", category_id: category.id} |> Repo.insert
    {:ok, josh} = %User{username: "josh", email: "josh@dailydrip.com", name: "Josh Adams"} |> Repo.insert
    {:ok, category: category, otp: otp, josh: josh}
  end

  test "creating a post", %{otp: otp, josh: josh} do
    post_changeset =
      %Post{}
      |> Post.changeset(%{thread_id: otp.id, body: "I know, right?", user_id: josh.id})

    assert {:ok, _} = Repo.insert(post_changeset)
  end
end
