# AdjustServer

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Besides the scaffold created by phoenix server my changes include
- Creation of migration script ./lib/adjust_server.ex (perform_migration)
- Added AdjustServer.perform_migration at the start of application
- Added Repos for Foo (table: source) and Bar (table: dest)
- Created Routes:
    get "/foo/tables/source", AdjustServer.MainController, :get_source_foo
    get "/bar/tables/dest", AdjustServer.MainController, :get_dest_bar
- Added Required methods for above endpoints in: 
    ./lib/adjust_server_web/controllers/adjust_server_controller.ex

## Improvements
- This is my first project with elixir. Following are current lackings
  - Unit Tests should be added
  - In AdjustServer.perform_migration:
    - Streams are read into an array (all in memory) and then inserted into Repo.Bar. That should be optimized.
      Like a python curson we should lazily load chunk by chunk and do insertion.
  - In AdjustServer.MainController, :get_source_foo Stream should also read in chunks and send       
  - In AdjustServer.MainController, :get_dest_bar Stream should also read in chunks and send         