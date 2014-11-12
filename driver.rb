require_relative 'contact'

class ContactList

  def self.run(input)
    Contact.set_connection
    case input
      when "NEW" then ContactList.create
      when "FIND" then ContactList.find
      when "DELETE" then ContactList.delete
      when "ALL" then ContactList.all_contacts
    else
      UserHelp.new
    end
  end

  def self.create
    puts "What is the first name of your contact?"
      firstname = $stdin.gets.chomp
    puts "What is the last name of your contact?"
      lastname = $stdin.gets.chomp
    puts "What is the email of your contact?"
      email = $stdin.gets.chomp
      Contact.new(firstname, lastname, email).save
  end

  def self.find  
    puts "How would you like to search for your contact: firstname, lastname, email"
    user_find_answer = $stdin.gets.chomp
      if user_find_answer == 'firstname'
        puts "What is the firstname of your contact you are looking for?"
          firstname = $stdin.gets.chomp
          Contact.find_all_by_firstname(firstname)
      elsif user_find_answer == 'lastname'
        puts "What is the lastname of your contact you are looking for?"
          lastname = $stdin.gets.chomp
          Contact.find_all_by_lastname(lastname)
      elsif user_find_answer == 'email'
        puts "What is the email of your contact you are looking for?"
          email = $stdin.gets.chomp
          Contact.find_all_by_email(email)
      else
        puts "Please input id, firstname, lastname or email."
      end
  end

  def self.delete
    puts "Please provide email address to delete contact: "
      email = $stdin.gets.chomp
      Contact.destroy(email)
  end

  def self.all_contacts
    Contact.all
  end

end

class UserHelp
  puts "Here is a list of available commands:"
  puts "new - Create a new contact"
  puts "list - List all contacts"
  puts "find - Find a contact"
end

input = "help"
input = ARGV.first if ARGV.first
ContactList.run(input.upcase)








