--1) Escreva comandos insert, update ou delete, utilizando as tabelas criadas para uma rede social nas listas de exercícios anteriores, para:
--a) Alterar o texto da última postagem do usuário Edson Arantes do Nascimento, e-mail
--pele@cbf.com.br, de "Brasil: 20 medalhas nas Olimpíadas 2020/2021 em Tóquio" para "Brasil: 21
--medalhas nas Olimpíadas 2020/2021 em Tóquio".

--pega ultima postagem e verifica se o texto correto
update 
    post 
    set 
        texto= 'Brasil: 21 medalhas nas Olimpíadas 2020/2021 em Tóquio',
        data=datetime('now')--ultima alteração
    where 
    codigo in (
        select 
        post.codigo 
        from 
        post
        where
        post.data=(
                    select data from post where perfil='pele@cbf.com.br'
                    order by post.data desc
                    limit 1
                )
    )
    and post.texto='Brasil: 20 medalhas nas Olimpíadas 2020/2021 em Tóquio'
;

--b) Alterar a última reação do usuário Paulo Xavier Ramos, e-mail pxramos@mymail.com, à uma postagem no grupo SQLite de like para amei

--pega a ultima reação depois verifica se é um gostei
update 
    reaction 
    set 
        texto ='amei', 
        data=datetime('now')
    where 
    codigo in (
        select 
            reaction.codigo
        from grupo 
            join post on post.grupo=grupo.codigo
            join reaction on post.codigo=reaction.postagem
        where 
            lower(grupo.nome)='sqlite' and
            reaction.perfil='pxramos@mymail.com' and
            reaction.data = (

                                select 
                                reaction.data as ult_data 
                                from grupo 
                                join post on post.grupo=grupo.codigo
                                join reaction on post.codigo=reaction.postagem
                                where 
                                lower(grupo.nome)='sqlite' and
                                reaction.perfil='pxramos@mymail.com'
                                order by reaction.data desc
                                limit 1
                            )
    )
     and reaction.texto='gostei'
;

--c) Desativar temporariamente as contas dos usuários do Brasil que não possuem qualquer atividade na rede social há mais de 5 anos.

update 
    perfil
    set status ='desativado'
    where email in 
    (
        select 
        email
        from perfil
        where
        email not in (
                        select post.perfil from post where strftime('%Y',post.data) between strftime('%Y','now','-5 years') and strftime('%Y','now')
                        union
                        select reaction.perfil from reaction where strftime('%Y',reaction.data) between strftime('%Y','now','-5 years') and strftime('%Y','now')
                        union
                        select compartilhamento.perfil from compartilhamento where strftime('%Y',compartilhamento.data_compartilhamento) between strftime('%Y','now','-5 years') and strftime('%Y','now')
                    )
    )
;

--d) Excluir a última postagem no grupo IFRS-Campus Rio Grande, classificada como postagem que incita ódio.

--testado com o grupo 'sqlite' e com a classificação 'verificado'
--remove citações
delete  
    from 
    citacao
    where 
    citacao.post in (
                        select 
                        post.codigo
                        from 
                            grupo 
                                join post on post.grupo=grupo.codigo 
                                join classificacaoPost on post.codigo=classificacaoPost.post
                                join classificacao on classificacao.cod=classificacaoPost.classificacao
                        where 
                        lower(grupo.nome)='sqlite' and
                        lower(classificacao.nome)='verificado' and
                        post.data= (
                                        select 
                                        post.data
                                        from 
                                            grupo 
                                                join post on post.grupo=grupo.codigo 
                                                join classificacaoPost on post.codigo=classificacaoPost.post
                                                join classificacao on classificacao.cod=classificacaoPost.classificacao
                                        where 
                                        lower(grupo.nome)='sqlite' and
                                        lower(classificacao.nome)='verificado'
                                        order by post.data desc 
                                        limit 1
                                    )
                )
;
--remove assuntos
delete  
    from 
    assuntoPost
    where 
    assuntoPost.post in (
                        select 
                        post.codigo
                        from 
                            grupo 
                                join post on post.grupo=grupo.codigo 
                                join classificacaoPost on post.codigo=classificacaoPost.post
                                join classificacao on classificacao.cod=classificacaoPost.classificacao
                        where 
                        lower(grupo.nome)='sqlite' and
                        lower(classificacao.nome)='verificado' and
                        post.data= (
                                        select 
                                        post.data
                                        from 
                                            grupo 
                                                join post on post.grupo=grupo.codigo 
                                                join classificacaoPost on post.codigo=classificacaoPost.post
                                                join classificacao on classificacao.cod=classificacaoPost.classificacao
                                        where 
                                        lower(grupo.nome)='sqlite' and
                                        lower(classificacao.nome)='verificado'
                                        order by post.data desc 
                                        limit 1
                                    )
                )
