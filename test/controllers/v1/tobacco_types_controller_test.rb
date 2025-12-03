require "test_helper"

class V1::TobaccoTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get v1_tobacco_types_index_url
    assert_response :success
  end
end
