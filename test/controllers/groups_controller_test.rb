require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  setup do
    @group = groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group" do
    assert_difference('Group.count') do
      post :create, group: { groupGender_id: @group.groupGender_id, groupLanguage_id: @group.groupLanguage_id, groupLimit: @group.groupLimit, groupTitle: @group.groupTitle, isReserve: @group.isReserve, lessonTime_id: @group.lessonTime_id, notes: @group.notes, season_id: @group.season_id, subject_id: @group.subject_id, teacher_id: @group.teacher_id }
    end

    assert_redirected_to group_path(assigns(:group))
  end

  test "should show group" do
    get :show, id: @group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group
    assert_response :success
  end

  test "should update group" do
    patch :update, id: @group, group: { groupGender_id: @group.groupGender_id, groupLanguage_id: @group.groupLanguage_id, groupLimit: @group.groupLimit, groupTitle: @group.groupTitle, isReserve: @group.isReserve, lessonTime_id: @group.lessonTime_id, notes: @group.notes, season_id: @group.season_id, subject_id: @group.subject_id, teacher_id: @group.teacher_id }
    assert_redirected_to group_path(assigns(:group))
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, id: @group
    end

    assert_redirected_to groups_path
  end
end
