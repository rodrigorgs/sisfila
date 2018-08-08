class TelaController < ApplicationController
  def index
    @rodada = Rodada.first
  end

  def inscrever
    authenticate_user!

    matricula = params[:matricula]
    # aluno_params = params.require(:aluno).permit(:matricula)

    aluno = Aluno.find_by! matricula: matricula, ativo: true
    if (aluno)
      Vaga.create(aluno: aluno, rodada: Rodada.first)
    end
  end
end
