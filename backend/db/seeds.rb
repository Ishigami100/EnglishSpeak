# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

CSV.foreach('db/ejdict.csv',quote_char: "\x00", force_quotes: true) do |row|
    p  row[0]
    Word.create(:word => row[0], :mean => row[1])
end

User.create(username:"aaa",password:"password",session_times:0)
User.create(username:"yamada",password:"password",session_times:0)
User.create(username:"fukuda",password:"password",session_times:0)
User.create(username:"ezure",password:"password",session_times:0)
User.create(username:"sample ",password:"password",session_times:0)
User.create(username:"engineer",password:"password",session_times:0)
