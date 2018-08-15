#!/usr/bin/env ruby

def importa_escalonamento(filename)
  lidos = 0
  Aluno.transaction do
    IO.readlines(filename).each do |line|
      matricula, nome, cr = line.split(';')
      cr = cr.gsub(/[^\d]/, '')[0..-2]
      lidos += 1
      a = Aluno.create!(score: cr, matricula: matricula.strip, nome: nome.strip)
      p a
    end
    puts "Lidos: #{lidos}."
  end
end

####### MAIN #########

if !ENV['FILE']
  STDERR.puts "Você precisa definir a variável de ambiente FILE apontando"
  STDERR.puts "para o arquivo .csv do escalonamento da matrícula web."
  STDERR.puts "Esse arquivo deve ter três colunas, separados por"
  STDERR.puts "ponto-e-vírgula, sendo essas colunas, respectivamente,"
  STDERR.puts "número de matrícula, nome do aluno, e CR."
  STDERR.puts "O arquivo .csv não deve ter cabeçalho."
  STDERR.puts
  exit 1
end
importa_escalonamento(File.expand_path(ENV['FILE']))
