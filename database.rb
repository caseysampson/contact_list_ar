require 'pg'  # gem install pg  Postgres gem
require_relative 'contact'

class Database

puts "establishing connection ..."
# violet
  def self.connection
    conn = PG.connect(
      dbname: 'd3762coiv94tjk',
      port: 5432,
      user: 'kbdykosllpqlvu',
      host: 'ec2-54-204-47-70.compute-1.amazonaws.com',
      password: '57BgE1YEGY_4ZxPxJ1Y-QcvdoT'
    )
    return conn
  end

end 

