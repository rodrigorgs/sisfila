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
    render layout: 'telao'
  end

  def inscrever
    authenticate_user!
    if !can?(:manage, :inscricao)
      return render status: 403, json: { mensagem: "Você não tem permissão." }  
    end

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
    
    grupo = aluno.primeiro_grupo_ativo_com_fila_ativa
    if !grupo
      return render status: 405, json: { mensagem: "Matrícula não habilitada para este horário. (Cód. de Erro: 27)" }
    end

    # Checa se aluno já está em alguma fila ativa
    vaga = aluno.proxima_vaga
    if vaga.posicao == vaga.fila.posicao
      return render status: 405, json: { mensagem: "Já está na sua vez!" }
    else
      return render status: 405, json: { mensagem: "Você já estava na fila (posição: #{vaga.codigo})." }
    end

    # Caso contrário, adiciona à fila
    vaga = Vaga.create(aluno: aluno, fila: grupo.fila)
    render json: { aluno: vaga.aluno, posicao: "#{vaga.codigo}" }
  end
end
