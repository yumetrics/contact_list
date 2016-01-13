require 'csv'

# Represents a person in an address book.
class Contact

  attr_accessor :name, :email, :id

  def initialize(name, email, id)
    # TODO: Assign parameter values to instance variables.
    @name = name
    @email = email
    @id = id
    # @addition = name, email
  end



  # Provides functionality for managing a list of Contacts in a database.
  class << self

    # Returns an Array of Contacts loaded from the database.
    def all
    # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
    flag = false
      CSV.foreach('contacts.csv') do |row|
        flag = true
        print $.
        print row
        puts
      end
    end

    # Creates a new contact, adding it to the database, returning the new contact.
    def create(name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      CSV.foreach('contacts.csv') do |row|
      end
      id=$.
      new_contact = Contact.new(name, email, id)
      full_contact = new_contact.id, new_contact.name, new_contact.email
      CSV.open('contacts.csv', 'a+') do |csv|
      csv << full_contact
      end
      return new_contact
    end

    def get_name
      # name = gets.chomp
      # #puts "Hello !!!"
    end

    def get_email
      #email = gets.chomp
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
       # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
      flag = false
      CSV.foreach('contacts.csv') do |csv|
        if id.to_i == csv[0].to_i
          flag = true
          puts csv
          break
        end
      end
      if flag == false
        puts "Record not found"
      end
    end

    # Returns an array of contacts who match the given term.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      flag = false
      CSV.foreach('contacts.csv') do |csv|
        if term.downcase == csv[1].downcase
          flag = true
          puts "ID #{csv[0]}: #{csv[1]} (#{csv[2]})"
          break
        end
      end
      if flag == false
        puts "This contact isn't listed."
      end
    end

  end

end

