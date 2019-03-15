defmodule Tasks2Web.TimeblockController do
  use Tasks2Web, :controller

  alias Tasks2.Timeblocks
  alias Tasks2.Timeblocks.Timeblock

  action_fallback Tasks2Web.FallbackController

  def index(conn, _params) do
    timeblocks = Timeblocks.list_timeblocks()
    render(conn, "index.json", timeblocks: timeblocks)
  end

  def create(conn, %{"timeblock" => timeblock_params, "set_midblock" => val}) do
    task_id = Map.get(timeblock_params, "task_id")
    task = Tasks2.Tasks.get_task!(task_id)
    Tasks2.Tasks.update_task(task, %{:midblockHuh => true})
    create(conn, %{"timeblock" => timeblock_params})
  end

  def create(conn, %{"timeblock" => timeblock_params}) do
    {_, start_dt} = NaiveDateTime.from_iso8601(Map.get(timeblock_params, "start", nil))
    timeblock_params = Map.put(timeblock_params, "start", start_dt)
    {_, end_dt} = NaiveDateTime.from_iso8601(Map.get(timeblock_params, "end", nil))
    timeblock_params = Map.put(timeblock_params, "end", end_dt)
    res = Timeblocks.create_timeblock(timeblock_params)
    with {:ok, %Timeblock{} = timeblock} <- res do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.timeblock_path(conn, :show, timeblock))
      |> render("show.json", timeblock: timeblock)
    end
  end

  def show(conn, %{"id" => id}) do
    timeblock = Timeblocks.get_timeblock!(id)
    render(conn, "show.json", timeblock: timeblock)
  end

  def update(conn, %{"id" => id, "timeblock" => timeblock_params, "set_midblock" => val}) do
    timeblock = Timeblocks.get_timeblock!(id)
    task = Tasks2.Tasks.get_task!(timeblock.task_id)
    Tasks2.Tasks.update_task(task, %{:midblockHuh => false})
    update(conn, %{"id" => id, "timeblock" => timeblock_params})
  end

  def update(conn, %{"id" => id, "timeblock" => timeblock_params}) do
    timeblock = Timeblocks.get_timeblock!(id)

    with {:ok, %Timeblock{} = timeblock} <- Timeblocks.update_timeblock(timeblock, timeblock_params) do
      render(conn, "show.json", timeblock: timeblock)
    end
  end

  def delete(conn, %{"id" => id}) do
    timeblock = Timeblocks.get_timeblock!(id)

    with {:ok, %Timeblock{}} <- Timeblocks.delete_timeblock(timeblock) do
      send_resp(conn, :no_content, "")
    end
  end
end
