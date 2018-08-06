require "application_system_test_case"

class AlunosTest < ApplicationSystemTestCase
  setup do
    @aluno = alunos(:one)
  end

  test "visiting the index" do
    visit alunos_url
    assert_selector "h1", text: "Alunos"
  end

  test "creating a Aluno" do
    visit alunos_url
    click_on "New Aluno"

    fill_in "Matricula", with: @aluno.matricula
    fill_in "Nome", with: @aluno.nome
    click_on "Create Aluno"

    assert_text "Aluno was successfully created"
    click_on "Back"
  end

  test "updating a Aluno" do
    visit alunos_url
    click_on "Edit", match: :first

    fill_in "Matricula", with: @aluno.matricula
    fill_in "Nome", with: @aluno.nome
    click_on "Update Aluno"

    assert_text "Aluno was successfully updated"
    click_on "Back"
  end

  test "destroying a Aluno" do
    visit alunos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Aluno was successfully destroyed"
  end
end
