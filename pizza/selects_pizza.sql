/*3) Utilizando a modelagem da pizzaria do material, escreva comandos select para responder as
perguntas:*/

--a) Qual sabor tem mais ingredientes?
select 
    sabor.nome,
    count(*) as qt_ingrediente
    from 
    sabor
    join saboringrediente on sabor.codigo=saboringrediente.sabor
    join ingrediente on saboringrediente.ingrediente=ingrediente.codigo
    group by sabor
    having qt_ingrediente=(
                select count(*) 
                from 
                sabor
                    join saboringrediente on sabor.codigo=saboringrediente.sabor
                    join ingrediente on saboringrediente.ingrediente=ingrediente.codigo
                group by sabor
                order by count(*) desc
                limit 1
        )
;
--b) Qual sabor tem menos ingredientes?
select 
    sabor.nome,
    count(*) as qt_ingrediente
    from 
    sabor
    join saboringrediente on sabor.codigo=saboringrediente.sabor
    join ingrediente on saboringrediente.ingrediente=ingrediente.codigo
    group by sabor
    having qt_ingrediente=(
                select count(*) 
                from 
                sabor
                    join saboringrediente on sabor.codigo=saboringrediente.sabor
                    join ingrediente on saboringrediente.ingrediente=ingrediente.codigo
                group by sabor
                order by count(*) asc
                limit 1
        )
;

--c) Qual sabor não foi pedido nos últimos 4 domingos?
select 
    sabor.nome 
    from sabor
except
select
    distinct
    sabor.nome
    from 
    comanda 
    join pizza on pizza.comanda=comanda.numero
    join pizzasabor on pizzasabor.pizza=pizza.codigo
    join sabor on sabor.codigo=pizzasabor.sabor
    where (
            date(comanda.data)=date('now','weekday 0','-28 days') or
            date(comanda.data)=date('now','weekday 0','-21 days') or
            date(comanda.data)=date('now','weekday 0','-14 days') or
            date(comanda.data)=date('now','weekday 0','-7 days') 
          ) 
;

--d) Qual mesa foi mais utilizada nos últimos 60 dias?
select 
    mesa.nome
    from mesa
        join comanda on mesa.codigo=comanda.mesa
    where date(comanda.data) between date('now','-60 days') and date('now')
    group by mesa.nome
    having count(*)=(
                        select 
                        count(*)
                        from mesa
                            join comanda on mesa.codigo=comanda.mesa
                        where date(comanda.data) between date('now','-60 days') and date('now')
                        group by mesa.nome
                        order by count(*) desc
                        limit 1
                    )
;
--e) Qual mesa foi menos utilizada nos últimos 60 dias?
select 
    mesa.nome
    from mesa
        join comanda on mesa.codigo=comanda.mesa
        where date(comanda.data) between date('now','-60 days') and date('now')
    group by mesa.nome
    having count(*)=(
                        select 
                        count(*)
                        from mesa
                            join comanda on mesa.codigo=comanda.mesa
                            where date(comanda.data) between date('now','-60 days') and date('now')
                        group by mesa.nome
                        order by count(*) asc
                        limit 1
                    )
;

--f) Quais mesas foram utilizadas mais de 2 vezes a média de utilização de todas as mesas nos últimos 60 dias?
--media=sum(quantas vezes cada mesa foi usada)/count(numero de mesas)
-- select cast(23+30+30+22+30+25+34+35+21+35+37+32+30+28+28 as real)/15.0 
select 
    mesa.nome,
    count(*)
    from comanda
    join mesa on comanda.mesa=mesa.codigo
    where date(comanda.data) between date('now','-60 days') and date('now')
    group by mesa.codigo
    having count(*)>cast(2.0*(select 
                            cast(sum(qt_total.qt) as real)/cast((select count(*) from mesa) as real) as media
                            from 
                            (  select
                                        count(*) as qt
                                        from 
                                            comanda
                                            join mesa on comanda.mesa=mesa.codigo
                                            where date(comanda.data) between date('now','-60 days') and date('now')
                                        group by mesa.codigo
                                        order by qt
                            ) as qt_total
                            ) as integer
                        )
;
--g) Quais sabores estão entre os 10 mais pedidos no último mês e também no penúltimo mês?

