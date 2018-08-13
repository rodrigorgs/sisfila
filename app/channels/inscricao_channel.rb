class InscricaoChannel < ApplicationCable::Channel
  def subscribed
    stream_from "inscricao_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def self.inscreve(vaga)
    ActionCable.server.broadcast "inscricao_channel", vaga.as_json(include: [:aluno, fila: {include: :colegiado}])
  end
end
