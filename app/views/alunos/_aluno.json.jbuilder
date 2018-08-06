json.extract! aluno, :id, :matricula, :nome, :created_at, :updated_at
json.url aluno_url(aluno, format: :json)
