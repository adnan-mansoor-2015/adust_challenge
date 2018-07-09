defmodule Foo.Source do
  use Ecto.Schema

  schema "source" do
    field :a, :integer
    field :b, :integer
    field :c, :integer
  end
end