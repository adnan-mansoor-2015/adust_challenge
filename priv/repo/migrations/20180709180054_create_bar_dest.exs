defmodule AdjustServer.Repo.Migrations.CreateBarDest do
  use Ecto.Migration

  def change do
    create table(:dest) do
      add :a, :integer
      add :b, :integer
      add :c, :integer
    end
  end
end
