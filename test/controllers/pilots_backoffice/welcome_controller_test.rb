require 'test_helper'

class PilotsBackoffice::WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pilots_backoffice_welcome_index_url
    assert_response :success
  end

end
