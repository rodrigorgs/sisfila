# Configuração

Usando Ruby 2.7.2.

    bundle install
    rake db:migrate
    rake db:seed
    bundle exec rails s -p 3000 -b '0.0.0.0'

# reCAPTCHA

Para usar o reCAPTCHA (na página de inscrição online, disponível em `/inscricao`), você deve criar uma [API key do reCAPTCHA](https://www.google.com/recaptcha/admin) e configurar as variáveis de ambiente `RECAPTCHA_PUBLIC_KEY` e `RECAPTCHA_PRIVATE_KEY`. No ambiente de desenvolvimento, essas variáveis podem ser especificadas no arquivo `.env`.

Mais informações: [Quick Tip: Add ReCAPTCHA to Your Rails Application](https://www.sitepoint.com/quick-tip-add-recaptcha-to-your-rails-application/)

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

------------------------

# Documentação obsoleta

# Matrícula BCC 2018.2

## Preparação

Importar os alunos com os scores, formandos e alunos que fizeram pré-matrícula:

    # Localmente
    FILE=~/Desktop/matricula-ccc/escalonamento-alunos.txt rails runner script/le-escalonamento.rb
    FILE=~/Desktop/matricula-ccc/formandos.txt rails runner script/le-formandos.rb
    FILE=~/Desktop/matricula-ccc/prematricula.csv rails runner script/le-prematricula.rb

    # no Heroku
    cat ~/Desktop/matricula-ccc/escalonamento-alunos.txt | heroku run --no-tty FILE=/dev/stdin rails runner script/le-escalonamento.rb
    cat ~/Desktop/matricula-ccc/formandos.txt | heroku run --no-tty FILE=/dev/stdin rails runner script/le-formandos.rb
    cat ~/Desktop/matricula-ccc/prematricula.csv | heroku run --no-tty FILE=/dev/stdin rails runner script/le-prematricula.rb

Criar alguns registros iniciais (no Heroku você deve executar `heroku run rails console`):

    rails console

    ### Criar colegiado
    col = Colegiado.create(nome: "Bacharelado em Ciência da Computação", codigo: "112140")

    ### Atualizar colegiado dos alunos
    Aluno.where(colegiado: nil).update(colegiado: col)

    ### Configurar título    
    Rodada.create(descricao: "Matrícula BCC - acesse http://v.ht/filabcc")

    ### Criar usuário admin (troque a senha no comando abaixo):
    User.create(email: "admin@example.com", superadmin_role: true, password: "admin2222", password_confirmation: "admin2222")
    User.create(email: "tela@example.com", user_role: true, password: "tela2222", password_confirmation: "tela2222")

    ### Criar mesas (você pode modificá-las em `/mesas`):
    Mesa.create(nome: "Sala 116, Mesa 1")
    Mesa.create(nome: "Sala 116, Mesa 2")

    ### Criar grupos de alunos e filas: 
    g = Grupo.create(nome: "Prováveis concluintes")
    g.update(alunos: Aluno.where(colegiado: col).where(formando: true))
    g = Grupo.create(nome: "Alunos que realizaram pré-matrícula")
    g.update(alunos: Aluno.where(colegiado: col).where(fezPreMatricula: true))
    g = Grupo.create(nome: "Alunos com CR >= 6,0")
    g.update(alunos: Aluno.where(colegiado: col).where("score >= 60"))
    g = Grupo.create(nome: "Alunos com CR entre 4,8 e 5,9")
    g.update(alunos: Aluno.where(colegiado: col).where("score >= 48 AND score <= 59"))
    g = Grupo.create(nome: "Alunos com CR entre 3,0 e 4,7")
    g.update(alunos: Aluno.where(colegiado: col).where("score >= 30 AND score <= 47"))
    g = Grupo.create(nome: "Alunos com CR <= 2,9")
    g.update(alunos: Aluno.where(colegiado: col).where("score <= 29"))
    
    ### Criar filas e associar grupos iniciais:
    fila1 = Fila.create(codigo: "CCA", nome: "Ciência da Computação, prioridade maior", posicao: 0, colegiado: col)
    fila2 = Fila.create(codigo: "CCB", nome: "Ciência da Computação, prioridade menor", posicao: 0, colegiado: col)
    g = Grupo.find_by nome: "Prováveis concluintes"
    g.update(fila: fila1)
    g = Grupo.find_by nome: "Alunos que realizaram pré-matrícula"
    g.update(fila: fila2)
    exit

Se quiser trocar a senha depois de criar os usuários, acesse `/admin/user` (como admin)

O usuário admin pode fazer tudo. O usuário tela pode inscrever alunos na fila.

Se quiser RESETAR AS FILAS:

    rails console
    Vaga.delete_all
    Fila.update(posicao: 0)
    exit

# Matrícula BCC 2018.2 -- Calouros

Importar os alunos com os scores:

    # Localmente
    FILE=~/Desktop/matricula-ccc/calouros-20182.txt rails runner script/le-alunos-cr.rb

    # no Heroku
    cat ~/Desktop/matricula-ccc/calouros-20182.txt | heroku run --no-tty FILE=/dev/stdin rails runner script/le-alunos-cr.rb

Criar alguns registros iniciais (no Heroku você deve executar `heroku run rails console`):

    rails console

    g = Grupo.create(nome: "Calouros do BCC")
    g.update(alunos: Aluno.where(colegiado: nil))

    ### Atualizar colegiado dos alunos
    col = Colegiado.find_by codigo: "112140"
    Aluno.where(colegiado: nil).update(colegiado: col)

    ### Associar fila: fazer no dia pela interface admin


# Matrícula BSI 2018.2

## Preparação

Importar os alunos com os scores:

    # Localmente
    FILE=~/Desktop/matricula-ccc/alunos-bsi-CR-20182.txt rails runner script/le-alunos-cr.rb

    # no Heroku
    cat ~/Desktop/matricula-ccc/alunos-bsi-CR-20182.txt | heroku run --no-tty FILE=/dev/stdin rails runner script/le-alunos-cr.rb

Criar alguns registros iniciais (no Heroku você deve executar `heroku run rails console`):

    rails console

    ### Criar colegiado
    col = Colegiado.create(nome: "Bacharelado em Sistemas de Informação", codigo: "195140")

    ### Atualizar colegiado dos alunos
    Aluno.where(colegiado: nil).update(colegiado: col)

    ### Criar mesas (você pode modificá-las em `/mesas`):
    Mesa.create(nome: "Sala 115")

    ### Criar grupos de alunos e filas:
    g = Grupo.create(nome: "Alunos do BSI")
    g.update(alunos: Aluno.where(colegiado: col))

    ### Criar filas e associar grupos iniciais:
    fila = Fila.create(codigo: "BSI", nome: "Fila do BSI", posicao: 0, colegiado: col)
    g.update(fila: fila)


# Matrícula LC 2018.2

## Preparação

Importar os alunos com os scores:

    # Localmente
    FILE=~/Desktop/matricula-ccc/alunos-lc-20182.txt rails runner script/le-alunos-cr.rb

    # no Heroku
    cat ~/Desktop/matricula-ccc/alunos-lc-20182.txt | heroku run --no-tty FILE=/dev/stdin rails runner script/le-alunos-cr.rb

Criar alguns registros iniciais (no Heroku você deve executar `heroku run rails console`):

    rails console

    ### Criar colegiado
    col = Colegiado.create(nome: "Licenciatura em Computação", codigo: "196120")

    ### Atualizar colegiado dos alunos
    Aluno.where(colegiado: nil).update(colegiado: col)

    ### Criar grupos de alunos e filas:
    g = Grupo.create(nome: "Alunos de LC")
    g.update(alunos: Aluno.where(colegiado: col))

    ### Criar filas e associar grupos iniciais:
    fila = Fila.create(codigo: "LC", nome: "Fila de LC", posicao: 0, colegiado: col)
    g.update(fila: fila)


# Como usar durante a matrícula

Acessar `/mesas` e escolher uma mesa

Acessar `/colegiados/1` e começar a chamar os alunos