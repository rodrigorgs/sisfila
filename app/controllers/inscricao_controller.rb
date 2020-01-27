class InscricaoController < ApplicationController
  def index
    @rodada = Rodada.first
  end

  def inscrever
    rodada = Rodada.first

    begin
      if !rodada.inscricao_guest
        raise "A inscrição não está habilitada"
      end
      if !verify_recaptcha
        raise "Erro no captcha"
      end

      matricula = params[:matricula]
      aluno = Aluno.find_by matricula: matricula
      if !aluno
        raise "Número de matrícula não encontrado. (Cód. de Erro: 11)"
      end

      json = aluno.inscreve
      # puts "JSON***"
      # p json
      @message = "Olá, #{json[:aluno].nome}, agora você está na posição #{json[:posicao]} da fila."
      return render "index"
    rescue StandardError => e
      @rodada = rodada
      @message = e.message
      # puts e.backtrace.inspect
      return render "index"
    end
  end
end
