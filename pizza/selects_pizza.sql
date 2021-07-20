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
        where date(comanda.data)=date('now','-60 days')
    group by mesa.nome
    having count(*)=(
                        select 
                        count(*)
                        from mesa
                            join comanda on mesa.codigo=comanda.mesa
                            where date(comanda.data)=date('now','-60 days')
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
        where date(comanda.data)=date('now','-60 days')
    group by mesa.nome
    having count(*)=(
                        select 
                        count(*)
                        from mesa
                            join comanda on mesa.codigo=comanda.mesa
                            where date(comanda.data)=date('now','-60 days')
                        group by mesa.nome
                        order by count(*) asc
                        limit 1
                    )
;

--f) Quais mesas foram utilizadas mais de 2 vezes a média de utilização de todas as mesas nos últimos 60 dias?

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
--acho que tá certo
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

--l) Qual é o percentual atingido de arrecadação com venda de pizzas no ano atual em comparação com o total arrecadado no ano passado?

--m) Qual dia da semana teve maior arrecadação em pizzas nos últimos 60 dias?


--n) Qual a combinação de 2 sabores mais pedida na mesma pizza nos últimos 3 meses?

--o) Qual a combinação de 3 sabores mais pedida na mesma pizza nos últimos 3 meses?

--p) Qual a combinação de sabor e borda mais pedida na mesma pizza nos últimos 3 meses?