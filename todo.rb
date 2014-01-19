# What classes do you need?
=begin
List class
ListItem class

Responsibility | Code world
Initialize an empty TODO list | list = List.new
Add a task to a TODO list | list.add(Task.new("walk the dog"))
Get all the tasks on a TODO list | tasks = list.tasks
Delete a particular task from a TODO list | list.delete <task_id>
Complete a particular task on a TODO list | list.complete <task_id>
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

class List
  def initialize
    @list_items = []
  end

  def load_file(filename)
    csv = CSV.new(File.open(filename))
    csv.to_a.each do |line|
      @list_items << ListItem.new(line[0], line[1])
    end
  end

  def write_to_csv_file
    CSV.open("todo.csv", "w") do |csv|
      @list_items.each do |item|
        csv << item.to_a
      end
    end
    return nil
  end

  def list
    array = []
    @list_items.each_with_index do |item, index|
      array << "#{index + 1}. " + item.display
    end
    array.join("\n")
  end

  def add(todo_text)
    @list_items << ListItem.new(todo_text)
    puts "Appended #{todo_text} to your TODO list."
    write_to_csv_file
  end

  def delete(num)
    puts "Deleted #{@list_items.delete_at(num.to_i - 1).display} from your TODO list."
    write_to_csv_file
  end

  def complete(num)
    num = num.to_i
    # debugger
    @list_items[num-1].completed
    write_to_csv_file
    "#{@list_items[num]} has been marked complete."
  end
end


class ListItem
  def initialize(text, completed=false)
    @content = text
    if completed == "false"
      @completed = false
    elsif completed == "true"
      @completed = true
    end
  end

  def display
    @content + " - " + status
  end

  def completed?
    @completed
  end

  def completed
    @completed = true
  end

  def to_a
    [@content, @completed.to_s]
  end

  def status
    return "Complete" if self.completed?
    return "Incomplete" unless self.completed?
  end


end


# -------- TESTS ------------------------------ #

my_list = List.new
my_list.load_file("todo.csv")

if ARGV.any?
  # list.load_file(ARGV[1]) if ARGV.first == "load"
  if ARGV[0] == "list"
    puts my_list.list
  elsif ARGV[0] == "add"
    puts my_list.add(ARGV[1..-1].join(" "))
  elsif ARGV[0] == "delete"
    puts my_list.delete(ARGV[1])
    puts my_list.list
  elsif ARGV[0] == "complete"
    puts my_list.complete(ARGV[1])

    puts my_list.list
  end
end