;
--remove reações
delete  
    from 
    reaction
    where 
    reaction.postagem in (
                        select 
                        post.codigo
                        from 
                            grupo 
                                join post on post.grupo=grupo.codigo 
                                join classificacaoPost on post.codigo=classificacaoPost.post
                                join classificacao on classificacao.cod=classificacaoPost.classificacao
                        where 
                        lower(grupo.nome)='sqlite' and
                        lower(classificacao.nome)='verificado' and
                        post.data= (
                                        select 
                                        post.data
                                        from 
                                            grupo 
                                                join post on post.grupo=grupo.codigo 
                                                join classificacaoPost on post.codigo=classificacaoPost.post
                                                join classificacao on classificacao.cod=classificacaoPost.classificacao
                                        where 
                                        lower(grupo.nome)='sqlite' and
                                        lower(classificacao.nome)='verificado'
                                        order by post.data desc 
                                        limit 1
                                    )
                )
;
--remove commentarios e post
delete  
    from 
    post
    where 
    post.postagem in (
                        select 
                        post.codigo
                        from 
                            grupo 
                                join post on post.grupo=grupo.codigo 
                                join classificacaoPost on post.codigo=classificacaoPost.post
                                join classificacao on classificacao.cod=classificacaoPost.classificacao
                        where 
                        lower(grupo.nome)='sqlite' and
                        lower(classificacao.nome)='verificado' and
                        post.data= (
                                        select 
                                        post.data
                                        from 
                                            grupo 
                                                join post on post.grupo=grupo.codigo 
                                                join classificacaoPost on post.codigo=classificacaoPost.post
                                                join classificacao on classificacao.cod=classificacaoPost.classificacao
                                        where 
                                        lower(grupo.nome)='sqlite' and
                                        lower(classificacao.nome)='verificado'
                                        order by post.data desc 
                                        limit 1
                                    )
    )
  or  post.codigo in (
                        select 
                        post.codigo
                        from 
                            grupo 
                                join post on post.grupo=grupo.codigo 
                                join classificacaoPost on post.codigo=classificacaoPost.post
                                join classificacao on classificacao.cod=classificacaoPost.classificacao
                        where 
                        lower(grupo.nome)='sqlite' and
                        lower(classificacao.nome)='verificado' and
                        post.data= (
                                        select 
                                        post.data
                                        from 
                                            grupo 
                                                join post on post.grupo=grupo.codigo 
                                                join classificacaoPost on post.codigo=classificacaoPost.post
                                                join classificacao on classificacao.cod=classificacaoPost.classificacao
                                        where 
                                        lower(grupo.nome)='sqlite' and
                                        lower(classificacao.nome)='verificado'
                                        order by post.data desc 
                                        limit 1
                                    )
                )
    
;
--remove classificação
delete 
    from 
    classificacaoPost 
    where 
        classificacaoPost.post not in (select codigo from post)
;

--e) 
/*
Atribuir um selo de fã, com validade determinada para a semana atual, para os usuários do grupo ifrs-campus rio grande que:
    Selo Condições considerando as postagens da semana passada no grupo
    ultra-fã reagiram a 75% ou mais e comentaram 30% ou mais das postagens
    super-fã reagiram a 50% ou mais e comentaram 20% ou mais das postagens
    fã reagiram a 25% ou mais e comentaram 10% ou mais das postagens
O procedimento de atribuir selo de fã será executado automaticamente às 00:00 de cada domingo.
*/

