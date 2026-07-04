Admin.find_or_create_by!(username: "admin") do |admin|
  admin.name = "Administrator"
  admin.password = "admin123"
  admin.password_confirmation = "admin123"
end

puts "Admin created successfully!"