defmodule Tasks2.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completeHuh, :boolean, default: false
    field :description, :string
    field :timeSpent, :integer, default: 0
    field :title, :string
    field :midblockHuh, :boolean, default: false
    belongs_to :doer, Tasks2.Users.User
    has_many :timeblocks, Tasks2.Timeblocks.Timeblock
    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completeHuh, :timeSpent, :midblockHuh,  :doer_id])
    |> validate_required([:title, :description, :completeHuh, :timeSpent, :midblockHuh])
  end
end