--antes de enviar tem trocar o grupo='sqlite' pra 'ifrs'
--considera-se que apenas selos validos são guardados no banco e 
--vai atualizando conforme a condição,caso o selo expire ele será deletado
insert into seloperfil(perfil,selo,validatation_date,grupo)
select
    tmp.prf,
    case 
        when 
            tmp.porcentagem_reaction>=75.0 and
            tmp2.porcentagem_comment>=30.0
        then (
                select 
                selogrupo.cod 
                from 
                selogrupo,grupo
                where  
                selogrupo.grupo=grupo.codigo 
                and lower(grupo.nome)='sqlite' 
                and selogrupo.nome='ultra-fa'
            )
        when 
            tmp.porcentagem_reaction>=50.0 and
            tmp2.porcentagem_comment>=20.0
        then  (
                select 
                selogrupo.cod 
                from 
                selogrupo,grupo
                where  
                selogrupo.grupo=grupo.codigo 
                and lower(grupo.nome)='sqlite' 
                and selogrupo.nome='super-fa'
            )
        when 
            tmp.porcentagem_reaction>=25.0 and
            tmp2.porcentagem_comment>=10.0
        then  (
                select 
                selogrupo.cod 
                from 
                selogrupo,grupo
                where  
                selogrupo.grupo=grupo.codigo 
                and lower(grupo.nome)='sqlite' 
                and selogrupo.nome='fa'
            )
        else  
            (
                select 
                selogrupo.cod 
                from 
                selogrupo,grupo
                where  
                selogrupo.grupo=grupo.codigo 
                and lower(grupo.nome)='sqlite' 
                and selogrupo.nome='sem selo'
            )
    end as selo,
    (select datetime(date('now','weekday 0'))),
    (select grupo.codigo from grupo where lower(grupo.nome)='sqlite')
 from
        (
            select 
            reaction.perfil as prf,
            (cast(count(*) as real)/
            (
                select 
                count(*)
                from 
                reaction
                where
                reaction.postagem in (
                                        select 
                                        post.codigo 
                                        from 
                                        post 
                                            join grupo on grupo.codigo=post.grupo
                                        where 
                                            lower(grupo.nome)='sqlite' and 
                                            post.postagem is null and
                                            datetime(post.data) between  datetime(date('now','weekday 0','-14 days')) and datetime(date('now','weekday 0','-7 days'))
                                    )
            ))*100 as porcentagem_reaction
            from 
            reaction
            where
            reaction.postagem in (
                                    select 
                                    post.codigo 
                                    from 
                                    post 
                                        join grupo on grupo.codigo=post.grupo
                                    where 
                                        lower(grupo.nome)='sqlite' and 
                                        post.postagem is null and
                                        datetime(post.data) between  datetime(date('now','weekday 0','-14 days')) and datetime(date('now','weekday 0','-7 days'))
                                )
            group by reaction.perfil
            )as tmp
            join  
            (
            select 
            post.perfil as prf,
            (cast (count(*) as real)/
            (
                select 
                count(*)
                from 
                post 
                    join grupo on grupo.codigo=post.grupo
                where 
                lower(grupo.nome)='sqlite' and 
                post.postagem is not null and
                post.postagem in (
                                    select 
                                    post.codigo
                                    from 
                                    post 
                                        join grupo on grupo.codigo=post.grupo
                                    where 
                                    lower(grupo.nome)='sqlite' and 
                                    post.postagem is null and
                                    datetime(post.data) between  datetime(date('now','weekday 0','-14 days')) and datetime(date('now','weekday 0','-7 days'))
                                ) and
                datetime(post.data) between  datetime(date('now','weekday 0','-14 days')) and datetime(date('now','weekday 0','-7 days'))
            ))*100 as porcentagem_comment
            from 
            post 
                join grupo on grupo.codigo=post.grupo
            where 
            lower(grupo.nome)='sqlite' and 
            post.postagem is not null and
            datetime(post.data) between  datetime(date('now','weekday 0','-14 days')) and datetime(date('now','weekday 0','-7 days'))
            group by post.perfil
    ) as tmp2 on tmp.prf=tmp2.prf 
on CONFLICT(perfil,grupo) 
do 
update 
set 
validatation_date=(select datetime(date('now','weekday 0'))),
selo=excluded.selo
where perfil=excluded.perfil
;
delete 
    from 
    seloperfil 
    where 
    selo=(
                select 
                selogrupo.cod 
                from 
                selogrupo,grupo
                where  
                selogrupo.grupo=grupo.codigo 
                and lower(grupo.nome)='sqlite' 
                and selogrupo.nome='sem selo'
            ) 
    or 
    validatation_date < (select datetime(date('now','weekday 0')))
;

/*
2) Descreva e justifique as adequações/alterações que foram realizadas nas tabelas criadas para
uma rede social nas listas de exercícios anteriores para que o exercício 1 acima pudesse ser
resolvido.
*/
/*
Adicionado
    perfil(status)-->adicionado para resolver a letra c)
    reaction(codigo)-->adicionado para resolver a letra b)
    classificacao(nome,cod) adicionado para resolver a letra d)
    classificacaoPost(post,classificacao) adicionado para resolver a letra d)
    selogrupo(codigo,nome,grupo)  --> adicionado para letra e)
    seloperfil(selo,perfil,data,grupo) -->adicionado para letra e)
Removido
    reaction(comentario)-->deveria ter sido removido antes
*/
/*
    3) Explique detalhadamente porque não é possível várias pessoas distintas comprarem o mesmo
    lugar numerado no mesmo show utilizando controle de concorrência.
   
    As pessoas não conseguem comprar o mesmo lugar numerado no mesmo show pois quando utilizado o controle de concorrência, nós temos o controle de quem fez a primeira ação, onde nesse caso é quem abriu aba de compra de ingresso primeiro.
    Sempre que alguem abre a aba de compra ela tem secretamente salva a data da última compra de ingressos, logo quando ela decide comprar nós comparamos se o horário que ela tinha armazenado como última compra é o mesmo de última compra no banco de dados, caso no banco tenha outra data, a compra será cancelada e a pessoa terá que fazer todo processo novamente, assim não teremos risco de 2 pessoas comprarem o mesmo lugar no mesmo tempo.

*/