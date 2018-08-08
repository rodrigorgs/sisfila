class TelaController < ApplicationController
  def index
    @rodada = Rodada.first
  end

  def inscrever
    authenticate_user!

    @rodada = Rodada.first

    matricula = params[:matricula]
    aluno = Aluno.find_by matricula: matricula
    if !aluno
      render status: 405, json: { mensagem: "Número de matrícula não encontrado." }
    elsif !aluno.ativo
      render status: 405, json: { mensagem: "Matrícula não habilitada para este horário." }
    else
      posicao_aluno = @rodada.posicao_aluno(aluno)
      if posicao_aluno != nil
        render status: 405, json: { mensagem: "Você já estava na fila (posição: #{posicao_aluno})." }
      else
        vaga = Vaga.create(aluno: aluno, rodada: Rodada.first)    
        render json: { aluno: vaga.aluno, posicao: @rodada.posicao_aluno(aluno) }
      end
    end

  end
end
