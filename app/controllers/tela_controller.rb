class TelaController < ApplicationController
  def reset
      DatabaseCleaner.allow_production = true
      DatabaseCleaner.allow_remote_database_url = true
      DatabaseCleaner.clean_with :truncation
      Rodada.create(descricao: "Matrícula teste")
      User.create(email: "admin@example.com", superadmin_role: true, password: "admin2222", password_confirmation: "admin2222")
      User.create(email: "tela@example.com", user_role: true, password: "tela2222", password_confirmation: "tela2222")
      render html: 'Ok'
  end

  def cria_cenario
      Mesa.create(nome: "Sala 116, Mesa 1")
      Mesa.create(nome: "Sala 116, Mesa 2")

      col = Colegiado.create(nome: "Bacharelado em Ciência da Computação", codigo: "112140")
      fila1 = Fila.create(codigo: "CCA", nome: "Ciência da Computação, prioridade maior", posicao: 0, colegiado: col)
      fila2 = Fila.create(codigo: "CCB", nome: "Ciência da Computação, prioridade menor", posicao: 0, colegiado: col)
      Aluno.create(nome: "Fulano", matricula: "1", colegiado: col, formando: false)
      Aluno.create(nome: "Fulana", matricula: "2", colegiado: col, formando: false)
      Aluno.create(nome: "Sicrano", matricula: "3", colegiado: col, formando: true)
      Aluno.create(nome: "Sicrana", matricula: "4", colegiado: col, formando: true)
      g = Grupo.create(nome: "Prováveis concluintes", alunos: Aluno.where(colegiado: col).where(formando: true), fila: fila1)
      g = Grupo.create(nome: "Não-concluintes", alunos: Aluno.where(colegiado: col).where(formando: false), fila: fila2)
      
      col = Colegiado.create(nome: "Sistemas de Informação", codigo: "195140")
      Aluno.create(nome: "Beltrano", matricula: "5", colegiado: col, formando: false)
      Aluno.create(nome: "Beltrana", matricula: "6", colegiado: col, formando: true)
      fila1 = Fila.create(codigo: "SI", nome: "Sistemas de Informação", posicao: 0, colegiado: col)
      g = Grupo.create(nome: "Alunos de SI", alunos: Aluno.where(colegiado: col), fila: fila1)

      col = Colegiado.create(nome: "Licenciatura em Computação", codigo: "196120")

      render html: 'Ok'
  end

  def home
    @rodada = Rodada.first
  end

  def dados
    render json: Rodada.dados
  end

  def posicao_aluno
    @aluno = Aluno.find_by matricula: params[:matricula]
    if @aluno
      @vaga = @aluno.proxima_vaga
      @posicao_aluno = @aluno.posicao_total
      if !@posicao_aluno || @posicao_aluno == -1
        @erro = "Você não está na fila ou sua vez já passou."
      end
      if @vaga
        @mesa = @vaga.mesa
      end
    else
      @erro = "Matrícula não encontrada: #{params[:matricula]}"
    end
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
