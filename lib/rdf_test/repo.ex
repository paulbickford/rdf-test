defmodule RdfTest.Repo do
  use Ecto.Repo,
    otp_app: :rdf_test,
    adapter: Ecto.Adapters.Postgres
end