select 
    sabor.nome
    from 
    comanda
        join pizza on pizza.comanda=comanda.numero
        join pizzasabor on pizza.codigo=pizzasabor.pizza
        join sabor on sabor.codigo=pizzasabor.sabor
    where date(comanda.data) between date('now','start of month') and  date('now','start of month','+1 months','-1 days')
    group by sabor.codigo
    having count(*) in (
                            select 
                                distinct
                                    count(*) as qt2
                                from 
                                comanda
                                    join pizza on pizza.comanda=comanda.numero
                                    join pizzasabor on pizza.codigo=pizzasabor.pizza
                                    join sabor on sabor.codigo=pizzasabor.sabor
                                where date(comanda.data) between date('now','start of month') and  date('now','start of month','+1 months','-1 days')
                                group by sabor.codigo
                                order by qt2 desc
                                limit 10
                            )
intersect
select 
    sabor.nome
    from 
    comanda
        join pizza on pizza.comanda=comanda.numero
        join pizzasabor on pizza.codigo=pizzasabor.pizza
        join sabor on sabor.codigo=pizzasabor.sabor
    where date(comanda.data) between date('now','start of month','-1 months') and  date('now','start of month','-1 days')        
    group by sabor.codigo       
    having count(*) in (
                            select 
                                distinct
                                    count(*) as qt4
                                from 
                                comanda
                                    join pizza on pizza.comanda=comanda.numero
                                    join pizzasabor on pizza.codigo=pizzasabor.pizza
                                    join sabor on sabor.codigo=pizzasabor.sabor
                                where date(comanda.data) between date('now','start of month','-1 months') and  date('now','start of month','-1 days')
                                group by sabor.codigo
                                order by qt4 desc
                                limit 10
                            )
;

--h) Quais sabores estão entre os 10 mais pedidos no último mês mas não no penúltimo mês?
select 
    sabor.nome
    from 
    comanda
        join pizza on pizza.comanda=comanda.numero
        join pizzasabor on pizza.codigo=pizzasabor.pizza
        join sabor on sabor.codigo=pizzasabor.sabor
    where date(comanda.data) between date('now','start of month') and  date('now','start of month','+1 months','-1 days')
    group by sabor.codigo
    having count(*) in (
                            select 
                                distinct
                                    count(*) as qt2
                                from 
                                comanda
                                    join pizza on pizza.comanda=comanda.numero
                                    join pizzasabor on pizza.codigo=pizzasabor.pizza
                                    join sabor on sabor.codigo=pizzasabor.sabor
                                where date(comanda.data) between date('now','start of month') and  date('now','start of month','+1 months','-1 days')
                                group by sabor.codigo
                                order by qt2 desc
                                limit 10
                            )
except
select 
    sabor.nome
    from 
    comanda
        join pizza on pizza.comanda=comanda.numero
        join pizzasabor on pizza.codigo=pizzasabor.pizza
        join sabor on sabor.codigo=pizzasabor.sabor
    where date(comanda.data) between date('now','start of month','-1 months') and  date('now','start of month','-1 days')        
    group by sabor.codigo       
    having count(*) in (
                            select 
                                distinct
                                    count(*) as qt4
                                from 
                                comanda
                                    join pizza on pizza.comanda=comanda.numero
                                    join pizzasabor on pizza.codigo=pizzasabor.pizza
                                    join sabor on sabor.codigo=pizzasabor.sabor
                                where date(comanda.data) between date('now','start of month','-1 months') and  date('now','start of month','-1 days')
                                group by sabor.codigo
                                order by qt4 desc
                                limit 10
                            )
;

--i) Quais sabores não foram pedidos nos últimos 3 meses?
select 
    sabor.nome 
    from sabor 
    where  sabor.nome not in
                            (
                                select 
                                    distinct
                                    sabor.nome
                                    from 
                                    comanda
                                        join pizza on pizza.comanda=comanda.numero
                                        join pizzasabor on pizza.codigo=pizzasabor.pizza
                                        join sabor on sabor.codigo=pizzasabor.sabor
                                    where date(comanda.data) between date('now','start of month','-2 months') and date('now','start of month','+1 month','-1 days')
                            )
;                       
--j) Quais foram os 3 sabores mais pedidos na última estação do ano?

