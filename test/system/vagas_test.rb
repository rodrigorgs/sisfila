require "application_system_test_case"

class VagasTest < ApplicationSystemTestCase
  setup do
    @vaga = vagas(:one)
  end

  test "visiting the index" do
    visit vagas_url
    assert_selector "h1", text: "Vagas"
  end

  test "creating a Vaga" do
    visit vagas_url
    click_on "New Vaga"

    fill_in "Aluno", with: @vaga.aluno_id
    fill_in "Data Chamada", with: @vaga.data_chamada
    fill_in "Posicao", with: @vaga.posicao
    click_on "Create Vaga"

    assert_text "Vaga was successfully created"
    click_on "Back"
  end

  test "updating a Vaga" do
    visit vagas_url
    click_on "Edit", match: :first

    fill_in "Aluno", with: @vaga.aluno_id
    fill_in "Data Chamada", with: @vaga.data_chamada
    fill_in "Posicao", with: @vaga.posicao
    click_on "Update Vaga"

    assert_text "Vaga was successfully updated"
    click_on "Back"
  end

  test "destroying a Vaga" do
    visit vagas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vaga was successfully destroyed"
  end
end
