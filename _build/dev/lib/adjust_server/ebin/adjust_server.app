{application,adjust_server,
             [{applications,[kernel,stdlib,elixir,logger,runtime_tools,
                             gettext,phoenix_pubsub,cowboy,phoenix,postgrex,
                             phoenix_ecto]},
              {description,"adjust_server"},
              {modules,['Elixir.AdjustServer',
                        'Elixir.AdjustServer.Application',
                        'Elixir.AdjustServer.MainController',
                        'Elixir.AdjustServer.Repo','Elixir.AdjustServerWeb',
                        'Elixir.AdjustServerWeb.Endpoint',
                        'Elixir.AdjustServerWeb.ErrorHelpers',
                        'Elixir.AdjustServerWeb.ErrorView',
                        'Elixir.AdjustServerWeb.Gettext',
                        'Elixir.AdjustServerWeb.Router',
                        'Elixir.AdjustServerWeb.Router.Helpers',
                        'Elixir.Bar.Dest','Elixir.Bar.Repo','Elixir.Foo.Repo',
                        'Elixir.Foo.Source']},
              {registered,[]},
              {vsn,"0.0.1"},
              {mod,{'Elixir.AdjustServer.Application',[]}},
              {extra_applications,[logger,runtime_tools]}]}.