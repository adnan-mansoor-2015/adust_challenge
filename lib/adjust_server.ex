defmodule AdjustServer do
  @moduledoc """
  AdjustServer keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """


  def perform_migration do
    # This function inserts 1 millions in Foo.Repo (source table)
    # It then copies them to destination table

    require Foo.Repo
    require Bar.Repo
    require Foo.Source
    require Bar.Dest
    require Integer
    require String
    require List

    # Inerting 1 million rows in foo
    total_rows = 1000000
    chunk_size = 500

    # Deletes any previous entries
    Foo.Repo.delete_all(Foo.Source)

    # Inserting 1 to 1000000 into Foo.Source in batches of 100 to avoid large queries
    bulk_insert(Foo.Repo, Foo.Source, 1, [], total_rows, chunk_size)

    # Deletes any previous entries
    Bar.Repo.delete_all(Bar.Dest)

    # Loads all Foo.Repo source entries into a stream
    columns = ["a", "b", "c"]
    stream = Ecto.Adapters.SQL.stream(Foo.Repo, "COPY (SELECT #{Enum.join(columns, ",")} FROM source) to STDOUT WITH CSV DELIMITER ',' ESCAPE '\"'", [], [max_rows: total_rows])

    # Loads stream into array
    {:ok, [result|_t]} = Foo.Repo.transaction(fn -> Enum.to_list(stream) end)

    # Performs reformating to be given to Repo.insert_all
    trimmed_rows = Enum.map(result.rows, fn(my_str) -> String.trim_trailing(my_str, "\n") end)
    splitted_rows = Enum.map(trimmed_rows, fn(my_str) -> String.split(my_str, ",") end)
    int_rows = Enum.map(splitted_rows, fn(row) -> [a: String.to_integer(Enum.at(row, 0)), b: String.to_integer(Enum.at(row, 1)), c: String.to_integer(Enum.at(row, 2))] end)
    insert_chunks = Enum.chunk_every(int_rows, chunk_size)

    Enum.map(insert_chunks, fn(insert_chunk) -> Bar.Repo.insert_all(Bar.Dest, insert_chunk) end)
  end

  #
  # Bulks inserts number 1 to 1000000 into Foo.Repo in chunks of 500
  #
  def bulk_insert(repo, table_dto, it, accum_list, total_rows, chunk_size) when it > total_rows do
    repo.insert_all(table_dto, accum_list)
  end

  def bulk_insert(repo, table_dto, it, accum_list, total_rows, chunk_size) do

    i = rem(it,chunk_size)

    accum_list = accum_list ++ [[a: it, b: rem(it,3), c: rem(it,5)]]

    if i == 0 do
      repo.insert_all(table_dto, accum_list)
      accum_list = []
    end
    bulk_insert(repo, table_dto, it+1, accum_list, total_rows, chunk_size)
  end

end
