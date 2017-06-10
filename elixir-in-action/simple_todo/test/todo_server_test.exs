defmodule TodoServerTest do
  use ExUnit.Case

  test "add entries" do
    todo_server = TodoServer.start

    TodoServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Dentist"})
    TodoServer.add_entry(todo_server, %{date: {2013, 12, 20}, title: "Shopping"})
    TodoServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Movies"})

    assert [
      %{date: {2013, 12, 19}, id: 1, title: "Dentist"}, 
      %{date: {2013, 12, 19}, id: 3, title: "Movies"}
      ] == TodoServer.entries(todo_server, {2013, 12, 19})
  end

  test "update entries" do
    todo_server = TodoServer.start

    TodoServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Dentist"})
    TodoServer.update_entry(todo_server, 1, &Map.put(&1, :date, {2013, 12, 20}))

    assert [%{date: {2013, 12, 20}, id: 1, title: "Dentist"}] == TodoServer.entries(todo_server, {2013, 12, 20})
  end

  test "delete entries" do
    todo_server = TodoServer.start

    TodoServer.add_entry(todo_server, %{date: {2013, 12, 19}, title: "Dentist"})

    assert [%{date: {2013, 12, 19}, id: 1, title: "Dentist"}] == TodoServer.entries(todo_server, {2013, 12, 19})

    TodoServer.delete_entry(todo_server, 1)

    assert [] == TodoServer.entries(todo_server, {2013, 12, 19})
  end
end