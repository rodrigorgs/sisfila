class TelaController < ApplicationController
  def home
    @rodada = Rodada.first
  end

  def dados
    render json: Rodada.dados
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
      return render status: 405, json: { mensagem: "Número de matrícula não encontrado. (Cód. de Erro: 11)" }  
    end
    if !aluno.ativo
      return render status: 405, json: { mensagem: "Número de matrícula não encontrado. (Cód. de Erro: 99)" }
    end
    if !aluno.esta_em_algum_grupo
      return render status: 405, json: { mensagem: "Número de matrícula não encontrado. (Cód. de Erro: 42)" }
    end
    
    grupo = aluno.primeiro_grupo_ativo_com_fila
    if !grupo
      return render status: 405, json: { mensagem: "Matrícula não habilitada para este horário. (Cód. de Erro: 27)" }
    end
    
    # Checa se aluno já está na fila aguardando ser atendido
    # TODO: rever lógica
    # posicao_aluno = @rodada.posicao_aluno(aluno)
    # if posicao_aluno != nil
    #   if posicao_aluno == 0
    #     render status: 405, json: { mensagem: "Já está na sua vez!" }
    #   else
    #     render status: 405, json: { mensagem: "Você já estava na fila (posição: #{posicao_aluno})." }
    #   end
    # else
      vaga = Vaga.create(aluno: aluno, fila: grupo.fila)
      render json: { aluno: vaga.aluno, posicao: "#{vaga.fila.codigo}#{vaga.posicao}" }
    # end
  end

  # def posicao_aluno
  #   rodada = Rodada.first
  #   matricula = params[:matricula]
  #   @aluno = Aluno.find_by matricula: matricula
  #   if @aluno
  #     @posicao_aluno = rodada.posicao_aluno(@aluno)
  #   else
  #     @posicao_aluno = nil
  #   end
  # end
end
