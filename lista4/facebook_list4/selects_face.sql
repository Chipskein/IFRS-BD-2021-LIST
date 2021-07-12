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
    and (amigo.perfil like '%pxramos@mymail.com%' or amigo.perfilAmigo like '%pxramos@mymail.com%' or amigo.perfil like '%jorosamed@mymail.com%' or amigo.perfilAmigo like '%jorosamed@mymail.com%') 
    and perfil.email not like '%pxramos@mymail.com%' or perfil.email not like '%jorosamed@mymail.com%'
;

--c) Qual a média de curtidas nas postagens que contém o assunto banco de dados?
--d) Qual a média de comentários das postagens que contém o assunto banco de dados?
--e) Quantas postagens sobre o assunto banco de dados receberam a reação amei nos últimos 3 meses?
--f) Qual o ranking dos assuntos mais postados na última semana?
--considera-se ultima semana está semana
select 
    assunto.nome,
    count(*) as assunto_semana 
    from assunto,assuntoPost,post
    where 
    assunto.codigo=assuntoPost.assunto and
    post.codigo=assuntoPost.post --and
    --post.data between datetime('now','weekday 0','- 7 days') and datetime('now','weekday 0')
    group by assunto.codigo
    order by assunto_semana desc
;
--g) Qual o ranking da quantidade de postagens por estado no Brasil nos últimos 3 meses?
--postagem=post,comentario,resposta,reação
select 
    perfil.estado as estado,
    count(*) as postagem_by_state
    from perfil,post 
    where 
    perfil.email=post.perfil 
    --and post.postagem is null
    and post.data between datetime('now','-3 months') and datetime('now')
    and perfil.pais like '%Brasil%'
    group by perfil.estado
    order by postagem_by_state desc
;
--h) Qual o ranking da quantidade de postagens contendo o assunto banco de dados por estado no Brasil nos últimos 3 meses?
select * 
from perfil,post,assuntoPost,assunto
where
perfil.email=post.email and
assuntoPost.post=post.codigo and
assuntoPost.assunto=assunto.codigo;

--i) Qual o ranking dos usuários do Brasil que mais receberam curtidas em suas postagens nos últimos 30 dias?
--j) Qual o ranking da quantidade de reações às postagens do grupo SQLite por faixa etária por gênero nos últimos 60 dias? Considere as faixas etárias: -18, 18-21, 21-25, 25-30, 30-36, 36-43, 43- 51, 51-60 e 60-.
--k) Quais os nomes dos usuários que tiveram alguma postagem comentada pelo usuário Edson Arantes do Nascimento, e-mail pele@cbf.com.br, no último mês?
--l) Quais os nomes dos usuários que são amigos dos membros do grupo Banco de Dados-IFRS2021?
--m) Quais os nomes dos usuários que receberam mais de 1000 curtidas em uma postagem, em menos de 24 horas após a postagem, nos últimos 7 dias?
--n) Quais os assuntos das postagens do usuário Paulo Martins Silva, e-mail pmartinssilva90@mymail.com, compartilhadas pelo usuário João Silva Brasil, e-mail joaosbras@mymail.com, nos últimos 3 meses?




