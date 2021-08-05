/*1) Escreva comandos select, utilizando as tabelas para uma rede social criadas nas listas de
exercícios anteriores, para responder as perguntas:*/

--a) Quais os nomes dos usuários em comum entre os grupos SQLite e Banco de Dados-IFRS-2021?
select
    distinct
    perfil.nome as perfil
    from grupo,grupoPerfil,perfil
    where
    lower(grupo.nome)= ('banco de dados-ifrs2021') and
    grupo.codigo=grupoPerfil.grupo and
    lower(perfil.email) like grupoPerfil.perfil
    intersect
    select
    distinct
    perfil.nome as perfil
    from grupo,grupoPerfil,perfil
    where
    lower(grupo.nome)= ('sqlite') and
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
        and post.data between datetime('now','-30 days') and datetime('now')
        group by perfil.nome,post.codigo
        having count(*) = (
        select 
            distinct
            count(*) as rank
            from perfil,post,reaction
            where 
            perfil.email=post.perfil and
            reaction.postagem=post.codigo and
            lower(reaction.texto)='gostei' 
            and post.data between datetime('now','-30 days') and datetime('now')
            group by perfil.nome,post.codigo
            order by rank desc
            limit 1
        )
        order by count(*) desc
;
--c) Quais os 5 assuntos mais comentados no Brasil nos últimos 30 dias?
select 
    assunto.nome as nome
    from assunto,assuntoPost,post, perfil
    where 
        assunto.codigo=assuntoPost.assunto and
        post.codigo=assuntoPost.post and 
        perfil.email = post.perfil and 
        lower(perfil.pais)='brasil'
        and post.data between datetime('now','-30 days') and datetime('now')
    group by assunto.codigo
    having count(*) in
    (select 
    distinct count(*) as assunto1
    from assunto,assuntoPost,post, perfil
    where 
        assunto.codigo=assuntoPost.assunto and
        post.codigo=assuntoPost.post and 
        perfil.email = post.perfil and 
        lower(perfil.pais)='brasil'
        and post.data between datetime('now','-30 days') and datetime('now')
    group by assunto.codigo
    order by assunto1 desc
    limit 5
    )
    order by count(*) desc
;
--d) Quais os 5 assuntos mais comentados por país nos últimos 30 dias?
select 
    assunto.nome as nome,
    perfil.pais as pais,
    count(*)
    from assunto,assuntoPost,post, perfil
    where 
        assunto.codigo=assuntoPost.assunto and
        post.codigo=assuntoPost.post and 
        perfil.email = post.perfil 
        and post.data between datetime('now','-30 days') and datetime('now')
    group by perfil.pais
    having count(*) in
    (select 
    distinct count(*) as assunto1
    from assunto,assuntoPost,post, perfil
    where 
        assunto.codigo=assuntoPost.assunto and
        post.codigo=assuntoPost.post and 
        perfil.email = post.perfil 
        and post.data between datetime('now','-30 days') and datetime('now')
    group by perfil.pais
    order by assunto1 desc
    limit 5
    )
    order by count(*) desc
;
--e) Quais os assuntos da postagem que mais recebeu a reação amei na última semana?
--última=semana passada
select 
        distinct
        assunto.nome
    from 
    assunto
        join assuntoPost on assunto.codigo=assuntoPost.assunto
        join (
                select 
                    post.codigo as post
                from 
                reaction
                    join post on reaction.postagem=post.codigo
                where 
                    lower(reaction.texto)='amei' 
                    and datetime(reaction.data) between datetime('now','weekday 0','-14 days') and datetime('now','weekday 0','-8 days')
                group by post.codigo
                having count(*)=(
                                    select 
                                        count(*)
                                    from 
                                    reaction
                                        join post on reaction.postagem=post.codigo
                                    where 
                                        lower(reaction.texto)='amei' 
                                        and datetime(reaction.data) between datetime('now','weekday 0','-14 days') and datetime('now','weekday 0','-8 days')
                                    group by post.codigo
                                    order by count(*) desc
                                    limit 1
                                    )
            ) as post_with_more_ameis on assuntoPost.post=post_with_more_ameis.post
;
--f) Qual o nome do usuário que postou a postagem que teve mais curtidas no Brasil nos últimos 60 dias?
select
    perfil.nome
    from reaction
        join post on reaction.postagem=post.codigo
        join perfil on perfil.email=post.perfil
    where 
    reaction.texto='gostei' and
    lower(perfil.pais)='brasil' and
    reaction.data between datetime('now','-60 days')and datetime('now')
    group by reaction.postagem
    having count(*)=(
                        select
                        count(*)
                        from reaction
                            join post on reaction.postagem=post.codigo
                            join perfil on perfil.email=post.perfil
                        where 
                        reaction.texto='gostei' and
                        lower(perfil.pais)='brasil' and
                        reaction.data between datetime('now','-60 days')and datetime('now')
                        group by reaction.postagem
                        order by count(*) desc
                        limit 1
                    )
