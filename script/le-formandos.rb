#!/usr/bin/env ruby

def importa_formandos(filename)
  Aluno.transaction do
    IO.readlines(filename).each do |line|
      line.strip!
      continue if line.empty?
      aluno = Aluno.find_by(matricula: line)
      if aluno
        puts aluno.nome
      else
        STDERR.puts "Aluno não encontrado: #{line}"
      end
      aluno.update(formando: true)
    end
  end
end

####### MAIN #########

if !ENV['FILE']
  STDERR.puts "Você precisa definir a variável de ambiente FILE apontando"
  STDERR.puts "para o arquivo .txt da lista de formandos."
  STDERR.puts "Esse arquivo deve conter uma matrícula por linha"
  STDERR.puts
  exit 1
end
importa_formandos(File.expand_path(ENV['FILE']))
