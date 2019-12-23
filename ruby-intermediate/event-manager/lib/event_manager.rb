require "csv"
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  
  begin
    legislators = civic_info.representative_info_by_address(
                            address: zip,
                            levels: 'country',
                            roles: ['legislatorUpperBody', 'legislatorLowerBody']).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letters(id,form_letter)
  Dir.mkdir("output") unless Dir.exists? "output"
  
  filename = "output/thanks_#{id}.html"
  
  File.open(filename, 'w') do |f|
    f.puts form_letter
  end
end

def clean_phone_numbder(phone)
  if(phone.size < 10)
    return "bad"
  end
  clean_num = []
  phone.split("").each do |d|
    d = "" if d == "-" || d == "." || d == " " || d == "(" || d == ")"
    clean_num << d
  end
  
  clean_num = clean_num.join
  
  if(clean_num.size == 11 and clean_num[0] == "1")
    clean_num = clean_num[1..clean_num.size - 1]
  elsif (clean_num.size == 11 and clean_num[0] != 1)
    return "bad"
  end
  
  return clean_num
end

def get_date_hour(regdate)
  a = DateTime.strptime(regdate, '%m/%d/%Y %H:%M')
  b = a.hour
  c = a.wday
  return b, c
end

puts "EventManager Initialized!"

contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter
times = []
days = []

contents.each do |row|
  id = row[0]
  
  name = row[:first_name]
  
  reg = get_date_hour(row[:regdate])
  
  times << reg[0]
  days << reg[1]
  
  phone_number = clean_phone_numbder(row[:homephone])
  
  zipcode = clean_zipcode(row[:zipcode])
  
  legislators = legislators_by_zipcode(zipcode)
  
  form_letter = erb_template.result(binding)
  
  save_thank_you_letters(id, form_letter)

  # puts "#{name} #{zipcode} #{legislators}"
end

freq = times.inject(Hash.new(0)) { |a, b| a[b] += 1; a }

puts times.max_by { |v| freq[v] }.to_s + " hr is good for targeting."

freq2 = days.inject(Hash.new(0)) { |a, b| a[b] += 1; a }

puts days.max_by { |v| freq2[v] }.to_s + "st day of week is good"