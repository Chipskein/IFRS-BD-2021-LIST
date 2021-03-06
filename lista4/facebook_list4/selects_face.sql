--1)
-- a) Quais os nomes dos usuários que são amigos de Maria Cruz Albuquerque, e-mail mcalbuq@mymail.com?
select 
    perfil.nome 
    from perfil,amigo 
    where 
        (
            lower(amigo.perfilAmigo)=lower(perfil.email) or 
            lower(amigo.perfil)=lower(perfil.email)
        ) 
        and (
                lower(amigo.perfil)='mcalbuq@mymail.com' or 
                lower(amigo.perfilAmigo)='mcalbuq@mymail.com'
            ) 
        and perfil.email not like 'mcalbuq@mymail.com'
;

--b) Quais os nomes dos usuários que são amigos de Paulo Xavier Ramos, e-mail pxramos@mymail.com, e também de Joana Rosa Medeiros, e-mail jorosamed@mymail.com?
select perfil.nome
    from perfil,amigo 
    where 
        (
            lower(amigo.perfilAmigo)=lower(perfil.email) or 
            lower(amigo.perfil)=lower(perfil.email)
        ) 
    and (
            lower(amigo.perfil)='pxramos@mymail.com' or lower(amigo.perfil)='jorosamed@mymail.com' and 
            lower(amigo.perfilAmigo)='pxramos@mymail.com' or lower(amigo.perfilAmigo)='jorosamed@mymail.com'
        ) 
    and perfil.email not like 'pxramos@mymail.com' 
    and perfil.email not like 'jorosamed@mymail.com'
;

--c) Qual a média de curtidas nas postagens que contém o assunto banco de dados?
select
    count(*) as curtidas,
    assunto.nome as assunto,
    cast(count(*)as real)/count(distinct(post)) as media 
    from reaction,assunto,assuntoPost, post
    where 
        reaction.postagem=post.codigo and
        lower(reaction.texto)='gostei' and
        assunto.codigo=assuntoPost.assunto and
        post.codigo=assuntoPost.post and
        lower(assunto.nome)='bd'
;
 
--d) Qual a média de comentários das postagens que contém o assunto banco de dados?
select
    count(*) as comentarios,
    assunto.nome as assunto,
    cast(count(*)as real)/count(distinct(comentario.postagem)) as media 
    from comentario,assunto,assuntoPost, post
    where 
        comentario.postagem=post.codigo and
        assunto.codigo=assuntoPost.assunto and
        post.codigo=assuntoPost.post and
        lower(assunto.nome)='bd'
;

--e) Quantas postagens sobre o assunto banco de dados receberam a reação amei nos últimos 3 meses?
select
    --count(*) as ameis,
    count(distinct(post)) as postagens
    from reaction,assunto,assuntoPost, post
    where 
        reaction.postagem=post.codigo and
        lower(reaction.texto)='amei' and
        assunto.codigo=assuntoPost.assunto and
        post.codigo=assuntoPost.post and
        lower(assunto.nome)='bd' and
        reaction.data between datetime('now','start of month','-2 months') and datetime('now','start of month','+1 month','-1 second')
;
--f) Qual o ranking dos assuntos mais postados na última semana?

    --considera-se ultima semana esta semana
    --entre 00:00:00 do domingo e 23:59:59 do sabado desta semana
select 
    assunto.nome,
    count(*) as assunto_semana 
    from assunto,assuntoPost,post
    where 
        assunto.codigo=assuntoPost.assunto and
        post.codigo=assuntoPost.post 
        and post.data between datetime(date('now'),'weekday 0','-7 days') and datetime(date('now'),'weekday 0','-1 second')
    group by assunto.codigo
    order by assunto_semana desc
;
--g) Qual o ranking da quantidade de postagens por estado no Brasil nos últimos 3 meses?
--postagem=post
--ultimos 3 meses = 2 meses passdos+mes atual
select 
    perfil.estado as estado,
    count(*) as postagem_by_state
    from perfil,post 
    where 
        perfil.email=post.perfil 
        and post.data between datetime('now','start of month','-2 months') and datetime('now','start of month','+1 month','-1 second')
        and perfil.pais like '%Brasil%'
    group by perfil.estado
    order by postagem_by_state desc
;
--h) Qual o ranking da quantidade de postagens contendo o assunto banco de dados por estado no Brasil nos últimos 3 meses?
--ultimos 3 meses = 2 mes passdos + mes atual
select 
    assunto.nome,
    perfil.estado,
    count(*) as assunto_em_postagem
    from perfil,post,assuntoPost,assunto
    where
        perfil.email=post.perfil and
        assuntoPost.post=post.codigo and
        assuntoPost.assunto=assunto.codigo and
        lower(assunto.nome)='bd' and
        post.data between datetime('now','start of month','-2 months') and datetime('now','start of month','+1 month','-1 second')
    group by perfil.estado
    order by assunto_em_postagem desc
;
--i) Qual o ranking dos usuários do Brasil que mais receberam curtidas em suas postagens nos últimos 30 dias?
    --testar em outra data
select 
    perfil.nome,
    count(*) as curtidas_usuario
    from perfil,post,reaction 
    where 
    perfil.email=post.perfil and 
    reaction.postagem=post.codigo and
    perfil.pais like '%brasil%' and
    lower(reaction.texto)='gostei' and
    reaction.data between datetime('now','-30 days') and datetime('now')
    group by perfil.nome
    order by curtidas_usuario desc
;

