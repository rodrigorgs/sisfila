class TelaController < ApplicationController
  def index
    @rodada = Rodada.first
  end

  def inscrever
    authenticate_user!

    matricula = params[:matricula]
    # aluno_params = params.require(:aluno).permit(:matricula)

    aluno = Aluno.find_by! matricula: matricula, ativo: true
    vaga = nil
    if (aluno)
      vaga = Vaga.create(aluno: aluno, rodada: Rodada.first)
    end

    render json: vaga.aluno
  end
end
