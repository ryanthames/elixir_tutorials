ExUnit.start
Code.require_file("translator.exs", __DIR__)

defmodule TranslatorTest do
  use ExUnit.Case

  defmodule I18n do
    use Translator

    locale "en" [
      foo: "bar",
      flash: [
        notice: [
          alert: "Alert!",
          hello: "hello %{first} %{last}!",
        ]
      ],
      users: [
        title: "Users",
        profile: [
          title: "Profiles",
        ]
      ]
    ]

    locale "fr" [
      flash: [
        notice: [
          hello: "salut %{first} %{last}!"
        ]
      ]
    ]
  end

  test "it recursively walks translations tree" do
    assert I18n.t("en", "users.title") == "Users"
    assert I18n.t("en", "users.profile.title") == "Profiles"
  end

  test "it handles translations at root level" do
    assert I18n.t("en", "foo") == "bar"
  end
end