;
--g) Qual faixa etária mais reagiu às postagens do grupo SQLite nos últimos 60 dias? Considere as faixas etárias: -18, 18-21, 21-25, 25-30, 30-36, 36-43, 43-51, 51-60 e 60-.

--h) Dos 5 assuntos mais comentados no Brasil no mês passado, quais também estavam entre os 5 assuntos mais comentados no Brasil no mês retrasado?
--add assuntos no mes retrasado para teste
--assuntos mais comentados/postados no mes passado
select 
        assunto.nome
    from 
    assunto 
        join assuntoPost on assuntoPost.assunto=assunto.codigo 
        join post on post.codigo=assuntoPost.post
    where post.data between datetime('now','start of month','-1 months') and datetime('now','start of month','-1 days')
    group by assunto.codigo
    having count(*) in (
                        select 
                        distinct
                            count(*)
                        from 
                            assunto 
                            join assuntoPost on assuntoPost.assunto=assunto.codigo 
                            join post on post.codigo=assuntoPost.post
                        where post.data between datetime('now','start of month','-1 months') and datetime('now','start of month','-1 days')
                        group by assunto.codigo
                        order by count(*) desc
                        limit 5
                    )
intersect
--asuntos mais comentados/postados mes retrasado
select 
        assunto.nome
    from 
        assunto 
        join assuntoPost on assuntoPost.assunto=assunto.codigo 
        join post on post.codigo=assuntoPost.post
    where post.data between datetime('now','start of month','-2 months') and datetime('now','start of month','-1 months','-1 days')
    group by assunto.codigo
    having count(*) in (
                        select 
                        distinct
                            count(*)
                        from 
                        assunto 
                            join assuntoPost on assuntoPost.assunto=assunto.codigo 
                            join post on post.codigo=assuntoPost.post
                        where post.data between datetime('now','start of month','-2 months') and datetime('now','start of month','-1 months','-1 days')
                        group by assunto.codigo
                        order by count(*) desc
                        limit 5
                    )
;
--i) Quais os nomes dos usuários que participam do grupo SQLite que tiveram a 1ª, 2ª e 3ª maior quantidade de comentários em uma postagem sobre o assunto select?
--adicionar testes
select 
    perfil.nome
    from 
    post
        join post as post_postagem on post.postagem=post_postagem.codigo 
        join perfil on post_postagem.perfil=perfil.email
    where 
    post.postagem is not null 
    and post.postagem in (
                            select 
                                    post.codigo 
                                from 
                                    post
                                    join assuntoPost on assuntoPost.post=post.codigo
                                    join assunto on assuntoPost.assunto=assunto.codigo
                                where 
                                    post.postagem is null
                                    and post.perfil in (
                                                            select 
                                                                grupoPerfil.perfil
                                                                from grupoPerfil 
                                                                    join grupo on grupo.codigo=grupoPerfil.grupo
                                                                where 
                                                                lower(grupo.nome)='sqlite'        
                                                        )
                                    and lower(assunto.nome)='select'
                            )
    group by post.postagem
    having count(*) in (
                    select 
                        distinct
                        count(*) as qt_comments
                        from 
                        post
                        where 
                        post.postagem is not null 
                        and post.postagem in (
                                                select 
                                                        post.codigo 
                                                    from 
                                                        post
                                                        join assuntoPost on assuntoPost.post=post.codigo
                                                        join assunto on assuntoPost.assunto=assunto.codigo
                                                    where 
                                                        post.postagem is null
                                                        and post.perfil in (
                                                                                select 
                                                                                    grupoPerfil.perfil
                                                                                    from grupoPerfil 
                                                                                        join grupo on grupo.codigo=grupoPerfil.grupo
                                                                                    where 
                                                                                    lower(grupo.nome)='sqlite'        
                                                                            )
                                                        and lower(assunto.nome)='select'
                                                )
                        group by post.postagem
                        order by count(*) desc
                        limit 3
                    )
;
--j) Quais os nomes dos usuários dos grupos SQLite ou Banco de Dados-IFRS-2021 que possuem a maior quantidade de amigos?
select 
        perfil.nome
    from grupo,grupoPerfil,perfil,amigo 
    where
        (
            lower(grupo.nome)='sqlite'
            or
            lower(grupo.nome)='banco de dados ifrs2021'
        ) and   
        grupo.codigo=grupoPerfil.grupo and
        grupoPerfil.perfil=perfil.email and
        ( 
            lower(perfil.email)=lower(amigo.perfil) 
            or 
            lower(perfil.email)=lower(amigo.perfilAmigo)
        )
    group by perfil.email
    having count(*)=(
                        select 
                        distinct
                        count(*) as qt_amigos_maior
                        from grupo,grupoPerfil,perfil,amigo 
                        where
                            (
                                lower(grupo.nome)='sqlite'
                                or
                                lower(grupo.nome)='banco de dados ifrs2021'
                            ) and   
                            grupo.codigo=grupoPerfil.grupo and
                            grupoPerfil.perfil=perfil.email and
                            ( 
                                lower(perfil.email)=lower(amigo.perfil) 
                                or 
                                lower(perfil.email)=lower(amigo.perfilAmigo)
                            )
                        group by perfil.email
                        order by count(*) desc
                        limit 1
                    )
