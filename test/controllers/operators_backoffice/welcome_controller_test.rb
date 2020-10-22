require 'test_helper'

class OperatorsBackoffice::WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get operators_backoffice_welcome_index_url
    assert_response :success
  end

end
