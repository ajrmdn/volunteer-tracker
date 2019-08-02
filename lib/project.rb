class Project
  attr_accessor :title
  attr_reader :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned = DB.exec("SELECT * FROM project ORDER BY name;")
    projects = []
    returned.each() do |project|
      name = project.fetch("title")
      id = project.fetch("id").to_i
      projects.push(Project.new({:title => name, :id => id}))
    end
    projects
  end

  def ==(thing_to_compare)
    self.title == thing_to_compare.title
  end

end
