class TelaController < ApplicationController
  def index
    @rodada = Rodada.first
  end

  def inscrever
    matricula = params[:matricula]
    # aluno_params = params.require(:aluno).permit(:matricula)

    aluno = Aluno.find_by! matricula: matricula
    if (aluno)
      Vaga.create(aluno: aluno, rodada: Rodada.first)
    end
  end
end
