# Project: Event Manager - Ruby

## Learning Goals:
- manipulate file input and output
- read content from a CSV (Comma Separated Value) file
- transform it into a standardized format
- utilize the data to contact a remote service
- populate a template with user data
- manipulate strings
- access [Google’s Civic Information API](https://developers.google.com/civic-information/) through the [Google API Client Gem](https://github.com/google/google-api-ruby-client)
- use ERB (Embedded Ruby) for templating

## What We’re Doing in This Tutorial:
Imagine that a friend of yours runs a non-profit org around political activism. A number of people have registered for an upcoming event. She has asked for your help in engaging these future attendees.

### Initial Setup:
1. So this: Placing in `lib` dir is entirely optional. It's just the Ruby standard convention. Ruby source files are written in lowercase, seperated by `_`
  ```bash
  mkdir event_manager
  cd event_manager
  mkdir lib
  touch lib/event_manager.rb
  ```

2. In this project, we're going to use [Small Sample](https://github.com/TheOdinProject/curriculum/tree/master/ruby_programming/intermediate_ruby/event_attendees.csv) and [Large Sample](https://github.com/TheOdinProject/curriculum/tree/master/ruby_programming/intermediate_ruby/event_attendees_full.csv) as data.
    - Download small sample first in root dir of project: `curl -o event_attendees.csv https://raw.githubusercontent.com/TheOdinProject/ruby_course/master/ruby_programming/intermediate_ruby/event_attendees.csv`

3. **Iteration 0: Loading a File**
    - A comma-separated values (CSV) file stores tabular data (numbers and text) in plain-text form. The CSV format is readable by a large number of applications (e.g. Excel, Numbers, Calc).
    - Read the File Contents:
      ```rb
      # event_manager.rb
      puts "EventManager initialized."
      
      contents = File.exist?("event_attendees.csv") ? File.read("event_attendees.csv") : "File Not Found!"
      puts contents
      ```
    - Read the File Line By Line: Reading and displaying the entire contents of the file showed us how to quickly access the data. Our goal is to display the first names of all the attendees.
      ```rb
      lines = File.readlines "event_attendees.csv"
      lines.each do |line|
        puts line
      end
      ```
    - Get the first name of all attendees:
      ```rb
      lines.each do |line|
        name = line.split(",")[2]
        puts name
      end
      ```
    - Skipping the Header Row: The header row was a great help to us in understanding the contents of the CSV file. However, the row itself does not represent an actual attendee.
      ```rb
      # Sol 1: But header row may change, like if new cols are added later
      lines.each do |line|
        next if line == " ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode\n"
        name = line.split(",")[2]
        puts name
      end
      
      # sol 2
      lines.each_with_index do |line, index|
        next if index == 0
        name = line.split(",")[2]
        puts name
      end
      ```
    - Look for a Solution before Building a Solution:
        - Problems may arise if we are given a new CSV file that is generated or manipulated by another source.
        - CSV parser that we have started to create does not take into account a number of other features supported by the CSV file format like
          - CSV files often contain comments which are lines that start with a pound (#) character
          - A column is unable to support a value which contains a comma (,) character
        - Our goal is to get in contact with our event attendees. It is not to define a CSV parser.
        - An important rule to abide by while building software is: Look for a Solution before Building a Solution
        - Ruby actually provides a CSV parser that we will use instead throughout the remainder of this exercise.

4. **Iteration 1: Parsing with CSV**
    - It is likely the case that if you want to solve a problem, someone has already done it in some capacity. They may have even been kind enough to share their solution or the tools that they created. This is the kind of goodwill that pervades the Open Source community and Ruby ecosystem.
    - In this iteration we are going to convert our current CSV parser to use Ruby’s CSV. We will then use this new parser to access our attendees’ zip codes.
    - Switching over to use the CSV Library:
      ```rb
      require "csv"
      puts "EventManager initialized."
      
      # pass headers: true to ignore first header line
      contents = CSV.open "event_attendees.csv", headers: true
      contents.each do |row|
        name = row[2]
        puts name
      end
      ```
    - Accessing Columns by their Names: CSV files with headers have an additional option which allows you to access the column values by their headers. The CSV library provides an additional option which allows us to convert the header names to symbols. Converting the headers to symbols will make our column names more uniform and easier to remember. The header `first_Name` will be converted to `:first_name`
      ```rb
      contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
      contents.each do |row|
        name = row[:first_name]
        zipcode = row[:zipcode]
        puts "#{name} #{zipcode}"
      end
      ```

5. **Iteration 2: Cleaning up our Zip Codes:**
    - The zip codes in our small sample show us:
        - Most zip codes are correctly expressed as a five-digit number
        - Some zip codes are represented with less than a five-digit number - this is because zipcodes are saved as integer in DB.
        - Some zip codes are missing - add 00000 to them. Maybe people forgot to enter this data.
    - Logic:
      ```rb
      # if the zip code is exactly five digits, assume that it is ok
      # if the zip code is more than 5 digits, truncate it to the first 5 digits
      # if the zip code is less than 5 digits, add zeros to the front until it becomes five digits
      ```
    - Our code:
      ```rb
      zipstring_array = zipcode.to_s.split("")
      if zipstring_array.count > 5
        zipcode = zipstring_array.first(5).join
      elsif zipstring_array.count < 5
        while zipstring_array.size != 5
          zipstring_array.unshift("0")
        end
        zipcode = zipstring_array.join
      end
  
      puts "#{name} #{zipcode}"
      ```
    - Above works, but main sol:
      ```rb
      if zipcode.length < 5
        zipcode = zipcode.rjust 5, "0"
      elsif zipcode.length > 5
        zipcode = zipcode[0..4]
      end
    
      puts "#{name} #{zipcode}"
      ```
    - But with main sol, we see error: "undefined method ‘length’ for nil:NilClass (NoMethodError)"
    - Handling Missing Zip Codes: `CSV` returns a `nil` value when no value has been specified in the column. So we can add a `if zipcode.nil? zipcode = "00000"` line.
    - Moving Clean Zip Codes to a Method:
      ```rb
      def clean_zipcode(zipcode)
        if zipcode.nil?
          "00000"
        elsif zipcode.length < 5
          zipcode.rjust(5,"0")
        elsif zipcode.length > 5
          zipcode[0..4]
        else
          zipcode
        end
      end
      
      contents.each do |row|
        name = row[:first_name]
        zipcode = clean_zipcode(row[:zipcode])
        
        puts "#{name} #{zipcode}"
      end
      ```
    - Refactoring Clean Zip Codes: "Coercion over Questions". A good rule when developing in Ruby is to favor coercing values into similar values so that they will behave the same.
      ```rb
      # for nil. nil.to_s => ""
      # "123456".rjust 5, "0" => "123456"
      # "12345"[0..4] => "12345"
      
      def clean_zipcode(zipcode)
        zipcode.to_s.rjust(5,"0")[0..4]
      end
      ```

6. **Iteration 3: Using Google’s Civic Information**
    - The Civic Information API allows registered individuals (registration is free) to obtain some information about the representatives for each level of government for an address. Make a req. to https://www.googleapis.com/civicinfo/v2/representatives?address=80203&levels=country&roles=legislatorUpperBody&roles=legislatorLowerBody&key=AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw - understand the link.
    - Installing the Google API Client: `gem install google-api-client`
    - Reading through the documentation on how to set up and use the google-api-client gem we find that we need to perform the following steps:
        - Set the API Key
        - Send the query with the given criteria
        - Parse the response for the names of your legislators.
    - We can do:
        ```rb
        require 'google/apis/civicinfo_v2'
        
        civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
        civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
        
        response = civic_info.representative_info_by_address(address: 80202, levels: 'country', roles: ['legislatorUpperBody', 'legislatorLowerBody'])
        
        # => Response here
        ```
    - See the code , implement a method that will get the data from server and returns the result.

7. **Iteration 4: Form Letters**
    - We have our attendees and their respective representatives. We can now generate a personalized call to action. For each attendee we want to include a customized letter that thanks them for attending the conference and provides a list of their representatives. Some HTML page to say thank you.
    - We can do something like in `.rb` file `form_letter = %{ <html> multiple lines HTML </html> }`. This format is a choice when defining a string that spans multiple lines. Thus this is inefficient. So create a `form_letter.html` in root.
    - Replacing with `gsub` and `gsub!`: For each of our attendees we want to replace the `FIRST_NAME` and `LEGISLATORS` with their respective values.
    - Again the above is very problematic if someone name is "LEGISLATORS" or somewhere this word exists. Also we cannot represent multiple items through this. Like we cannot create this in `table` tag and render stuff.
    - Ruby’s ERB:
        - Ruby defines a template language named ERB. Using ERB, actual Ruby code can be added to any plain text document for the purposes of generating document information details and/or flow control. Ex:
          ```rb
          require 'erb'
          number = 42
          
          question = "Hello, I am <%= number %>"
          template = ERB.new question
          
          results = template.result(binding)
          puts results
          ```
        - Above creates a new ERB template with question string.
        - What is `binding`? The method binding returns a special object. This object is an instance of `Binding`. An instance of binding knows all about the current state of variables and methods within the given scope. In this case, binding knows about the variable `meaning_of_life`.
    - Defining an ERB Template: Save the new template as `form_letter.erb` and table logic:
        ```rb
        <table>
          <% if legislators.kind_of?(Array) %>
            <th>Name</th><th>Website</th>
            <% legislators.each do |legislator| %>
              <tr>
                <td><%= "#{legislator.name}" %></td>
                <td><%= "#{legislator.urls.join}" %></td>
              </tr>
            <% end %>
          <% else %>
            <th></th>
            <td><%= "#{legislators}" %></td>
          <% end %>
        </table>
        ```
    - No w update our app to use `erb`. We'll take directly array from Civic API i.e. `.officials` now which will retun array.
    - Outputting form letters to a file:
        - Outputting each form letter to the screen was useful for ensuring our output looked correct. It is time to save each form letter to a file.
        - Each file should be uniquely named. Fortunately, each of our attendees has a unique id—the first column, or row number.
        - Assign an ID for the attendee, Create an output folder, Save each form letter to a file based on the id of the attendee
        - Then Move Form Letter Generation to a Method `save_thank_you_letters(id,form_letter)`:
          ```rb
          def save_thank_you_letters(id,form_letter)
            Dir.mkdir("output") unless Dir.exists? "output"
            
            filename = "output/thanks_#{id}.html"
            
            File.open(filename, 'w') do |f|
              f.puts form_letter
            end
          end
          ```

8. Iteration: Clean Phone Numbers
    - Similar to the zip codes the phone numbers suffer from multiple formats and inconsistencies. If we wanted to allow individuals to sign up for mobile alerts with the phone numbers we would need to make sure all of the numbers are valid and well-formed.
    - Constrains:
        - If the phone number is less than 10 digits assume that it is a bad number
        - If the phone number is 10 digits assume that it is good
        - If the phone number is 11 digits and the first number is 1, trim the 1 and use the first 10 digits
        - If the phone number is 11 digits and the first number is not 1, then it is a bad number
        - If the phone number is more than 11 digits assume that it is a bad number

9. Iteration: Time Targeting

10. Iteration: Day of the Week Targeting