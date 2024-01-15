require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get registrations_register_url
    assert_response :success
  end
end
