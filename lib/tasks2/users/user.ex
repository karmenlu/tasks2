defmodule Tasks2.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :name, :string, unique: true
    has_many :tasksAssigned, Tasks2.Tasks.Task, foreign_key: :doer_id
    belongs_to :manager, Tasks2.Users.User
    has_many :underlings, Tasks2.Users.User, foreign_key: :manager_id
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :manager_id])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
