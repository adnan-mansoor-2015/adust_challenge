defmodule Bar.Repo.Migrations.CreateFooSource do
  use Ecto.Migration

  def change do
    create table(:source) do
      add :a, :integer
      add :b, :integer
      add :c, :integer
    end
  end
end
