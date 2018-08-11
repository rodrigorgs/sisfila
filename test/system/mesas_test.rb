require "application_system_test_case"

class MesasTest < ApplicationSystemTestCase
  setup do
    @mesa = mesas(:one)
  end

  test "visiting the index" do
    visit mesas_url
    assert_selector "h1", text: "Mesas"
  end

  test "creating a Mesa" do
    visit mesas_url
    click_on "New Mesa"

    fill_in "Aluno", with: @mesa.aluno_id
    fill_in "Ativo", with: @mesa.ativo
    fill_in "Nome", with: @mesa.nome
    click_on "Create Mesa"

    assert_text "Mesa was successfully created"
    click_on "Back"
  end

  test "updating a Mesa" do
    visit mesas_url
    click_on "Edit", match: :first

    fill_in "Aluno", with: @mesa.aluno_id
    fill_in "Ativo", with: @mesa.ativo
    fill_in "Nome", with: @mesa.nome
    click_on "Update Mesa"

    assert_text "Mesa was successfully updated"
    click_on "Back"
  end

  test "destroying a Mesa" do
    visit mesas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Mesa was successfully destroyed"
  end
end
