#!/usr/bin/env ruby

def checa_se_matriculas_existem(matriculas)
  erro = false
  matriculas.each do |num|
    if not Aluno.find_by matricula: num
      STDERR.puts "Matrícula não encontrada: #{num}"
      erro = true
    end
  end
  if erro
    STDERR.puts "Há erros no arquivo. Por favor, conserte-os e rode o comando novamente."
    exit 1
  end
end

def importa_escalonamento(filename)
  Aluno.transaction do
    matriculas = IO.readlines(filename)[1..-1].map { |linha| linha.split(';')[0] }
    
    checa_se_matriculas_existem(matriculas)

    where = Aluno.where(matricula: matriculas)
    where.update_all(fezPreMatricula: true)
    puts "#{where.count} registros atualizados."
  end
end
  
  ####### MAIN #########
  
  if !ENV['FILE']
    STDERR.puts "Você precisa definir a variável de ambiente FILE apontando"
    STDERR.puts "para o arquivo .csv da pré-matrícula."
    STDERR.puts
    STDERR.puts "O arquivo deve ser separado por ;"
    STDERR.puts "A primeira coluna é o número de matrícula."
    STDERR.puts "A primeira linha é o cabeçalho."
    STDERR.puts
    exit 1
  end
  importa_escalonamento(File.expand_path(ENV['FILE']))
  