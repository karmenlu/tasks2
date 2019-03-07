# Tasks1 Tracker
A User is a name and may have many tasks. Each user's name is unique.

A Task is a title, description, completeHuh, timeSpent, 
and doer. Besides description and doer, every field of a task must 
be non-null. Some tasks do not have descriptions, and freshly created
tasks may not necessarily be assigned to a doer.

If a task is assigned to user B and user B is deleted, the task will
continue to exist but have no doer assignment. 

Tasks can be assigned to only one user at a time by anyone.

Doer may edit timeSpent by entering an integer. To ensure, fifteen minute
intervals, user input is rounded down to the nearest 15 by the controller,
and some client side form validation is used to be helpful to the user.
Only the doer may edit completedHuh. Non-doers cannot edit completedHuh or 
timeSpent without first reassigning themselves as the doer.
