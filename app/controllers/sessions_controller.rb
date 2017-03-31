class SessionsController < Clearance::SessionsController
  before_action :allow_anyone
end
