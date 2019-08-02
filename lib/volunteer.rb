class Volunteer
  attr_accessor :name, :age, :project_id
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @age = attributes.fetch(:age)
    @id = attributes.fetch(:id)
    @project_id = 0
  end

  def self.all
    returned = DB.exec("SELECT * FROM volunteers ORDER BY name;")
    volunteers = []
    returned.each() do |volunteer|
      name = volunteer.fetch("name")
      age = volunteer.fetch("age")
      id = volunteer.fetch("id").to_i
      project_id = volunteer.fetch("project_id").to_i
      volunteers.push(Volunteer.new({:name => name, :age => age, :id => id, :project_id => project_id}))
    end
    volunteers
  end
end
