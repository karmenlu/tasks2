defmodule Tasks2.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :manager_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:users, [:name])
    create index(:users, [:manager_id])
  end
end
