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

  def self.clear
    DB.exec("DELETE FROM volunteers *;")
  end

  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    if volunteer
      name = volunteer.fetch("name")
      age = volunteer.fetch("age")
      id = volunteer.fetch("id").to_i
      project_id = volunteer.fetch("project_id").to_i
      Volunteer.new({:name => name, :age => age, :id => id, :project_id => project_id})
    else
      nil
    end
  end

  def ==(thing_to_compare)
    self.name == thing_to_compare.name
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, age, project_id) VALUES ('#{@name}', '#{@age}',#{@project_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def update(attributes)
    (attributes.key? :name) ? @name = attributes.fetch(:name) : @name = @name
    (attributes.key? :age) ? @age = attributes.fetch(:age) : @age = @age
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE volunteers SET age = '#{@age}' WHERE id = #{@id};")
  end
end
