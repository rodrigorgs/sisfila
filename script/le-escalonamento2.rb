#!/usr/bin/env ruby

# 1 216115540 - DANIEL SANTOS PEIXOTO - 2019-1 Sim 83 2016-1 2016-1 0 0 3 3 3
# 2 201515278 - PEDRO VIDAL SALES - 2019-1 Não 81 2015-1 2015-1 0 0 2 2 2

def importa_escalonamento(filename)
  lidos = 0
  Aluno.transaction do
    IO.readlines(filename).each do |line|
      if line =~ /^\d+ (?<matricula>\d+) - (?<nome>.*?) - (?<concluinte>.*?) (?<preMatricula>Sim|Não) (?<score>\d+)/
        lidos += 1
        a = Aluno.where(matricula: $~[:matricula]).first
        if !a
          print "[A] "
          a = Aluno.create!(matricula: $~[:matricula])
        else
          print "[U] "
        end
        a.update(ativo: true,
            nome: $~[:nome],
            formando: $~[:concluinte] != 'Não',
            fezPreMatricula: $~[:preMatricula] == 'Sim',
            score: $~[:score])
        p a
      else
        puts "Linha inválida: \"#{line}\""
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


