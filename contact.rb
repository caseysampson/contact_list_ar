require_relative 'database'

class Contact
  @@conn = nil
 
  attr_accessor :firstname, :lastname, :email
  attr_reader :id

  def initialize(firstname, lastname, email, id=nil)
    @id = id
    @firstname = firstname
    @lastname = lastname
    @email = email
    Contact.set_connection
  end

  def self.set_connection
    @@conn = Database.connection
  end

  def save
    if @id
      @@conn.exec_params("UPDATE contacts SET (firstname, lastname, email) VALUES ($1, $2, $3) WHERE id=$4;", [@firstname, @lastname, @email, @id])                       
    else    
      @id = @@conn.exec_params("INSERT INTO contacts (firstname, lastname, email) VALUES ($1, $2, $3) RETURNING id;", [@firstname, @lastname, @email])[0][0].to_i   
    end
  end

  def self.all 
    rows = @@conn.exec("SELECT * FROM contacts;").values 
    objectify(rows)
    puts "#{rows}"
  end

  def self.destroy(email)
    @@conn.exec("DELETE FROM contacts WHERE email ILIKE '#{email}%'")
  end

  def self.find_all_by_lastname(lastname)
    rows = @@conn.exec("SELECT * FROM contacts WHERE lastname ILIKE '%#{lastname}%'").values
    objectify(rows)
    puts "#{rows}"
  end

  def self.find_all_by_firstname(firstname)
    rows = @@conn.exec("SELECT * FROM contacts WHERE firstname ILIKE '%#{firstname}%'").values
    objectify(rows)
    puts "#{rows}"
  end

  def self.find_all_by_email(email)
    rows = @@conn.exec("SELECT * FROM contacts WHERE email ILIKE '%#{email}%'").values
    objectify(rows)
    puts "#{rows}"
  end

 private

  def self.objectify(rows)
    result = []
    rows.each do |row|
      result << Contact.new(row[1], row[2], row[3], row[0])
    end
    result
  end 

end



