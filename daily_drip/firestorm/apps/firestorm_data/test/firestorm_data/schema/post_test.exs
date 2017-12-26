defmodule FirestormData.PostTest do
  alias FirestormData.{Category, User, Thread, Post, Repo}
  use ExUnit.Case
  import Ecto.Query
  import FirestormData.Factory

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

  test "finding a user's Posts", %{josh: josh} do
    [post1, post2, post3] = insert_list(3, :post, %{user: josh})
    [post4, post5, post6] = insert_list(3, :post)

    post_ids =
      josh
      |> Post.for_user
      |> Repo.all
      |> Enum.map(&(&1.id))

    assert post1.id in post_ids
    assert post2.id in post_ids
    assert post3.id in post_ids
    refute post4.id in post_ids
    refute post5.id in post_ids
    refute post6.id in post_ids
  end

  test "finding posts with a particular string in them" do
    post1 = insert(:post, %{body: "bar banana foo"})
    post2 = insert(:post, %{body: "bar potato foo"})
    post3 = insert(:post, %{body: "bar zanzibar foo"})

    post_ids =
      "banana"
      |> Post.containing_body
      |> Repo.all
      |> Enum.map(&(&1.id))
    
    assert [post1.id] == post_ids
  end
  
  describe "given some posts" do
    setup [:create_other_users, :create_more_threads, :create_sample_posts]

    test "finding a post by a user", %{post1: post1, josh: josh} do
      query =
        from p in Post,
        where: p.user_id == ^josh.id,
        preload: [:user]

      posts = Repo.all(query)
      assert post1.id in Enum.map(posts, &(&1.id))
      assert hd(posts).user.username == "josh"
    end

    # test "counting the posts in a thread", %{otp: otp} do
    #   query =
    #     from p in Post,
    #     where: p.thread_id == ^otp.id

    #   posts_count = Repo.aggregate(query, :count, :id)
    #   assert posts_count == 2
    # end

    # test "find three threads with the most recent posts in a category", %{category: category, hlp: hlp, erl: erl, fp: fp} do
    #   query = 
    #     from p in Post,
    #     join: t in Thread,
    #     where: p.thread_id == t.id and t.category_id == ^category.id,
    #     order_by: [desc: p.inserted_at],
    #     limit: 3,
    #     preload: [:thread]

    #   posts = Repo.all(query)
    #   threads = posts |> Enum.map(&(&1.thread))
    #   assert length(threads) == 3
    #   assert hd(threads).id == hlp.id
    # end

    # test "find all threads a user has posted in", %{josh: josh, adam: adam} do
    #   josh_query = 
    #     from t in Thread,
    #     join: p in Post,
    #     where: p.thread_id == t.id and p.user_id == ^josh.id

    #   adam_query = 
    #     from t in Thread,
    #     join: p in Post,
    #     where: p.thread_id == t.id and p.user_id == ^adam.id

    #   josh_count = Repo.aggregate(josh_query, :count, :id)
    #   adam_count = Repo.aggregate(adam_query, :count, :id)

    #   assert josh_count == 1
    #   assert adam_count == 5
    # end

    # test "find number of posts in a thread", %{otp: otp} do
    #   query = 
    #     from p in Post,
    #     where: p.thread_id == ^otp.id

    #   assert Repo.aggregate(query, :count, :id) == 2
    # end

    # test "find posts that contain a string in the body" do
    #   query =
    #     from p in Post,
    #     where: like(p.body, "%b%")

    #   posts = Repo.all(query)
    #   assert length(posts) == 5
    # end
  end
  
  defp create_other_users(_) do
    adam = 
      %User{username: "adam", email: "adam@dailydrip.com", name: "Adam Dill"}
      |> Repo.insert!
    
    {:ok, adam: adam}
  end

  defp create_sample_posts(%{otp: otp, pipe: pipe, fp: fp, erl: erl, hlp: hlp, josh: josh, adam: adam}) do
    post1 =
      %Post{}
      |> Post.changeset(%{thread_id: otp.id, user_id: josh.id, body: "a"})
      |> Repo.insert!

    post2 =
      %Post{}
      |> Post.changeset(%{thread_id: otp.id, user_id: adam.id, body: "b"})
      |> Repo.insert!

    post3 =
      %Post{}
      |> Post.changeset(%{thread_id: pipe.id, user_id: adam.id, body: "b"})
      |> Repo.insert!

    post4 =
      %Post{}
      |> Post.changeset(%{thread_id: fp.id, user_id: adam.id, body: "b"})
      |> Repo.insert!

    post5 =
      %Post{}
      |> Post.changeset(%{thread_id: erl.id, user_id: adam.id, body: "b"})
      |> Repo.insert!

    post6 =
      %Post{}
      |> Post.changeset(%{thread_id: hlp.id, user_id: adam.id, body: "b"})
      |> Repo.insert!
    
    {:ok, post1: post1, post2: post2}
  end

  defp create_more_threads(%{category: category}) do
    {:ok, pipe} = %Thread{title: "The pipe operator is great", category_id: category.id} |> Repo.insert
    {:ok, fp} = %Thread{title: "Functional programming is swell", category_id: category.id} |> Repo.insert
    {:ok, erl} = %Thread{title: "Erlang is super relaible, pals", category_id: category.id} |> Repo.insert
    {:ok, hlp} = %Thread{title: "Help! I suck at elixir!", category_id: category.id} |> Repo.insert

    {:ok, pipe: pipe, fp: fp, erl: erl, hlp: hlp}
  end
end