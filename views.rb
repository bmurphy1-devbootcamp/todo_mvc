class View

  def self.show_list(list_as_string)
    puts list_as_string
  end

  def self.input_task
    ARGV[1..-1]
  end

  def self.add_complete
    puts "Appended #{ARGV[1..-1].join(" ")} to your TODO list."
  end

  def self.input_task_num
    ARGV[1].to_i
  end

  def self.delete_complete(task)
    puts "Deleted \'#{task.content}\' from your TODO list."
  end

  def self.completed_complete(task)
    puts "\'#{task.content}\' has been marked complete."
  end

end

# Questions
# Does the view makes changes to user input?
#   or is it at the controller or model?
# Separte classes for taking input when deleting?
# Issues having identically named methods for
#   one object contained in another?
# redo controller in statements into case