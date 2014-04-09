FactoryGirl.define do 
  factory :user do |u|
    u.email "admin@idyllic-software.com"
    u.first_name "Admin"
    u.last_name "Idyllic"
    u.roles "admin"
    u.password "admin123"
    u.password_confirmation "admin123"
  end

  factory :project do |p|
  	p.name "Optyn"
  	p.doc_name "setup.docx"
  	p.timeframe "3"
  	p.user_id "1"
  end
end