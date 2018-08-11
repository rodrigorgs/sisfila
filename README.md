# Execução nomacOS

Para rodar localmente, rode o Redis:

    $ redis-server /usr/local/etc/redis.conf &

Depois, inicie o servidor Rails

    $ rails s

# Matrícula BCC 2018.1

Para limpar alunos e vagas na fila:

    $ rails console
    > Aluno.delete_all
    > Vaga.delete_all

Para importar os alunos, com os scores:

    FILE=~/Desktop/matricula-ccc/escalonamento-alunos.txt rails r script/le-escalonamento.rb

Para importar a lista de formandos:

    FILE=~/Desktop/matricula-ccc/formandos.txt rails r script/le-formandos.rb