--Outono : De 21 de março a 21 de junho.
--Inverno: De 22 de junho a 23 de setembro.
--Primavera: De 24 de setembro a 21 de dezembro.
--Verão: De 22 de dezembro a 20 de março.
--arrumar j) e k)
--pegar estação retrasada:outono
--esta pegando a atual inverno
    select
        sabor.nome,count(*)
        from 
        comanda
            join pizza on pizza.comanda=comanda.numero
            join pizzasabor on pizzasabor.pizza=pizza.codigo
            join sabor on pizzasabor.sabor=sabor.codigo
        where             
                --inverno
                (
                    strftime('2020-%m-%d',comanda.data) between date('2020-06-22') and date('2020-09-23') and
                    strftime('%Y',comanda.data)=strftime('%Y','now') and
                    strftime('2020-%m-%d','now') between date('2020-06-22') and date('2020-09-23')
                )
                or
                --outuno
                (                   
                    strftime('2020-%m-%d',comanda.data) between date('2020-03-21') and date('2020-06-21') and
                    strftime('%Y',comanda.data)=strftime('%Y','now') and
                    strftime('2020-%m-%d','now') between date('2020-03-21') and date('2020-06-21')
                )
                or 
                --primavera
                (                   
                    strftime('2020-%m-%d',comanda.data) between date('2020-09-24') and date('2020-12-21') and
                    strftime('%Y',comanda.data)=strftime('%Y','now') and
                    strftime('2020-%m-%d','now') between date('2020-09-24') and date('2020-12-21')
                )
                or
                --verão
                (
                            (
                                strftime('2020-%m-%d',comanda.data) between date('2020-12-22') and date('2020-12-31') and
                                strftime('%Y',comanda.data)=strftime('%Y','now','-1 years') 
                                or
                                strftime('2021-%m-%d',comanda.data) between date('2021-01-01') and date('2021-03-20') and
                                strftime('%Y',comanda.data)=strftime('%Y','now') 
                            )
                            and
                            (
                                strftime('2020-%m-%d','now') between date('2020-12-22') and date('2020-12-31')
                                or 
                                strftime('2021-%m-%d','now') between date('2021-01-01') and date('2021-03-20')
                            )
                )
        group by sabor.nome
        having count(*) in (
                            select
                                distinct
                                count(*) as qt2      
                                from 
                                comanda
                                    join pizza on pizza.comanda=comanda.numero
                                    join pizzasabor on pizzasabor.pizza=pizza.codigo
                                    join sabor on pizzasabor.sabor=sabor.codigo
                                where             
                                    --inverno
                                    (
                                        strftime('2020-%m-%d',comanda.data) between date('2020-06-22') and date('2020-09-23') and
                                        strftime('%Y',comanda.data)=strftime('%Y','now') and
                                        strftime('2020-%m-%d','now') between date('2020-06-22') and date('2020-09-23')
                                    )
                                    or
                                    --outuno
                                    (                   
                                        strftime('2020-%m-%d',comanda.data) between date('2020-03-21') and date('2020-06-21') and
                                        strftime('%Y',comanda.data)=strftime('%Y','now') and
                                        strftime('2020-%m-%d','now') between date('2020-03-21') and date('2020-06-21')
                                    )
                                    or 
                                    --primavera
                                    (                   
                                        strftime('2020-%m-%d',comanda.data) between date('2020-09-24') and date('2020-12-21') and
                                        strftime('%Y',comanda.data)=strftime('%Y','now') and
                                        strftime('2020-%m-%d','now') between date('2020-09-24') and date('2020-12-21')
                                    )
                                    or
                                    --verão
                                    (
                                        (
                                            strftime('2020-%m-%d',comanda.data) between date('2020-12-22') and date('2020-12-31') and
                                            strftime('%Y',comanda.data)=strftime('%Y','now','-1 years') 
                                            or
                                            strftime('2021-%m-%d',comanda.data) between date('2021-01-01') and date('2021-03-20') and
                                            strftime('%Y',comanda.data)=strftime('%Y','now') 
                                        )
                                        and
                                        (
                                            strftime('2020-%m-%d','now') between date('2020-12-22') and date('2020-12-31')
                                            or 
                                            strftime('2021-%m-%d','now') between date('2021-01-01') and date('2021-03-20')
                                        )
                                    )
                                group by sabor.nome
                                order by qt2 desc
                                limit 3
                            )
        order by count(*) desc
    ;
    --k) Quais foram os 5 ingredientes mais pedidos na última estação do ano?
    select
        ingrediente.nome,count(*)
        from 
        comanda
            join pizza on pizza.comanda=comanda.numero
            join pizzasabor on pizzasabor.pizza=pizza.codigo
            join sabor on pizzasabor.sabor=sabor.codigo
            join saboringrediente on saboringrediente.sabor=sabor.codigo
            join ingrediente on saboringrediente.ingrediente=ingrediente.codigo
        where                                        
            --inverno
            (
                strftime('2020-%m-%d',comanda.data) between date('2020-06-22') and date('2020-09-23') and
                strftime('%Y',comanda.data)=strftime('%Y','now') and
                strftime('2020-%m-%d','now') between date('2020-06-22') and date('2020-09-23')
            )
            or
            --outuno
            (                   
                strftime('2020-%m-%d',comanda.data) between date('2020-03-21') and date('2020-06-21') and
                strftime('%Y',comanda.data)=strftime('%Y','now') and
                strftime('2020-%m-%d','now') between date('2020-03-21') and date('2020-06-21')
            )
            or 
            --primavera
            (                   
                strftime('2020-%m-%d',comanda.data) between date('2020-09-24') and date('2020-12-21') and
                strftime('%Y',comanda.data)=strftime('%Y','now') and
                strftime('2020-%m-%d','now') between date('2020-09-24') and date('2020-12-21')
            )
            or
            --verão
            (
                (
                    strftime('2020-%m-%d',comanda.data) between date('2020-12-22') and date('2020-12-31') and
                    strftime('%Y',comanda.data)=strftime('%Y','now','-1 years') 
                    or
                    strftime('2021-%m-%d',comanda.data) between date('2021-01-01') and date('2021-03-20') and
                    strftime('%Y',comanda.data)=strftime('%Y','now') 
                )
                and
                (
                    strftime('2020-%m-%d','now') between date('2020-12-22') and date('2020-12-31')
                    or 
                    strftime('2021-%m-%d','now') between date('2021-01-01') and date('2021-03-20')
                )
            )
        group by ingrediente.nome
        having count(*) in (
                        select
                            distinct
                            count(*) as qt     
                            from 
                            comanda
                                join pizza on pizza.comanda=comanda.numero
                                join pizzasabor on pizzasabor.pizza=pizza.codigo
                                join sabor on pizzasabor.sabor=sabor.codigo
                                join saboringrediente on saboringrediente.sabor=sabor.codigo
                                join ingrediente on saboringrediente.ingrediente=ingrediente.codigo
                            where                                        
                                --inverno
                                (
                                    strftime('2020-%m-%d',comanda.data) between date('2020-06-22') and date('2020-09-23') and
                                    strftime('%Y',comanda.data)=strftime('%Y','now') and
                                    strftime('2020-%m-%d','now') between date('2020-06-22') and date('2020-09-23')
                                )
                                or
                                --outuno
                                (                   
                                    strftime('2020-%m-%d',comanda.data) between date('2020-03-21') and date('2020-06-21') and
                                    strftime('%Y',comanda.data)=strftime('%Y','now') and
                                    strftime('2020-%m-%d','now') between date('2020-03-21') and date('2020-06-21')
                                )
                                or 
                                --primavera
                                (                   
                                    strftime('2020-%m-%d',comanda.data) between date('2020-09-24') and date('2020-12-21') and
                                    strftime('%Y',comanda.data)=strftime('%Y','now') and
                                    strftime('2020-%m-%d','now') between date('2020-09-24') and date('2020-12-21')
                                )
                                or
                                --verão
                                (
                                    (
                                        strftime('2020-%m-%d',comanda.data) between date('2020-12-22') and date('2020-12-31') and
                                        strftime('%Y',comanda.data)=strftime('%Y','now','-1 years') 
                                        or
                                        strftime('2021-%m-%d',comanda.data) between date('2021-01-01') and date('2021-03-20') and
                                        strftime('%Y',comanda.data)=strftime('%Y','now') 
                                    )
                                    and
                                    (
                                        strftime('2020-%m-%d','now') between date('2020-12-22') and date('2020-12-31')
                                        or 
                                        strftime('2021-%m-%d','now') between date('2021-01-01') and date('2021-03-20')
                                    )
                                )
                            group by ingrediente.nome
                            order by qt desc
                            limit 5
                    )
        order by count(*) desc
    ;                          