--j) Qual o ranking da quantidade de reações às postagens do grupo SQLite por faixa etária por gênero nos últimos 60 dias? Considere as faixas etárias: -18, 18-21, 21-25, 25-30, 30-36, 36-43, 43- 51, 51-60 e 60-.
select 
    grupo.nome as grupo,
    count(*) as Reacoes,
    case 
    when cast ((
    JulianDay('now') - JulianDay(perfil.nascimento)
    ) / 365 As integer)<18 then '-18'
    when cast ((
    JulianDay('now') - JulianDay(perfil.nascimento)
    ) / 365 As integer) BETWEEN 18 and 21 then '18-21'
    when cast ((
    JulianDay('now') - JulianDay(perfil.nascimento)
    ) / 365 As integer) BETWEEN 21 and 25 then '21-25'
    when cast ((
    JulianDay('now') - JulianDay(perfil.nascimento)
    ) / 365 As integer) BETWEEN 25 and 30 then '25-30'
    when cast ((
    JulianDay('now') - JulianDay(perfil.nascimento)
    ) / 365 As integer) BETWEEN 30 and 36 then '30-36'
    when cast ((
    JulianDay('now') - JulianDay(perfil.nascimento)
    ) / 365 As integer) BETWEEN 36 and 43 then '36-43'
        when cast ((
    JulianDay('now') - JulianDay(perfil.nascimento)
    ) / 365 As integer) BETWEEN 43 and 51 then '43-51'
        when cast ((
    JulianDay('now') - JulianDay(perfil.nascimento)
    ) / 365 As integer) BETWEEN 51 and 60 then '51-60'
        when cast ((
    JulianDay('now') - JulianDay(perfil.nascimento)
    ) / 365 As integer)>60 then '+60'
    end as idade,
    perfil.genero
    from grupo,post,reaction,perfil
    where 
    reaction.postagem=post.codigo and
    perfil.email=reaction.perfil and
    lower(grupo.nome)='sqlite' and
    post.grupo = grupo.codigo and
    reaction.data between datetime('now','-60 days') and datetime('now')
    group by idade, perfil.genero
    order by count(*) desc
;

--k) Quais os nomes dos usuários que tiveram alguma postagem comentada pelo usuário Edson Arantes do Nascimento, e-mail pele@cbf.com.br, no último mês?
--ultimo mes=este mês
select 
    distinct
    perfil.nome
    from post,comentario,perfil
    where 
    comentario.postagem=post.codigo and
    perfil.email=post.perfil and
    lower(comentario.perfil)='pele@cbf.com.br' and
    comentario.data between datetime('now','start of month') and datetime('now','start of month','+1 months','-1 day')
;
--l) Quais os nomes dos usuários que são amigos dos membros do grupo Banco de Dados-IFRS2021?
--considera-se tambem os usuarios que são amigos dos membros do grupo e que também são membros do grupo
select
    distinct
    perfil.nome as amigo
    from grupo,grupoPerfil,amigo,perfil
    where 
        lower(grupo.nome)='banco de dados-ifrs2021' and
        grupo.codigo=grupoPerfil.grupo and
    (
        lower(amigo.perfil)=lower(grupoPerfil.perfil) or 
        lower(amigo.perfilAmigo)=lower(grupoPerfil.perfil)
    ) AND
    (
        lower(perfil.email)=lower(amigo.perfil) or 
        lower(perfil.email)=lower(amigo.perfilAmigo)
    ) and 
        lower(perfil.email) not like lower(grupoPerfil.perfil)
;
--m) Quais os nomes dos usuários que receberam mais de 1000 curtidas em uma postagem, em menos de 24 horas após a postagem, nos últimos 7 dias?
select 
    distinct
    perfil.nome as nome
    from perfil,post,reaction
    where 
    perfil.email=post.perfil and
    reaction.postagem=post.codigo and
    lower(reaction.texto)='gostei' 
    and reaction.data between datetime(post.data) and datetime(post.data,'+24 hours') 
    and post.data between datetime('now','-7 days') and datetime('now')
    group by perfil.nome,post.codigo
    having count(*)>1000
;
--n) Quais os assuntos das postagens do usuário Paulo Martins Silva, e-mail pmartinssilva90@mymail.com, compartilhadas pelo usuário João Silva Brasil, e-mail joaosbras@mymail.com, nos últimos 3 meses?
--ultimos 3 meses = 2 mes passdos + mes atual
select 
    distinct
    assunto.nome
    from compartilhamento,post,assuntoPost,assunto
    where 
        assuntoPost.assunto=assunto.codigo and
        assuntoPost.post=post.codigo and
        post.codigo=compartilhamento.codigo_post and
        lower(compartilhamento.perfil)='joaosbras@mymail.com' and
        lower(post.perfil)='pmartinssilva90@mymail.com' and 
        compartilhamento.data_compartilhamento BETWEEN datetime('now','start of month','-2 months') and datetime('now','start of month','+1 month','-1 second')
;
--2)
/*
*Adicionados
    perfil(nascimento)
        foi adicionado pois é necessário para saber a idade do usuario
    perfil(genero)
        foi adicionado pois é necessário saber o genero do usuario
    post(grupo)
        foi adicionado pois é possivel fazer post no feed de um grupo
    post(pagina)
        foi adicionado pois é possivel fazer posts no feed de uma página
    compartilhamento
        foi adicionado para guardar o compartilhamento de um post por um usuario de uma forma mais clara
    comentario 
        foi adicionado para guardar os comentario de um post de uma forma mais clara
    reaction
        foi adicionado para guardar as reaçoes de um post ou comentario de uma forma mais clara
*Removido
    post(postagem)
        devido a adição da tabela comentario não é necessário o atributo postagem
*/ 
