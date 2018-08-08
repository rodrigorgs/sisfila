class TelaController < ApplicationController
  def index
    @rodada = Rodada.first
  end

  def inscrever
    authenticate_user!

    @rodada = Rodada.first

    matricula = params[:matricula]
    # aluno_params = params.require(:aluno).permit(:matricula)

    aluno = Aluno.find_by! matricula: matricula, ativo: true
    vaga = Vaga.create(aluno: aluno, rodada: Rodada.first)
    
    render json: { aluno: vaga.aluno, posicao: @rodada.posicao_aluno(aluno) }
  end
end
