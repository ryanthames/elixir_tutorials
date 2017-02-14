defmodule ExprotobufPlayground.Data do
  use Protobuf, from: Path.expand("./files/addressbook.proto", __DIR__)
end

defmodule ExprotobufPlaygroundTest do
  use ExUnit.Case
  doctest ExprotobufPlayground

  alias ExprotobufPlayground.Data.Person
  alias ExprotobufPlayground.Data.AddressBook

  test "can define structs from the proto file" do
    assert %Person{name: "Ryan"}.name == "Ryan"
  end

  test "building and addressbook" do
    addressbook = %AddressBook{
      people: [
        %Person{name: "Josh Adams", id: 1},
        %Person{name: "Jose Valim", id: 2}
      ]
    }

    binary = Protobuf.Encoder.encode(addressbook, AddressBook.defs)
    addressbook2 = Protobuf.Decoder.decode(binary, AddressBook)

    josh = hd(addressbook2.people)
    assert josh.name == "Josh Adams"
  end
end
