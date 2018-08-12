require "application_system_test_case"

class ColegiadosTest < ApplicationSystemTestCase
  setup do
    @colegiado = colegiados(:one)
  end

  test "visiting the index" do
    visit colegiados_url
    assert_selector "h1", text: "Colegiados"
  end

  test "creating a Colegiado" do
    visit colegiados_url
    click_on "New Colegiado"

    fill_in "Codigo", with: @colegiado.codigo
    fill_in "Nome", with: @colegiado.nome
    click_on "Create Colegiado"

    assert_text "Colegiado was successfully created"
    click_on "Back"
  end

  test "updating a Colegiado" do
    visit colegiados_url
    click_on "Edit", match: :first

    fill_in "Codigo", with: @colegiado.codigo
    fill_in "Nome", with: @colegiado.nome
    click_on "Update Colegiado"

    assert_text "Colegiado was successfully updated"
    click_on "Back"
  end

  test "destroying a Colegiado" do
    visit colegiados_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Colegiado was successfully destroyed"
  end
end
