require 'test_helper'

class TeacherClassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher_class = teacher_classes(:one)
  end

  test "should get index" do
    get teacher_classes_url
    assert_response :success
  end

  test "should get new" do
    get new_teacher_class_url
    assert_response :success
  end

  test "should create teacher_class" do
    assert_difference('TeacherClasse.count') do
      post teacher_classes_url, params: { teacher_class: { salle_de_class_id: @teacher_class.salle_de_class_id, user_id: @teacher_class.user_id } }
    end

    assert_redirected_to teacher_class_url(TeacherClasse.last)
  end

  test "should show teacher_class" do
    get teacher_class_url(@teacher_class)
    assert_response :success
  end

  test "should get edit" do
    get edit_teacher_class_url(@teacher_class)
    assert_response :success
  end

  test "should update teacher_class" do
    patch teacher_class_url(@teacher_class), params: { teacher_class: { salle_de_class_id: @teacher_class.salle_de_class_id, user_id: @teacher_class.user_id } }
    assert_redirected_to teacher_class_url(@teacher_class)
  end

  test "should destroy teacher_class" do
    assert_difference('TeacherClasse.count', -1) do
      delete teacher_class_url(@teacher_class)
    end

    assert_redirected_to teacher_classes_url
  end
end
