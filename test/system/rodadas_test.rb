require "application_system_test_case"

class RodadasTest < ApplicationSystemTestCase
  setup do
    @rodada = rodadas(:one)
  end

  test "visiting the index" do
    visit rodadas_url
    assert_selector "h1", text: "Rodadas"
  end

  test "creating a Rodada" do
    visit rodadas_url
    click_on "New Rodada"

    fill_in "Descricao", with: @rodada.descricao
    fill_in "Posicao Atual", with: @rodada.posicao_atual
    click_on "Create Rodada"

    assert_text "Rodada was successfully created"
    click_on "Back"
  end

  test "updating a Rodada" do
    visit rodadas_url
    click_on "Edit", match: :first

    fill_in "Descricao", with: @rodada.descricao
    fill_in "Posicao Atual", with: @rodada.posicao_atual
    click_on "Update Rodada"

    assert_text "Rodada was successfully updated"
    click_on "Back"
  end

  test "destroying a Rodada" do
    visit rodadas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rodada was successfully destroyed"
  end
end
