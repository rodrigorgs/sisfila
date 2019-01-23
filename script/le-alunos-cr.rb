#!/usr/bin/env ruby

# Formato de cada linha do arquivo:
# matricula;nome;cr
#
# Exemplo:
# 200310593;Rodrigo Rocha;93
#
def importa_escalonamento(filename)
  lidos = 0
  Aluno.transaction do
    IO.readlines(filename).each do |line|
      matricula, nome, cr = line.split(';')
      matricula.strip!
      nome.strip!
      cr = cr.gsub(/[^\d]/, '') #[0..-2]
      lidos += 1
      a = Aluno.where(matricula: matricula).first
      if a
        print "[U] "
        a = a.update(score: cr, nome: nome, ativo: true)
      else
        print "[A] "
        a = Aluno.create!(score: cr, matricula: matricula, nome: nome)
      end
      puts "#{matricula} - #{nome} - #{cr}"
      # p a
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
