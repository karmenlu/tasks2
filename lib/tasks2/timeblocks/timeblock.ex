defmodule Tasks2.Timeblocks.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset


  schema "timeblocks" do
    field :end, :integer
    field :start, :integer
    belongs_to :task, Tasks2.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(timeblock, attrs) do
    timeblock
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
  end
end
