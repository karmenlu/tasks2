# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tasks2.Repo.insert!(%Tasks2.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
alias Tasks2.Repo
alias Tasks2.Users.User

Repo.insert!(%User{name: "Alice"})
Repo.insert!(%User{name: "Bob"})
Repo.insert!(%User{name: "Carol"})
alias Tasks2.Tasks.Task
