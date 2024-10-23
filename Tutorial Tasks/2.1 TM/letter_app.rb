require"./input_functions"
def Label ()
  title= read_string('Please enter your title: (Mr, Mrs, Ms, Miss, Dr)')
  first_name = read_string('Please enter your first name:')
  last_name= read_string('Please enter your last name:')
  house= read_string('Please enter the house or unit number:')
  street_name= read_string('Please enter the street name:')
  suburb= read_string('Please enter the suburb:')
  postal_code= read_integer_in_range('Please enter a postcode (0000 - 9999)',0000,9999)
  return title, first_name, last_name, house, street_name, suburb, postal_code
end

def Message ()
  subject_line = read_string('Please enter your message subject line:')
  message = read_string('Please enter your message content:')
  return subject_line, message
end

def print_label_and_message(title, first_name, last_name, house, street_name, suburb, postal_code, subject_line, message_content)
  puts("#{title} #{first_name} #{last_name}\n#{house} #{street_name}\n#{suburb} #{postal_code}\nRE: #{subject_line}\n\n#{message_content}")
end
def main()
title, first_name, last_name, house, street_name, suburb, postal_code = Label()
  subject_line, message_content = Message()
  print_label_and_message(title, first_name, last_name, house, street_name, suburb, postal_code, subject_line, message_content)
end

main()
