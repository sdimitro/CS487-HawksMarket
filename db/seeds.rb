# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account
u = User.new(
    email: "hawksmarket@iit.edu",
    password: "1234",
    admin: true
)
u.skip_confirmation!
u.save!
