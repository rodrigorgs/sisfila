# Execução nomacOS

Para rodar localmente, rode o Redis:

    $ redis-server /usr/local/etc/redis.conf &

Depois, inicie o servidor Rails

    $ rails s

# Matrícula BCC 2018.1

Limpar alunos e vagas na fila:

    $ rails console
    > Aluno.delete_all
    > Vaga.delete_all

Importar os alunos, com os scores:

    FILE=~/Desktop/matricula-ccc/escalonamento-alunos.txt rails runner script/le-escalonamento.rb

Importar a lista de formandos:

    FILE=~/Desktop/matricula-ccc/formandos.txt rails runner script/le-formandos.rb

Importar a lista dos alunos que fizeram pré-matrícula:

    FILE=~/Desktop/matricula-ccc/prematricula.csv rails runner script/le-prematricula.rb

Criar grupos de alunos:

    rails console
    g = Grupo.create(nome: "Prováveis concluintes")
    g.update(alunos: Aluno.where(formando: true))
    g = Grupo.create(nome: "Alunos que realizaram pré-matrícula")
    g.update(alunos: Aluno.where(fezPreMatricula: true))
    g = Grupo.create(nome: "Alunos com CR >= 6,0")
    g.update(alunos: Aluno.where("score >= 60"))
    g = Grupo.create(nome: "Alunos com CR entre 4,8 e 5,9")
    g.update(alunos: Aluno.where("score >= 48 AND score <= 59"))
    g = Grupo.create(nome: "Alunos com CR entre 3,0 e 4,7")
    g.update(alunos: Aluno.where("score >= 30 AND score <= 47"))
    g = Grupo.create(nome: "Alunos com CR <= 2,9")
    g.update(alunos: Aluno.where("score <= 29"))