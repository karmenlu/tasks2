defmodule Tasks1Web.TaskController do
  use Tasks1Web, :controller

  alias Tasks1.Tasks
  alias Tasks1.Tasks.Task

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    task_params2 = Map.put(task_params, "doer_id", _parse_doer(Map.get(task_params, "doer_id")))
    case Tasks.create_task(task_params2) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def _parse_doer(doer_id_str) do
    if doer_id_str == "0" do
      nil
    else
      {real_id, _} = Integer.parse(doer_id_str)
      real_id
    end
  end

  def closestFifteen(num) do
    remain = rem(num, 15)
    num - remain
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    task_params = Map.put(task_params, "doer_id", _parse_doer(Map.get(task_params, "doer_id")))
    if Map.get(task_params, "timeSpent", nil) != nil do
      task_params = Map.put(task_params, "timeSpent", closestFifteen(elem(Integer.parse(Map.get(task_params, "timeSpent")), 0)))
    else
    end
    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
