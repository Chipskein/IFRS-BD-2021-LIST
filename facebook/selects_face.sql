/*1) Escreva comandos select, utilizando as tabelas para uma rede social criadas nas listas de
exercícios anteriores, para responder as perguntas:*/

--a) Quais os nomes dos usuários em comum entre os grupos SQLite e Banco de Dados-IFRS-2021?
    select
    distinct
    perfil.nome as perfil
    from grupo,grupoPerfil,perfil
    where 
    lower(grupo.nome)= ('banco de dados-ifrs2021') intersect ('sqlite')
    grupo.codigo=grupoPerfil.grupo and
    lower(perfil.email) like grupoPerfil.perfil
;

--b) Qual o nome do usuário do Brasil que mais recebeu curtidas em suas postagens nos últimos 30 dias?

    select 
        distinct
        perfil.nome as nome
        from perfil,post,reaction
        where 
        perfil.email=post.perfil and
        reaction.postagem=post.codigo and
        lower(reaction.texto)='gostei' 
        and post.data between datetime('now','-7 days') and datetime('now')
        group by perfil.nome,post.codigo
        order by count(*)
;

--c) Quais os 5 assuntos mais comentados no Brasil nos últimos 30 dias?

--d) Quais os 5 assuntos mais comentados por país nos últimos 30 dias?

--e) Quais os assuntos da postagem que mais recebeu a reação amei na última semana?

--f) Qual o nome do usuário que postou a postagem que teve mais curtidas no Brasil nos últimos 60 dias?

--g) Qual faixa etária mais reagiu às postagens do grupo SQLite nos últimos 60 dias? Considere as faixas etárias: -18, 18-21, 21-25, 25-30, 30-36, 36-43, 43-51, 51-60 e 60-.

--h) Dos 5 assuntos mais comentados no Brasil no mês passado, quais também estavam entre os 5 assuntos mais comentados no Brasil no mês retrasado?

--i) Quais os nomes dos usuários que participam do grupo SQLite que tiveram a 1ª, 2ª e 3ª maior quantidade de comentários em uma postagem sobre o assunto select?

--j) Quais os nomes dos usuários dos grupos SQLite ou Banco de Dados-IFRS-2021 que possuem a maior quantidade de amigos?

--k) Quais os nomes dos usuários dos grupos SQLite ou Banco de Dados-IFRS-2021 que possuem a maior quantidade de amigos em comum?

--l) Quais os nomes dos usuários que devem ser sugeridos como amigos para um dado usuário? Considere que, se A e B não são amigos mas possuem no mínimo 5 assuntos em comum entre os 10 assuntos mais comentados por cada um nos últimos 3 meses, B deve ser sugerido como amigo de A.

/*2) Descreva e justifique as adequações/alterações que foram realizadas nas tabelas criadas para
uma rede social nas listas de exercícios anteriores para que o exercício 1 acima pudesse ser
resolvido.*/