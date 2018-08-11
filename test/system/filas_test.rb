require "application_system_test_case"

class FilasTest < ApplicationSystemTestCase
  setup do
    @fila = filas(:one)
  end

  test "visiting the index" do
    visit filas_url
    assert_selector "h1", text: "Filas"
  end

  test "creating a Fila" do
    visit filas_url
    click_on "New Fila"

    fill_in "Ativo", with: @fila.ativo
    fill_in "Codigo", with: @fila.codigo
    fill_in "Prioridade", with: @fila.prioridade
    click_on "Create Fila"

    assert_text "Fila was successfully created"
    click_on "Back"
  end

  test "updating a Fila" do
    visit filas_url
    click_on "Edit", match: :first

    fill_in "Ativo", with: @fila.ativo
    fill_in "Codigo", with: @fila.codigo
    fill_in "Prioridade", with: @fila.prioridade
    click_on "Update Fila"

    assert_text "Fila was successfully updated"
    click_on "Back"
  end

  test "destroying a Fila" do
    visit filas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Fila was successfully destroyed"
  end
end
