json.extract! fila, :id, :codigo, :nome, :prioridade, :ativo, :created_at, :updated_at
json.url fila_url(fila, format: :json)
