defmodule SimpleTodoTest do
  use ExUnit.Case
  doctest TodoList

  alias TodoList.CsvImporter

  test "add entries" do
    todo_list = 
      TodoList.new |>
        TodoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"}) |>
        TodoList.add_entry(%{date: {2013, 12, 20}, title: "Shopping"}) |>
        TodoList.add_entry(%{date: {2013, 12, 19}, title: "Movies"})
    
    assert [%{date: {2013, 12, 19}, id: 1, title: "Dentist"}, %{date: {2013, 12, 19}, id: 3, title: "Movies"}] == TodoList.entries(todo_list, {2013, 12, 19})
    assert [] == TodoList.entries(todo_list, {2013, 12, 18})
  end

  test "update entries" do
    todo_list = TodoList.new |> TodoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
    todo_list = TodoList.update_entry(todo_list, 1, &Map.put(&1, :date, {2013, 12, 20}))
    %{auto_id: _id, entries: entries} = todo_list
    %{1 => %{date: date, title: _title}} = entries

    assert {2013, 12, 20} == date
  end

  test "delete entries" do
    todo_list = TodoList.new |> TodoList.add_entry(%{date: {2013, 12, 19}, title: "Dentist"})
    todo_list = TodoList.delete_entry(todo_list, 1)

    assert [] == TodoList.entries(todo_list, {2013, 12, 19})
  end

  test "import from csv" do
    todo_list = CsvImporter.import("todos.csv")
    assert [%{date: {2013, 12, 19}, id: 1, title: "Dentist"}, %{date: {2013, 12, 19}, id: 3, title: "Movies"}] == TodoList.entries(todo_list, {2013, 12, 19})
  end
end
