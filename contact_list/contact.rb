require 'csv'
require 'pg'

# Represents a person in an address book.
class Contact

  attr_accessor :name, :email, :id

  def initialize(name, email, id = nil)
    @name = name
    @email = email
    @id = id
  end

  def to_s
    "ID ##{@id} Name: #{@name}, Email: #{@email}"
  end

  def persisted?
    !id.nil?
  end

  def save
    if persisted?
      res = self.class.conn.exec_params("UPDATE contacts SET name = $1, email = $2 WHERE id = $3::int", [name, email, id])
    else
      res = self.class.conn.exec_params("INSERT INTO contacts (name, email) VALUES ($1, $2)", [name, email])
      self.id = res[0]['id']
    end
  end

  def destroy(id)
    self.class.conn.exec_params("DELETE FROM contacts WHERE id = $1::int", [id]) if persisted?
  end

  # def update
  #   # self.name = name
  #   # self.email = email
  #   # save

  #   # contact.name = new_name
  #   # contact.email = new_email
  #   # contact.save
  #   res = Contact.conn.exec_params("UPDATE contacts SET name = $1, email = $2 WHERE id = $1::int", [new_name])
  # end
    
  # Provides functionality for managing a list of Contacts in a database.
  class << self

    def conn
      conn = PG.connect(
        host: 'localhost',
        dbname: 'contactlist',
        user: 'development',
        password: 'development'
        )
    end

    def res_to_contact(res)
      res.map do |hash|
        Contact.new(hash['name'], hash['email'], hash['id'])
      end
    end

    # Returns an Array of Contacts loaded from the database.
    def all
      res = conn.exec_params("SELECT * FROM contacts")
      res_to_contact res
    end

    # Creates a new contact, adding it to the database, returning the new contact.
    def create(name, email)
      new_contact = Contact.new
      new_contact.name = name
      new_contact.email = email
      new_contact.save
      new_contact
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      res = conn.exec_params("SELECT * FROM contacts WHERE id = $1::int", [id])
      res_to_contact(res).first
    end


    # def update(id)
    #   contact = self.find(id)
    #   contact.name = new_name
    #   contact.email = new_email
    #   contact.save
    #   res = conn.exec_params("UPDATE contacts SET name = $1, email = $2 WHERE id = $1::int", [new_name])
    # end

    # Returns an array of contacts who match the given term.
    def search(term)
      lc_term = term.downcase
      uc_term = term.upcase
      res = conn.exec_params("SELECT * FROM contacts WHERE name LIKE $1 OR name LIKE $2 OR email LIKE $1 OR email LIKE $2", ["%#{lc_term}%", "%#{uc_term}%"])
      res_to_contact res
    end

  end
end

