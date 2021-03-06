require('./lib/volunteer')

class Project
  attr_accessor :title
  attr_reader :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned = DB.exec("SELECT * FROM projects;")
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

  def self.clear
    DB.exec("DELETE FROM projects *;")
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    if project
      title = project.fetch("title")
      id = project.fetch("id").to_i
      Project.new({:title => title, :id => id})
    else
      nil
    end
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def volunteers_by_project
    returned = DB.exec("SELECT * FROM volunteers WHERE id = (#{@project_id})")
    volunteers = []
    returned.each() do |volunteer|
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id")
      id = volunteer.fetch("id").to_i
      project_id = volunteer.fetch("project_id").to_i
      if project_id == 0
        volunteers.push(Volunteer.new({:name => name, :age => age, :project_id => project_id, :id => id}))
      end
    end
    volunteers
  end

  def pick(volunteer_id)
    DB.exec("UPDATE projects SET volunteer_id = (#{volunteer_id}) WHERE id = (#{self.id})")
    DB.exec("UPDATE volunteers SET project_id = (#{self.id}) WHERE id = (#{volunteer_id})")
  end

  # def volunteers_picked
  #   returned = DB.exec("SELECT * FROM volunteerss where project_id = #{self.id}")
  #   volunteers = []
  #   returned.each() do |volunteer|
  #     name = volunteer.fetch("name")
  #     id = volunteer.fetch("id").to_i
  #     project_id = volunteer.fetch("project_id").to_i
  #     volunteers.push(Volunteer.new({:name => name, :age => age, :project_id => project_id, :id => id}))
  #   end
  #   volunteers
  # end

  def update(attributes)
    (attributes.key? :title) ? @title = attributes.fetch(:title) : @title = @title
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

  def volunteers
    Volunteer.find_by_project(self.id)
  end
end