--l) Qual é o percentual atingido de arrecadação com venda de pizzas no ano atual em comparação com o total arrecadado no ano passado?
--100 000 ano passado
--50 000 ano atual
--(50000/100000)*100 percentual=50%
select 
        (
        select 
            sum(comanda_preco_anoatual.preco) as arrecadacao_anual 
        from (
                select 
                max(
                    case 
                        when borda.preco is null then 0
                        else borda.preco
                        end+precoportamanho.preco) as preco
                from 
                comanda 
                    join pizza on pizza.comanda=comanda.numero
                    join pizzasabor on pizza.codigo=pizzasabor.pizza
                    join sabor on pizzasabor.sabor=sabor.codigo
                    join precoportamanho on pizza.tamanho=precoportamanho.tamanho and sabor.tipo=precoportamanho.tipo
                    left join borda on pizza.borda=borda.codigo
                where strftime('%Y',comanda.data)=strftime('%Y','now')
                group by pizza.codigo
             ) as comanda_preco_anoatual)/(
             select 
                sum(comanda_preco_passado.preco) as arrecadacao_passado
                from (
                        select 
                            max(
                                case 
                                    when borda.preco is null then 0
                                    else borda.preco
                                    end+precoportamanho.preco) as preco
                                from 
                                comanda 
                                    join pizza on pizza.comanda=comanda.numero
                                    join pizzasabor on pizza.codigo=pizzasabor.pizza
                                    join sabor on pizzasabor.sabor=sabor.codigo
                                    join precoportamanho on pizza.tamanho=precoportamanho.tamanho and sabor.tipo=precoportamanho.tipo
                                    left join borda on pizza.borda=borda.codigo
                                where strftime('%Y',comanda.data)=strftime('%Y','now','-1 years')
                                group by pizza.codigo
                    ) as comanda_preco_passado)*100.0 as percentual
