class List
  def initialize(tasks)
    @tasks = tasks
  end

  def self.load_from_file(filename)
    self.new(populate_list(filename))
  end

  def self.populate_list(filename)
    list = []
    CSV.foreach(filename, headers: true, header_converters: :symbol) {|row| list << Task.new(row)}
    # debugger
    list
  end

  def write_to_csv_file
    CSV.open("todo.csv", "wb", write_headers: true, headers: ["content","status"]) do |csv|
      @tasks.each do |task|
        csv << task.to_a
      end
    end
  end

  def display_list
    array = []
    @tasks.each_with_index do |item, index|
      array << "#{index + 1}. " + item.display
    end
    array.join("\n")
  end

  def add_task(task)
    @tasks << task
  end

  def delete_task(num)
    @tasks.delete_at(num-1)
  end

  def mark_completed(num)
    @tasks[num-1].mark_completed
    @tasks[num-1]
  end
end


class Task
  attr_reader :content, :status
  def initialize(args)
    @content = args[:content]
    @status = args[:status] || "incomplete"
  end

  def display
    # debugger
    content + " - " + status
  end

  def mark_completed
    @status = "complete"
  end

  def to_a
    [content, status]
  end

  def self.from_argv(argv_array)
    # debugger
    self.new(content: argv_array.join(" "), status: "incomplete")
  end

end
