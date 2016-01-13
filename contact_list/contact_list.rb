require_relative 'contact'
require 'csv'

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
    Contact.all
  end

  if ARGV[0] == "show"
    if ARGV[1].nil? == false
      Contact.find(ARGV[1])
    else
      puts "Usage: show (id)"
    end
  end

  if ARGV[0] == "search"
    Contact.search(ARGV[1])
  end

end

main
