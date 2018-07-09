


defmodule AdjustServer.MainController do
  use AdjustServerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def get_source_foo(conn, _params) do

    require Foo.Repo

    # Inerting 1 million rows in foo
    total_rows = 1000000

    columns = ["a", "b", "c"]
    stream = Ecto.Adapters.SQL.stream(Foo.Repo, "COPY (SELECT #{Enum.join(columns, ",")} FROM source) to STDOUT WITH CSV DELIMITER ',' ESCAPE '\"'", [], [max_rows: total_rows])

    {:ok, [result|_t]} = Foo.Repo.transaction(fn -> Enum.to_list(stream) end)

    conn = conn
           |> put_resp_content_type("text/event-stream")
           |> send_chunked(200)

    Enum.map(result.rows, fn(my_str) -> conn |> chunk(my_str) end)
    conn
  end

  def get_dest_bar(conn, _params) do

    require Bar.Repo

    # Inerting 1 million rows in foo
    total_rows = 1000000
    columns = ["a", "b", "c"]

    stream = Ecto.Adapters.SQL.stream(Bar.Repo, "COPY (SELECT #{Enum.join(columns, ",")} FROM dest) to STDOUT WITH CSV DELIMITER ',' ESCAPE '\"'", [], [max_rows: total_rows])

    {:ok, [result|_t]} = Bar.Repo.transaction(fn -> Enum.to_list(stream) end)

    conn = conn
           |> put_resp_content_type("text/event-stream")
           |> send_chunked(200)

    Enum.map(result.rows, fn(my_str) -> conn |> chunk(my_str) end)

    conn
  end

  #  def start(conn, _params) do
#    {git_root_dir_result, 0} = System.cmd("git", ["rev-parse", "--show-toplevel"])
#    git_root_dir = String.replace_suffix(git_root_dir_result, "\n", "")
#
#    cmd = "cd #{git_root_dir} && sh start.sh"
#    opts = [out: {:send, self()}]
#    %Porcelain.Process{pid: pid} = Porcelain.spawn_shell(cmd, opts)
#
#    conn = conn
#           |> put_resp_content_type("text/event-stream")
#           |> send_chunked(200)
#
#    {:ok, conn} = chunk(conn, "start\n")
#    wait_complete_deploy(conn, pid)
#  end
#
#  @spec wait_complete_deploy(Plug.Conn, pid) :: Plug.Conn
#  def wait_complete_deploy(conn, pid) do
#    receive do
#      {^pid, :data, :out, data} ->
#        {:ok, conn} = chunk(conn, data)
#        IO.puts "continue"
#        wait_complete_deploy(conn, pid)
#      {^pid, :result, %Porcelain.Result{status: _status}} ->
#        IO.puts "end"
#        conn
#    end
#  end

end