require 'test_helper'

class RodadasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rodada = rodadas(:one)
  end

  test "should get index" do
    get rodadas_url
    assert_response :success
  end

  test "should get new" do
    get new_rodada_url
    assert_response :success
  end

  test "should create rodada" do
    assert_difference('Rodada.count') do
      post rodadas_url, params: { rodada: { descricao: @rodada.descricao, posicao_atual: @rodada.posicao_atual } }
    end

    assert_redirected_to rodada_url(Rodada.last)
  end

  test "should show rodada" do
    get rodada_url(@rodada)
    assert_response :success
  end

  test "should get edit" do
    get edit_rodada_url(@rodada)
    assert_response :success
  end

  test "should update rodada" do
    patch rodada_url(@rodada), params: { rodada: { descricao: @rodada.descricao, posicao_atual: @rodada.posicao_atual } }
    assert_redirected_to rodada_url(@rodada)
  end

  test "should destroy rodada" do
    assert_difference('Rodada.count', -1) do
      delete rodada_url(@rodada)
    end

    assert_redirected_to rodadas_url
  end
end
