class TelaController < ApplicationController
  def home
    @rodada = Rodada.first
  end

  def dados
    render json: Rodada.dados
  end

  def posicao_aluno
    @aluno = Aluno.find_by matricula: params[:matricula]
    @vaga = @aluno.proxima_vaga
    @posicao_aluno = @aluno.posicao_total
  end

  # Telao
  def index
    @mesas = Mesa.where(ativo: true).where.not(aluno: nil).order(updated_at: :desc)
    @rodada = Rodada.first
    @filas = Fila.where(ativo: true).all
    render layout: 'telao'
  end

  def inscrever
    @rodada = Rodada.first

    authenticate_user!
    if !can?(:manage, :inscricao)
      return render status: 403, json: { mensagem: "Você não tem permissão." }  
    end

    matricula = params[:matricula]
    aluno = Aluno.find_by matricula: matricula
    if !aluno
      return render status: 405, json: { mensagem: "Número de matrícula não encontrado. (Cód. de Erro: 11)" }  
    end

    begin
      json = aluno.inscreve
      render json: json
    rescue StandardError => e
      return render status: 405, json: { mensagem: e.message }
    end
  end
end
