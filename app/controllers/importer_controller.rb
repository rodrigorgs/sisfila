class ImporterController < ApplicationController
  # load_and_authorize_resource
  before_action :authorize_user

  def authorize_user
    authorize! :access, :rails_admin
  end

  def index
    @grupos = Grupo.all
  end

  def import
    contents = params[:contents]
    grupo_id = params[:grupo]
    grupo = nil
    grupo = Grupo.find(grupo_id) unless grupo_id.empty?
    
    input = StringIO.new(contents)
    output = StringIO.new
    importa_escalonamento(input, output, grupo)

    @output = output.string
    @grupos = Grupo.all
    render :index
  end

  def importa_escalonamento(filename, output, grupo)
    if grupo
      size = grupo.alunos.size
      output.puts "Removendo #{size} alunos do grupo '#{grupo.nome}' antes de adicionar os novos alunos."
      output.puts
      grupo.alunos.delete_all
    end
    lidos = 0
    output.puts "Importando alunos:"
    Aluno.transaction do
      filename.readlines.each do |line|
        line.gsub!(/"/, "")
        line.strip!
        next if line.empty?
        if line =~ /^(?<matricula>\d+)(\t|,|;| *)(?<nome>.*?)$/
          matricula = $~[:matricula].strip
          nome = $~[:nome].strip
          lidos += 1
          a = Aluno.where(matricula: matricula).first
          if !a
            output.print "(novo aluno criado) "
            a = Aluno.create!(matricula: matricula)
          else
            output.print ""
          end
          a.update(ativo: true, nome: nome)
          output.puts "'#{a.matricula}' - '#{a.nome}'"

          grupo.alunos.append(a) if grupo
        else
          output.puts "Linha inválida: \"#{line}\""
        end
      end
      output.puts "Lidos: #{lidos}."
    end
  end
end
