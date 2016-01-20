require_relative 'contact'
require 'csv'
require 'pg'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList
  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  def self.commands
    puts "Here is a list of available commands: "
    puts "new    - Create a new contact"
    puts "list   - List all contacts"
    puts "show   - Show a contact"
    puts "search - Search contacts"
  end

end

def main

  if ARGV.empty?
    ContactList.commands
  end

  if ARGV[0] == 'new'
    puts "Enter name:"
    name = STDIN.gets.chomp

    puts "Enter email:"
    email = STDIN.gets.chomp

    new_contact = Contact.create(name, email)
    puts "A new contact was created and listed as ##{new_contact.id}"
  end

  if ARGV[0] == 'list'
    puts "All contacts listed: "
    puts Contact.all
  end

  if ARGV[0] == "show"
    if ARGV[1].nil?
      puts "Usage: show (id)"
    else
      contact = Contact.find(ARGV[1])
      puts "ID ##{contact.id} is '#{contact.name}', the email listed is: '#{contact.email}'"
    end
  end

  if ARGV[0] == "search"
    if ARGV[1].nil?
      puts "Usage: search (id)"
    else
      matches = Contact.search(ARGV[1])
      puts matches
    end
  end

  if ARGV[0] == "update"
    if ARGV[1].nil?
      puts "Usage: update (id)"
    else
      contact = Contact.find(ARGV[1])
      puts "ID ##{contact.id} is '#{contact.name}', the email listed is: '#{contact.email}'"
      if contact
        puts "Enter the new name: "
        name = STDIN.gets.chomp
        puts "Enter the new email: "
        email = STDIN.gets.chomp

        contact.name = name
        contact.email = email
        contact.save
      end
    end
  end

  if ARGV[0] == "delete"
    puts Contact.all
    if ARGV[1].nil?
      puts "Usage: delete (id)"
    else
      contact = Contact.find(ARGV[1])
      puts "Are you sure you want to delete this contact? (Y / N)"
      answer = STDIN.gets.chomp
        if answer == "Y" || answer == "y"
          id = ARGV[1]
          contact.destroy(ARGV[1])
          puts "contact #{id} has been deleted."
        else
          exit
        end
    end
  end


end

main

# puts Contact.all
