require 'test_helper'

class ColegiadosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @colegiado = colegiados(:one)
  end

  test "should get index" do
    get colegiados_url
    assert_response :success
  end

  test "should get new" do
    get new_colegiado_url
    assert_response :success
  end

  test "should create colegiado" do
    assert_difference('Colegiado.count') do
      post colegiados_url, params: { colegiado: { codigo: @colegiado.codigo, nome: @colegiado.nome } }
    end

    assert_redirected_to colegiado_url(Colegiado.last)
  end

  test "should show colegiado" do
    get colegiado_url(@colegiado)
    assert_response :success
  end

  test "should get edit" do
    get edit_colegiado_url(@colegiado)
    assert_response :success
  end

  test "should update colegiado" do
    patch colegiado_url(@colegiado), params: { colegiado: { codigo: @colegiado.codigo, nome: @colegiado.nome } }
    assert_redirected_to colegiado_url(@colegiado)
  end

  test "should destroy colegiado" do
    assert_difference('Colegiado.count', -1) do
      delete colegiado_url(@colegiado)
    end

    assert_redirected_to colegiados_url
  end
end