;
--k) Quais os nomes dos usuários dos grupos SQLite ou Banco de Dados-IFRS-2021 que possuem a maior quantidade de amigos em comum?
/*
    joao silva --> professor bd --> todos amigos do professor bd
*/
select 
perfil_email,
amigo_email
from (
        select 
        case 
            when perfil.email=amigo.perfil
                then amigo.perfil
            else amigo.perfilAmigo
        end as perfil_email,
        case 
            when perfil.email!=amigo.perfil
                then amigo.perfil
            else amigo.perfilAmigo
        end as amigo_email
        from 
        amigo,perfil
        where 
        (
            amigo.perfil=perfil.email 
            or 
            amigo.perfilAmigo=perfil.email 
        ) and 
        perfil.email in (
                            select 
                            distinct
                            grupoPerfil.perfil 
                            from 
                            grupo 
                            join grupoPerfil on grupo.codigo=grupoPerfil.grupo
                            where 
                                (
                                lower(grupo.nome)='sqlite'
                                or
                                lower(grupo.nome)='banco de dados-ifrs2021'
                                )
                        )
        order by perfil.email
)
        
       

        
--l) Quais os nomes dos usuários que devem ser sugeridos como amigos para um dado usuário? 
--Considere que, se A e B não são amigos mas possuem no mínimo 
--5 assuntos em comum entre os 10 assuntos mais comentados por cada um nos últimos 3 meses, 
--B deve ser sugerido como amigo de A.
/*
USER_A=professor@hotmail.com
USER_B=joaosbras@mymail.com
TESTADO com count(*)>1 
*/

select 
        tmp.prf as perfil1,
        case 
            when  
                count(*)>1 
                --and tmp2.prf not in () 
                then 
                tmp2.prf--,count(tmp.asst or tmp2.asst) asst_cm
            else 'Sem assuntos suficientes'
        end as perfil2
    from
        (
            select 
            perfil.nome as prf,
            assunto.nome as asst
            from 
            perfil 
                join post on perfil.email=post.perfil
                join assuntoPost on assuntoPost.post=post.codigo
                join assunto on assunto.codigo=assuntoPost.assunto
            where 
            perfil.email='professor@hotmail.com' and
            datetime(post.data) between datetime('now','start of month','-3 months') and datetime('now','start of month','-1 days')
            group by assunto.codigo
            having count(*) in (
                                    select 
                                    distinct
                                    count(*)
                                    from 
                                    perfil 
                                        join post on perfil.email=post.perfil
                                        join assuntoPost on assuntoPost.post=post.codigo
                                        join assunto on assunto.codigo=assuntoPost.assunto
                                    where 
                                    perfil.email='professor@hotmail.com' and
                                    datetime(post.data) between datetime('now','start of month','-3 months') and datetime('now','start of month','-1 days')
                                    group by assunto.codigo
                                    order by count(*) desc
                                    limit 10
                                )
        
        ) as tmp
        join (    
                select 
                perfil.nome as prf,
                assunto.nome as asst
                from 
                perfil 
                    join post on perfil.email=post.perfil
                    join assuntoPost on assuntoPost.post=post.codigo
                    join assunto on assunto.codigo=assuntoPost.assunto
                where 
                perfil.email='joaosbras@mymail.com' and
                datetime(post.data) between datetime('now','start of month','-3 months') and datetime('now','start of month','-1 days')
                group by assunto.codigo
                having count(*) in (
                                        select 
                                        distinct
                                        count(*)
                                        from 
                                        perfil 
                                            join post on perfil.email=post.perfil
                                            join assuntoPost on assuntoPost.post=post.codigo
                                            join assunto on assunto.codigo=assuntoPost.assunto
                                        where 
                                        perfil.email='joaosbras@mymail.com' 
                                        and datetime(post.data) between datetime('now','start of month','-3 months') and datetime('now','start of month','-1 days')
                                        group by assunto.codigo
                                        order by count(*) desc
                                        limit 10
                                    )
            ) as tmp2 on tmp2.asst=tmp.asst
    ;

/*2) Descreva e justifique as adequações/alterações que foram realizadas nas tabelas criadas para
uma rede social nas listas de exercícios anteriores para que o exercício 1 acima pudesse ser
resolvido.*/
