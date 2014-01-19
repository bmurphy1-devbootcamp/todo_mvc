# What classes do you need?
=begin
List class
ListItem class

Responsibility | Code world
Initialize an empty TODO list | list = List.new
Add a task to a TODO list | list.add(Task.new("walk the dog"))
ruby todo.rb add some task
Get all the tasks on a TODO list | tasks = list.tasks
ruby todo.rb list
Delete a particular task from a TODO list | list.delete <task_id>
ruby todo.rb delete 4
Complete a particular task on a TODO list | list.complete <task_id>
ruby todo.rb complete 4
Parse the command-line arguments and take the appropriate action |
Parse the todo.csv file and wrap each entry in easier-to-manipulate Ruby objects | ???

There are other responsibilities. What are they?
Check if particular task has been completed | list.item_completed? <task_id>
Update existing task item | list.update_item(<item_id, "new task text")



=end
# Remember, there are four high-level responsibilities, each of which have multiple sub-responsibilities:
# 1. Gathering user input and taking the appropriate action (controller)
# 2. Displaying information to the user (view)
# 3. Reading and writing from the todo.txt file (model)
# 4. Manipulating the in-memory objects that model a real-life TODO list (domain-specific model)

# Note that (4) is where the essence of your application lives.
# Pretty much every application in the universe has some version of responsibilities (1), (2), and (3).

require 'csv'
require 'debugger'
require_relative 'views'
require_relative 'models.rb'







# -------- CONTROLLER ------------------------------ #

class ToDoController

  def run
    my_list = List.load_from_file("todo.csv")
    # my_list.load_file("todo.csv")

    if ARGV.any?

      case ARGV[0]
      when "list"
        View.show_list(my_list.display_list)
      when "add"
        my_list.add_task(Task.from_argv(View.input_task))
        View.add_complete
        my_list.write_to_csv_file
      when "delete"
        task_num = View.input_task_num
        deleted_task = my_list.delete_task(task_num)
        my_list.write_to_csv_file
        View.delete_complete(deleted_task)
      when "complete"
        completed_task = my_list.mark_completed(View.input_task_num)
        my_list.write_to_csv_file
        View.completed_complete(completed_task)
      end
    end
  end

end


todo = ToDoController.new
todo.run
