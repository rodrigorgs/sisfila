class TelaController < ApplicationController
  def home
    @rodada = Rodada.first
  end

  def dados
    mesas = Mesa.eager_load(:aluno)
        .where(ativo: true)
        .where.not(aluno: nil)
        .order(updated_at: :desc)
        .as_json(include: [:aluno])
    
    rodada = Rodada.first
        .as_json(include: [:aluno_atual])
    
    proximos = Rodada.first.proximos(5).as_json(include: [aluno: {only: :nome}])

    render json: { mesas: mesas, rodada: rodada, proximos: proximos }
  end

  # Telao
  def index
    @mesas = Mesa.where(ativo: true).where.not(aluno: nil).order(updated_at: :desc)
    @rodada = Rodada.first
    render layout: 'telao'
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
        if posicao_aluno == 0
          render status: 405, json: { mensagem: "Já está na sua vez!" }
        else
          render status: 405, json: { mensagem: "Você já estava na fila (posição: #{posicao_aluno})." }
        end
      else
        vaga = Vaga.create(aluno: aluno, rodada: Rodada.first)    
        render json: { aluno: vaga.aluno, posicao: @rodada.posicao_aluno(aluno) }
      end
    end

  end

  def posicao_aluno
    rodada = Rodada.first
    matricula = params[:matricula]
    @aluno = Aluno.find_by matricula: matricula
    if @aluno
      @posicao_aluno = rodada.posicao_aluno(@aluno)
    else
      @posicao_aluno = nil
    end
  end
end
