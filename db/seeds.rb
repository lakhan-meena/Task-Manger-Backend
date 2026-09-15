user = User.find_or_create_by!(email: "lakhanmeena170@gmail.com") do |u|
  u.name = "Lakhan Meena"
  u.password = "admin@123"
end

tasks = [
  {
    title: "Learn React Basics",
    description: "Learn components, props and state",
    status: :pending,
    due_date: Date.today + 2
  },
  {
    title: "Build Login Page",
    description: "Create login page using React",
    status: :in_progress,
    due_date: Date.today + 3
  },
  {
    title: "Create Task API",
    description: "Build Rails API for tasks",
    status: :completed,
    due_date: Date.today
  },
  {
    title: "Build Task List",
    description: "Display tasks from Rails API",
    status: :pending,
    due_date: Date.today + 5
  },
  {
    title: "Implement Task Edit",
    description: "Add edit functionality for tasks",
    status: :pending,
    due_date: Date.today + 7
  }
]

tasks.each do |task_attributes|
  user.tasks.create!(task_attributes)
end