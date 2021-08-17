--1) Escreva comandos insert, update ou delete, utilizando as tabelas criadas para uma rede social nas listas de exercícios anteriores, para:

--a) Alterar o texto da última postagem do usuário Edson Arantes do Nascimento, e-mail
--pele@cbf.com.br, de "Brasil: 20 medalhas nas Olimpíadas 2020/2021 em Tóquio" para "Brasil: 21
--medalhas nas Olimpíadas 2020/2021 em Tóquio".
UPDATE post set texto= 'Brasil: 21 medalhas nas Olimpíadas 2020/2021 em Tóquio' where texto = 'Brasil: 20 medalhas nas Olimpíadas 2020/2021 em Tóquio'

--b) Alterar a última reação do usuário Paulo Xavier Ramos, e-mail pxramos@mymail.com, à uma
--postagem no grupo SQLite de para .
--altera 3(8,5,25) pois elas tem a mesma data
update 
    reaction 
    set texto ='amei' 
    from 
    (
        select 
            reaction.*
        from grupo 
            join post on post.grupo=grupo.codigo
            join reaction on post.codigo=reaction.postagem
        where 
            lower(grupo.nome)='sqlite' and
            reaction.texto='gostei' and
            reaction.perfil='pxramos@mymail.com' and
            reaction.data = (

                                select 
                                reaction.data as ult_data 
                                from grupo 
                                join post on post.grupo=grupo.codigo
                                join reaction on post.codigo=reaction.postagem
                                where 
                                lower(grupo.nome)='sqlite' and
                                reaction.texto='gostei' and
                                reaction.perfil='pxramos@mymail.com'
                                order by reaction.data desc
                                limit 1
                            )
    )
;
--c) Desativar temporariamente as contas dos usuários do Brasil que não possuem qualquer atividade
--na rede social há mais de 5 anos.
UPDATE status set status = 'desativado' from post, reaction, compartilhamento where perfil.email = post.perfil or perfil.email = reaction.perfil or perfil.email = compartilhamento.perfil
--d) Excluir a última postagem no grupo IFRS-Campus Rio Grande, classificada como postagem que incita ódio.
--testado com o grupo sqlite
-- com a classificação 'verificado'
delete  
    from 
    post 
    where 
    post.codigo in (
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
--e) Atribuir um selo de fã, com validade determinada para a semana atual, para os usuários do grupo IFRS-Campus Rio Grande que:
/*
Selo Condições considerando as postagens da semana passada no grupo
ultra-fã reagiram a 75% ou mais e comentaram 30% ou mais das postagens
super-fã reagiram a 50% ou mais e comentaram 20% ou mais das postagens
fã reagiram a 25% ou mais e comentaram 10% ou mais das postagens
* O procedimento de atribuir selo de fã será executado automaticamente às 00:00 de cada domingo.
*/

/*
2) Descreva e justifique as adequações/alterações que foram realizadas nas tabelas criadas para
uma rede social nas listas de exercícios anteriores para que o exercício 1 acima pudesse ser
resolvido.
*/

/*
    3) Explique detalhadamente porque não é possível várias pessoas distintas comprarem o mesmo
    lugar numerado no mesmo show utilizando controle de concorrência.
*/