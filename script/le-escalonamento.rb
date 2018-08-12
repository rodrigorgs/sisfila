#!/usr/bin/env ruby

def importa_escalonamento(filename)
  lidos = 0
  Aluno.transaction do
    IO.readlines(filename).each do |line|
      if line =~ /^\d+(?:Sim|Não) (\d+) .* (\d+) - (.*?) ?- /
        lidos += 1
        a = Aluno.create!(score: $1, matricula: $2.strip, nome: $3.strip)
        p a
      end
    end
    puts "Lidos: #{lidos}."
  end
end

####### MAIN #########

if !ENV['FILE']
  STDERR.puts "Você precisa definir a variável de ambiente FILE apontando"
  STDERR.puts "para o arquivo .txt do escalonamento da matrícula web."
  STDERR.puts
  exit 1
end
importa_escalonamento(File.expand_path(ENV['FILE']))
