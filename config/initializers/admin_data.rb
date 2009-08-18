### authorization check to see if the data should be shown to the user
ADMIN_DATA_VIEW_AUTHORIZATION = Proc.new { |controller| true }

### authorization check to see if the user should be allowed to update the data
ADMIN_DATA_UPDATE_AUTHORIZATION = Proc.new { |controller| false }
