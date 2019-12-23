template_letter = File.read "form_letter.html"

template_letter = template_letter.gsub('FIRST_NAME', "myname")
template_letter = template_letter.gsub!('LEGISLATORS', "mylegis")

p template_letter