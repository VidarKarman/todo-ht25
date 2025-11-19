require 'sqlite3'

db = SQLite3::Database.new("db/todos.db")


def seed!(db)
  puts "Using db file: db/todos.db"
  puts "🧹 Dropping old tables..."
  drop_tables(db)
  puts "🧱 Creating tables..."
  create_tables(db)
  puts "🍎 Populating tables..."
  populate_tables(db)
  puts "✅ Done seeding the database!"
end

def drop_tables(db)
  db.execute('DROP TABLE IF EXISTS todos')
end

def create_tables(db)
  db.execute('CREATE TABLE todos (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL, 
              description TEXT,
              state INTEGER)') #0 innebär att den är på todo 1 innebär färdig
end

def populate_tables(db)
  db.execute('INSERT INTO todos (name, description, state) VALUES ("Köp mjölk", "3 liter mellanmjölk, eko", 0)')
  db.execute('INSERT INTO todos (name, description, state) VALUES ("Köp julgran", "En rödgran", 0)')
  db.execute('INSERT INTO todos (name, description, state) VALUES ("Pynta gran", "Glöm inte lamporna i granen och tomten", 0)')
end

seed!(db)