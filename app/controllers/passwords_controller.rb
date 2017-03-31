class PasswordsController < Clearance::PasswordsController
  before_action :allow_anyone
end
