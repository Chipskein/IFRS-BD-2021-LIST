-- a) Quais os nomes dos usuários que são amigos de Maria Cruz Albuquerque, e-mail mcalbuq@mymail.com?
select 
    perfil.nome 
    from perfil,amigo 
    where (amigo.perfilAmigo=perfil.email or amigo.perfil=perfil.email) and 
    (amigo.perfil like '%mcalbuq@mymail.com%' or amigo.perfilAmigo like '%mcalbuq@mymail.com%') and 
    perfil.email not like '%mcalbuq@mymail.com%'
;

--b) Quais os nomes dos usuários que são amigos de Paulo Xavier Ramos, e-mail pxramos@mymail.com, e também de Joana Rosa Medeiros, e-mail jorosamed@mymail.com?
select * 
    from perfil,amigo 
    where (amigo.perfilAmigo=perfil.email or amigo.perfil=perfil.email) 
    and (amigo.perfil like '%pxramos@mymail.com%' or amigo.perfil like '%jorosamed@mymail.com%' and amigo.perfilAmigo like '%pxramos@mymail.com%' or amigo.perfilAmigo like '%jorosamed@mymail.com%') 
    and perfil.email not like '%pxramos@mymail.com%' and perfil.email not like '%jorosamed@mymail.com%'
;

--c) Qual a média de curtidas nas postagens que contém o assunto banco de dados?
select
    count(*) as curtidas,
    assunto.nome as assunto,
    cast(count(*)as real)/count(distinct(post)) as media 
    from reaction,assunto,assuntoPost, post
    where 
        reaction.postagem=post.codigo and
        reaction.texto='gostei' and
        assunto.codigo=assuntoPost.assunto and
        post.codigo=assuntoPost.post and
        assunto.nome='BD'
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
        assunto.nome='BD'
;

--e) Quantas postagens sobre o assunto banco de dados receberam a reação amei nos últimos 3 meses?
select
    count(*) as ameis,
    count(distinct(post)) as postagens
    from reaction,assunto,assuntoPost, post
    where 
        reaction.postagem=post.codigo and
        reaction.texto='amei' and
        assunto.codigo=assuntoPost.assunto and
        post.codigo=assuntoPost.post and
        assunto.nome='BD' and
        reaction.data between datetime('now','-3 months') and datetime('now')
;
--f) Qual o ranking dos assuntos mais postados na última semana?

    --considera-se ultima semana esta semana
    --testar em outra data 
select 
    assunto.nome,
    count(*) as assunto_semana 
    from assunto,assuntoPost,post
    where 
        assunto.codigo=assuntoPost.assunto and
        post.codigo=assuntoPost.post 
        --and post.data between datetime('now','weekday 0','- 7 days') and datetime('now','weekday 0')
    group by assunto.codigo
    order by assunto_semana desc
;
--g) Qual o ranking da quantidade de postagens por estado no Brasil nos últimos 3 meses?
--postagem=post
select 
    perfil.estado as estado,
    count(*) as postagem_by_state
    from perfil,post 
    where 
        perfil.email=post.perfil 
        and post.data between datetime('now','-3 months') and datetime('now')
        and perfil.pais like '%Brasil%'
    group by perfil.estado
    order by postagem_by_state desc
;
--h) Qual o ranking da quantidade de postagens contendo o assunto banco de dados por estado no Brasil nos últimos 3 meses?
select 
    assunto.nome,
    perfil.estado,
    count(*) as assunto_em_postagem
    from perfil,post,assuntoPost,assunto
    where
        perfil.email=post.perfil and
        assuntoPost.post=post.codigo and
        assuntoPost.assunto=assunto.codigo and
        assunto.nome like '%bd%' and
        post.data between datetime('now','-3 months') and datetime('now')
    group by perfil.estado
    order by assunto_em_postagem
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
    reaction.texto='gostei' and
    post.data between datetime('now','-30 days') and datetime('now')
    group by perfil.nome
    order by curtidas_usuario desc
;

--j) Qual o ranking da quantidade de reações às postagens do grupo SQLite por faixa etária por gênero nos últimos 60 dias? Considere as faixas etárias: -18, 18-21, 21-25, 25-30, 30-36, 36-43, 43- 51, 51-60 e 60-.
--k) Quais os nomes dos usuários que tiveram alguma postagem comentada pelo usuário Edson Arantes do Nascimento, e-mail pele@cbf.com.br, no último mês?
select 
    perfil.nome
    from post,comentario,perfil
    where 
    comentario.postagem=post.codigo and
    perfil.email=post.perfil and
    comentario.perfil='pele@cbf.com.br' and
    comentario.data between datetime('now','-1 months') and datetime('now')
;
--l) Quais os nomes dos usuários que são amigos dos membros do grupo Banco de Dados-IFRS2021?
select
    DISTINCT
    perfil.nome as amigo
    from grupo,grupoPerfil,amigo,perfil
    where 
    grupo.nome like '%Banco de Dados-IFRS2021%' and
    grupo.codigo=grupoPerfil.grupo and
    (amigo.perfil=grupoPerfil.perfil or amigo.perfilAmigo=grupoPerfil.perfil) AND
    (perfil.email=amigo.perfil or perfil.email=amigo.perfilAmigo) and perfil.email not like grupoPerfil.perfil
;
--m) Quais os nomes dos usuários que receberam mais de 1000 curtidas em uma postagem, em menos de 24 horas após a postagem, nos últimos 7 dias?
--n) Quais os assuntos das postagens do usuário Paulo Martins Silva, e-mail pmartinssilva90@mymail.com, compartilhadas pelo usuário João Silva Brasil, e-mail joaosbras@mymail.com, nos últimos 3 meses?


