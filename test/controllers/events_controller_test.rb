require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { event_from_datetime: @event.event_from_datetime, event_title: @event.event_title, event_to_datetime: @event.event_to_datetime, event_type_id: @event.event_type_id, is_weekly: @event.is_weekly, notes: @event.notes }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { event_from_datetime: @event.event_from_datetime, event_title: @event.event_title, event_to_datetime: @event.event_to_datetime, event_type_id: @event.event_type_id, is_weekly: @event.is_weekly, notes: @event.notes }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
