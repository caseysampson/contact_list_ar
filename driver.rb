require 'pg'
require 'active_record'
require_relative 'contact'

ActiveRecord::Base.establish_connection(
  adapter:  'postgresql',
  dbname: 'd3762coiv94tjk',
  port: 5432,
  user: 'kbdykosllpqlvu',
  host: 'ec2-54-204-47-70.compute-1.amazonaws.com',
  password: '57BgE1YEGY_4ZxPxJ1Y-QcvdoT'
)

class ContactList

  def self.run(input)
    puts "Here is a list of available commands: "
    puts "new - Create a new contact"
    puts "update - Update a contact"
    puts "find - Find a contact"
    puts "show - list all contacts"
    puts "delete - Delete a contact"
    case input
      when "NEW" then ContactList.create
      when "UPDATE" then ContactList.update
      when "FIND" then ContactList.find
      when "SHOW" then ContactList.show
      when "DELETE" then ContactList.delete
      else
        false
    end
  end

  def self.create
    puts "What is the first name of your contact?"
      firstname = $stdin.gets.chomp.to_s
    puts "What is the last name of your contact?"
      lastname = $stdin.gets.chomp.to_s
    puts "What is the email of your contact?"
      email = $stdin.gets.chomp.to_s
      Contact.create(
        firstname: firstname, 
        lastname: lastname, 
        email: email
      )
  end

  def self.update
    puts "Please provide the id of the contact that you would like to update: "
      id = $stdin.gets.chomp.to_i
      contact_id = Contact.find(id)
    puts "What would you like to change the first name to?"
      firstname = $stdin.gets.chomp.to_s
    puts "What would you like to change the last name to?"
      lastname = $stdin.gets.chomp.to_s
    puts "What would you like to change the email to?"
      email = $stdin.gets.chomp.to_s
    contact_id = Contact.update(
      id,
      firstname: firstname, 
      lastname: lastname, 
      email: email
      )
  end

  def self.find  
    puts "How would you like to search for your contact: firstname, lastname, email"
    user_find_answer = $stdin.gets.chomp.to_s
      if user_find_answer == 'firstname'
        puts "What is the firstname of your contact you are looking for?"
          firstname = $stdin.gets.chomp.to_s
          found = Contact.find_by(firstname: firstname)
      elsif user_find_answer == 'lastname'
        puts "What is the lastname of your contact you are looking for?"
          lastname = $stdin.gets.chomp.to_s
          found = Contact.find_by(lastname: lastname)
      elsif user_find_answer == 'email'
        puts "What is the email of your contact you are looking for?"
          email = $stdin.gets.chomp.to_s
          found = Contact.find_by(email: email)
      else
        puts "Please input id, firstname, lastname or email."
      end
      puts "Name: #{found.firstname} #{found.lastname}, Email: #{found.email}"
  end

  def self.show
    Contact.all.each do |contact|
      puts "Name: #{contact.firstname} #{contact.lastname}, Email: #{contact.email}"
    end
  end

  def self.delete
    puts "Please provide email address to delete contact: "
      email = $stdin.gets.chomp
      Contact.find_by(email: email).destroy
  end

end

input = ARGV.first if ARGV.first
ContactList.run(input.upcase)

# input = "help"
# input = ARGV.first if ARGV.first
# ContactList.run(input.upcase)









