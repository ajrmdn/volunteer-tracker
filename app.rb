require('sinatra')
require('sinatra/reloader')
require('./lib/volunteer')
require('./lib/project')
require('pry')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})

get ('/') do
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:index)
end

get ('/new_volunteer') do
  erb(:new_volunteer)
end

get ('/new_project') do
  erb(:new_project)
end

get ('/volunteers') do
  redirect to('/')
end

get ('/volunteers/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  erb(:volunteer)
end

get ('/projects') do
  redirect to('/')
end

get ('/project/:id') do
  @project = Project.find(params[:id].to_i())
  @volunteers = Volunteer.all
  erb(:project)
end

post ('/project/:id') do
  @project = Project.find(params[:id].to_i())
  @volunteers = Volunteer.all
  @volunteer = Volunteer.new({:name => params[:name], :id => nil, :project_id => params[:id]})
  @volunteer.save
  erb(:project)
end

post ('/volunteers') do
  name = params[:name]
  project_id = params[:project_id]
  volunteer = Volunteer.new({:name => name, :project_id => project_id, :id => nil})
  volunteer.save
  redirect to('/')
end

post ('/project') do
  title = params[:title]
  project = Project.new({:title => title, :id => nil})
  project.save
  redirect to ('/')
end

get ('/project/:id/edit') do
  @project = Project.find(params[:id].to_i())
  erb(:project_edit)
end

delete ('/volunteers/:id') do
  volunteer = Volunteer.find(params[:id].to_i)
  volunteer.delete
  redirect to('/')
end

delete ('/project/:id') do
  @project = Project.find(params[:id].to_i)
  @project.delete
  redirect to('/')
end

patch ('/project/:id/edit') do
  @project = Project.find(params[:id].to_i())
  @project.update(:title => params[:title])
  redirect to ("/project/#{@project.id}")
end

patch ('/volunteer/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  @volunteer.update(:name => params[:name])
  redirect to ("/volunteers/#{@volunteer.id}")
end
