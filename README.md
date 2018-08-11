# Instalação

    $ bundle install
    $ rake db:migrate

# Execução no macOS

Para rodar localmente, rode o Redis:

    $ redis-server /usr/local/etc/redis.conf &

Depois, inicie o servidor Rails

    $ rails s

# Execução no Heroku

Para inicializar:

    $ heroku login

Se quiser zerar o banco de dados:

    $ heroku pg:reset DATABASE_URL

Inicialização

    $ git push heroku master
    $ heroku run rake db:schema:load db:migrate

# Matrícula BCC 2018.1

## Preparação

Criar informações do sistema:

    rails console
    Rodada.create(descricao: "Matrícula BCC - acesse http://v.ht/filabcc")
    exit

Criar usuário em `/users/sign_up`

Importar os alunos, com os scores:

    FILE=~/Desktop/matricula-ccc/escalonamento-alunos.txt rails runner script/le-escalonamento.rb

Atenção: para rodar no Heroku, use o seguinte comando (o mesmo vale para os próximos):

    cat ~/Desktop/matricula-ccc/escalonamento-alunos.txt | heroku run FILE=/dev/stdin rails runner script/le-escalonamento.rb
    # Na verdade não está funcionando! O que funciona é executar o seguinte comando:
    #    heroku run FILE=/dev/stdin rails runner script/le-escalonamento.rb
    # e então colar o conteúdo do arquivo escalonamento-alunos.txt no console.

Importar a lista de formandos:

    FILE=~/Desktop/matricula-ccc/formandos.txt rails runner script/le-formandos.rb

No Heroku:

    cat ~/Desktop/matricula-ccc/formandos.txt | heroku run FILE=/dev/stdin rails runner script/le-formandos.rb

Importar a lista dos alunos que fizeram pré-matrícula:

    FILE=~/Desktop/matricula-ccc/prematricula.csv rails runner script/le-prematricula.rb

Criar grupos de alunos e filas: (no Heroku você deve executar `heroku run rails console`)

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
    exit

Criar filas e associar grupos iniciais:

    rails console
    fila1 = Fila.create(codigo: "CCA", nome: "Ciência da Computação, prioridade maior", posicao: 0)
    fila2 = Fila.create(codigo: "CCB", nome: "Ciência da Computação, prioridade menor", posicao: 0)
    g = Grupo.find_by nome: "Prováveis concluintes"
    g.update(fila: fila1)
    g = Grupo.find_by nome: "Alunos que realizaram pré-matrícula"
    g.update(fila: fila2)
    exit

Criar mesas (você pode modificá-las em `/mesas`):

    rails console
    Mesa.create(nome: "Sala 116, Mesa 1")
    Mesa.create(nome: "Sala 116, Mesa 2")
    exit

Se quiser RESETAR AS FILAS:

    rails console
    Vaga.delete_all
    Fila.update(posicao: 0)
    exit


## Execução

Acessar `/mesas` e escolher uma mesa

Acessar `/filas` e começar a chamar de uma fila