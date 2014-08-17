require "sinatra"
require "sinatra/reloader"

Dir.glob("lib/**/*.rb") do |source|
  require_relative source
  also_reload source
end

helpers do
  def partial(name, locals = {})
    erb name, layout: false, locals: locals
  end
end

get "/" do
  @checklists = Checklist.all
  erb :index
end

get "/checklists/:id/edit" do |id|
  @checklist = Checklist.find(id)
  erb :"checklist/edit"
end

get "/checklists/:id" do |id|
  @checklist = Checklist.find(id)
end

post "/checklists/:id/update" do |id|
  @checklist = Checklist.find(id)
  @checklist.update(params[:checklist])
  @checklist.save
  partial :"checklist/edit"
end

post "/checklists/:id/steps/create" do |id|
  @checklist = Checklist.find(id)
  @checklist.steps << params[:step]
  @checklist.save
  partial :"checklist/edit"
end

post "/checklists/:id/steps/:index/update" do |id, index|
  @checklist = Checklist.find(id)
  @checklist.steps[index.to_i] = params[:step]
  @checklist.save
  partial :"checklist/edit_step", index: index, step: @checklist.steps[index.to_i]
end

post "/checklists/:id/steps/:index/show" do |id, index|
  @checklist = Checklist.find(id)
  partial :"checklist/step", index: index, step: @checklist.steps[index.to_i]
end

post "/checklists/:id/steps/:index/edit" do |id, index|
  @checklist = Checklist.find(id)
  partial :"checklist/edit_step", index: index, step: @checklist.steps[index.to_i]
end

get "/checklists/:id/edit/steps/:index/edit" do |id, index|
  @checklist = Checklist.find(id)
  erb :"checklist/edit_step", :step => @checklist.steps[index]
end