;
--m) Qual dia da semana teve maior arrecadação em pizzas nos últimos 60 dias?           
select 
    case 
        when strftime('%w',data_preco.data)='0' then 'domingo'
        when strftime('%w',data_preco.data)='1' then 'segunda'
        when strftime('%w',data_preco.data)='2' then 'terca'
        when strftime('%w',data_preco.data)='3' then 'quarta'
        when strftime('%w',data_preco.data)='4' then 'quinta'
        when strftime('%w',data_preco.data)='5' then 'sexta'
        when strftime('%w',data_preco.data)='6' then 'sabado'
    end as dia_semana,
    sum(data_preco.preco) as total
 from (
        select 
            comanda.data as data,
             max(
                 case 
                 when borda.preco is null then 0
                 else borda.preco
                 end+precoportamanho.preco) as preco
            from 
                comanda 
                    join pizza on pizza.comanda=comanda.numero
                    join pizzasabor on pizza.codigo=pizzasabor.pizza
                    join sabor on pizzasabor.sabor=sabor.codigo
                    join precoportamanho on pizza.tamanho=precoportamanho.tamanho and sabor.tipo=precoportamanho.tipo
                    left join borda on pizza.borda=borda.codigo
            where date(comanda.data) between date('now','-60 days') and date('now')
            group by pizza.codigo
     ) as data_preco
 group by strftime('%w',data_preco.data)
            having total=(        
                            select sum(data_preco.preco) as total2
                            from (
                                select 
                                    comanda.data as data,
                                    max(
                                        case 
                                        when borda.preco is null then 0
                                        else borda.preco
                                        end+precoportamanho.preco) as preco
                                from 
                                comanda 
                                    join pizza on pizza.comanda=comanda.numero
                                    join pizzasabor on pizza.codigo=pizzasabor.pizza
                                    join sabor on pizzasabor.sabor=sabor.codigo
                                    join precoportamanho on pizza.tamanho=precoportamanho.tamanho and sabor.tipo=precoportamanho.tipo
                                    left join borda on pizza.borda=borda.codigo
                                where date(comanda.data) between date('now','-60 days') and date('now')
                                group by pizza.codigo
                                ) as data_preco
                            group by strftime('%w',data_preco.data)
                            order by total2 desc
                            limit 1
                         )
;

--n) Qual a combinação de 2 sabores mais pedida na mesma pizza nos últimos 3 meses?

--o) Qual a combinação de 3 sabores mais pedida na mesma pizza nos últimos 3 meses?

--p) Qual a combinação de sabor e borda mais pedida na mesma pizza nos últimos 3 meses?