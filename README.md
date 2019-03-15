# Tasks2 Tracker
A User is a name and may have many tasks. Each user's name is unique.

A Task is a title, description, completeHuh, timeSpent, 
, doer, and a list of timeblocks. Besides description, doer, and timeblocks;
every field of a task must be non-null. Some tasks do not have 
descriptions, and freshly created tasks may not necessarily be assigned to 
a doer or have timeblocks.

Users may only edit their own profiles. The home page is a user's profile,
assuming that they have logged in.

Managers may have many underlings. All underlings' tasks and their statuses
are listed in a task report. 

Additionally, each user may view tasks assigned to them. They are available
under a table in the user profile.

If a user is not a manager, no task report will be available.

To delete or add timeblocks, users should visit the edit page of a task.
On the edit page, they will be able to track timeblocks
using etiher the (1) create time block option where start and end times are 
provided at once or (2) the start and end time stopwatch.

Tasks can be assigned to only one user at a time by anyone.

Only the doer of the task may create timeblocks or delete them.

Only the doer may edit completedHuh. Non-doers cannot edit completedHuh or 
timeSpent without first reassigning themselves as the doer.
