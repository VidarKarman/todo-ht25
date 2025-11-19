require 'sinatra'
require 'sqlite3'
require 'slim'
require 'sinatra/reloader'



# Funktion för att prata med databasen
# Exempel på användning: db.execute('SELECT * FROM fruits')
def db
  return @db if @db

  @db = SQLite3::Database.new("db/todos.db")
  @db.results_as_hash = true

  return @db
end

# Routen /
get '/' do
  
  @todo = db.execute('SELECT * FROM todos where state = 0')
  @completed = db.execute('SELECT * FROM todos where state = 1')
  slim(:index)
end
# Routen new, lägger till i databasen från ett formulär
post '/new' do
  new_task = params[:new_task]
  new_description = params[:new_description]
  db.execute('INSERT INTO todos (name, description, state) VALUES (?, ?, ?)', [new_task, new_description, 0])
  redirect('/')
end
post '/delete/:id' do
  id = params[:id]
  db.execute('DELETE FROM todos where id=?', [id])
  redirect('/')
end