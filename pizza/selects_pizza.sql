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

/*
    Solscticio=data do ano em que temos que o dia>noite
    Equinocio=data do ano onde dia=noite

    
    2020-                       
        Solcsticio de Dezembro      21/12/2020 10:52
    2021                                           
        Equinocio de Março          20/03/2021 09:37
        Solcsticio de junho         21/05/2021 03:32
        Equinocio de setembro       22/09/2021  19:21
        Solcstico de dezembro       21/12/2021  15:59
    2022
        Equinocio de Março          20/03/2022 15:53
       
    Estações              começa                            termina
        Outono       Equinocio de março         -->  solcsticio de junho
        Inverno      Solcsticio de junho        -->  equnocio de setembro
        Primavera    Equinocio de setembro      -->  solscticio de dezembro
        Verão        solcsticio de dezembro do outro ano    -->  equinocio de março 

*/
--*não consegui aplicar a fórmula para calcular o solcsticio e o equinocio por ano
--
--j) Quais foram os 3 sabores mais pedidos na última estação do ano?
select 
    datas.station,sabor.nome,count(*)
    from
    (
        select 
        DISTINCT
        comanda.data as data,
        case 
            when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-03-20 09:37:01') and strftime('%m-%d %H:%M:%S','2021-05-21 03:32') then 'outono'
            when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-05-21 03:32:01') and strftime('%m-%d %H:%M:%S','2021-09-22 19:21') then 'inverno'
            when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-09-22 19:21:01') and strftime('%m-%d %H:%M:%S','2021-12-21 15:59') then 'primavera'
            --verao solcsticio de dezembro - final do ano
            when 
                strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-12-21 15:59:01') and strftime('%m-%d %H:%M:%S','2020-12-31') 
                or 
                strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-01-01') and strftime('%m-%d %H:%M:%S','2021-03-20 09:37')
                then 'verao'
            else 'verao' -- 2021-01-01 return null,por algum motivo
        end as station
        from 
        comanda
        where
            strftime('%Y',comanda.data)=strftime('%Y','now')
            and station = (
                                select 
                                distinct
                                case 
                                    when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-03-20 09:37:01') and strftime('%m-%d %H:%M:%S','2021-05-21 03:32') then 'outono'
                                    when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-05-21 03:32:01') and strftime('%m-%d %H:%M:%S','2021-09-22 19:21') then 'inverno'
                                    when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-09-22 19:21:01') and strftime('%m-%d %H:%M:%S','2021-12-21 15:59') then 'primavera'
                                    --verao solcsticio de dezembro - final do ano
                                    when 
                                        strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-12-21 15:59:01') and strftime('%m-%d %H:%M:%S','2020-12-31') 
                                        or 
                                        strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-01-01') and strftime('%m-%d %H:%M:%S','2021-03-20 09:37')
                                        then 'verao'
                                    else 'verao' -- 2021-01-01 return null,por algum motivo
                                end as station
                                from 
                                comanda
                                where 
                                    strftime('%Y',comanda.data)=strftime('%Y','now')
                                    and station != (
                                                        select 
                                                            distinct
                                                            case 
                                                                when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-03-20 09:37:01') and strftime('%m-%d %H:%M:%S','2021-05-21 03:32') then 'outono'
                                                                when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-05-21 03:32:01') and strftime('%m-%d %H:%M:%S','2021-09-22 19:21') then 'inverno'
                                                                when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-09-22 19:21:01') and strftime('%m-%d %H:%M:%S','2021-12-21 15:59') then 'primavera'
                                                                --verao solcsticio de dezembro - final do ano
                                                                when 
                                                                    strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-12-21 15:59:01') and strftime('%m-%d %H:%M:%S','2020-12-31') 
                                                                    or 
                                                                    strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-01-01') and strftime('%m-%d %H:%M:%S','2021-03-20 09:37')
                                                                    then 'verao'
                                                                else 'verao'-- 2021-01-01 return null,por algum motivo
                                                            end as station
                                                            from 
                                                            comanda
                                                            where 
                                                                strftime('%Y',comanda.data)=strftime('%Y','now')
                                                            order by comanda.data desc 
                                                            limit  1
                                                    )
                                order by comanda.data desc 
                                limit  1
                            )

    ) as datas
        join comanda on comanda.data=datas.data
        join pizza on pizza.comanda=comanda.numero
        join pizzasabor on pizzasabor.pizza=pizza.codigo
        join sabor on sabor.codigo=pizzasabor.sabor
    group by sabor.codigo
    having count(*) in (
                        select 
                        distinct
                        count(*)
                        from
                            (
                                select 
                                DISTINCT
                                comanda.data as data,
                                case 
                                    when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-03-20 09:37:01') and strftime('%m-%d %H:%M:%S','2021-05-21 03:32') then 'outono'
                                    when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-05-21 03:32:01') and strftime('%m-%d %H:%M:%S','2021-09-22 19:21') then 'inverno'
                                    when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-09-22 19:21:01') and strftime('%m-%d %H:%M:%S','2021-12-21 15:59') then 'primavera'
                                    --verao solcsticio de dezembro - final do ano
                                    when 
                                        strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-12-21 15:59:01') and strftime('%m-%d %H:%M:%S','2020-12-31') 
                                        or 
                                        strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-01-01') and strftime('%m-%d %H:%M:%S','2021-03-20 09:37')
                                        then 'verao'
                                    else 'verao' -- 2021-01-01 return null,por algum motivo
                                end as station
                                from 
                                comanda
                                where
                                    strftime('%Y',comanda.data)=strftime('%Y','now')
                                    and station = (
                                                        select 
                                                        distinct
                                                        case 
                                                            when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-03-20 09:37:01') and strftime('%m-%d %H:%M:%S','2021-05-21 03:32') then 'outono'
                                                            when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-05-21 03:32:01') and strftime('%m-%d %H:%M:%S','2021-09-22 19:21') then 'inverno'
                                                            when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-09-22 19:21:01') and strftime('%m-%d %H:%M:%S','2021-12-21 15:59') then 'primavera'
                                                            --verao solcsticio de dezembro - final do ano
                                                            when 
                                                                strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-12-21 15:59:01') and strftime('%m-%d %H:%M:%S','2020-12-31') 
                                                                or 
                                                                strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-01-01') and strftime('%m-%d %H:%M:%S','2021-03-20 09:37')
                                                                then 'verao'
                                                            else 'verao' -- 2021-01-01 return null,por algum motivo
                                                        end as station
                                                        from 
                                                        comanda
                                                        where 
                                                            strftime('%Y',comanda.data)=strftime('%Y','now')
                                                            and station != (
                                                                                select 
                                                                                    distinct
                                                                                    case 
                                                                                        when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-03-20 09:37:01') and strftime('%m-%d %H:%M:%S','2021-05-21 03:32') then 'outono'
                                                                                        when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-05-21 03:32:01') and strftime('%m-%d %H:%M:%S','2021-09-22 19:21') then 'inverno'
                                                                                        when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-09-22 19:21:01') and strftime('%m-%d %H:%M:%S','2021-12-21 15:59') then 'primavera'
                                                                                        --verao solcsticio de dezembro - final do ano
                                                                                        when 
                                                                                            strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-12-21 15:59:01') and strftime('%m-%d %H:%M:%S','2020-12-31') 
                                                                                            or 
                                                                                            strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-01-01') and strftime('%m-%d %H:%M:%S','2021-03-20 09:37')
                                                                                            then 'verao'
                                                                                        else 'verao'-- 2021-01-01 return null,por algum motivo
                                                                                    end as station
                                                                                    from 
                                                                                    comanda
                                                                                    where 
                                                                                        strftime('%Y',comanda.data)=strftime('%Y','now')
                                                                                    order by comanda.data desc 
                                                                                    limit  1
                                                                            )
                                                        order by comanda.data desc 
                                                        limit  1
                                                    )

                            ) as datas
                            join comanda on comanda.data=datas.data
                            join pizza on pizza.comanda=comanda.numero
                            join pizzasabor on pizzasabor.pizza=pizza.codigo
                            join sabor on sabor.codigo=pizzasabor.sabor
                        group by sabor.codigo
                        order by count(*) desc
                        limit 3
                    )
    order by count(*) desc
;
--k) Quais foram os 5 ingredientes mais pedidos na última estação do ano?
select 
    datas.station,ingrediente.nome,count(*)
    from
    (
        select 
        DISTINCT
        comanda.data as data,
        case 
            when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-03-20 09:37:01') and strftime('%m-%d %H:%M:%S','2021-05-21 03:32') then 'outono'
            when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-05-21 03:32:01') and strftime('%m-%d %H:%M:%S','2021-09-22 19:21') then 'inverno'
            when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-09-22 19:21:01') and strftime('%m-%d %H:%M:%S','2021-12-21 15:59') then 'primavera'
            --verao solcsticio de dezembro - final do ano
            when 
                strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-12-21 15:59:01') and strftime('%m-%d %H:%M:%S','2020-12-31') 
                or 
                strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-01-01') and strftime('%m-%d %H:%M:%S','2021-03-20 09:37')
                then 'verao'
            else 'verao' -- 2021-01-01 return null,por algum motivo
        end as station
        from 
        comanda
        where
            strftime('%Y',comanda.data)=strftime('%Y','now')
            and station = (
                                select 
                                distinct
                                case 
                                    when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-03-20 09:37:01') and strftime('%m-%d %H:%M:%S','2021-05-21 03:32') then 'outono'
                                    when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-05-21 03:32:01') and strftime('%m-%d %H:%M:%S','2021-09-22 19:21') then 'inverno'
                                    when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-09-22 19:21:01') and strftime('%m-%d %H:%M:%S','2021-12-21 15:59') then 'primavera'
                                    --verao solcsticio de dezembro - final do ano
                                    when 
                                        strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-12-21 15:59:01') and strftime('%m-%d %H:%M:%S','2020-12-31') 
                                        or 
                                        strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-01-01') and strftime('%m-%d %H:%M:%S','2021-03-20 09:37')
                                        then 'verao'
                                    else 'verao' -- 2021-01-01 return null,por algum motivo
                                end as station
                                from 
                                comanda
                                where 
                                    strftime('%Y',comanda.data)=strftime('%Y','now')
                                    and station != (
                                                        select 
                                                            distinct
                                                            case 
                                                                when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-03-20 09:37:01') and strftime('%m-%d %H:%M:%S','2021-05-21 03:32') then 'outono'
                                                                when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-05-21 03:32:01') and strftime('%m-%d %H:%M:%S','2021-09-22 19:21') then 'inverno'
                                                                when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-09-22 19:21:01') and strftime('%m-%d %H:%M:%S','2021-12-21 15:59') then 'primavera'
                                                                --verao solcsticio de dezembro - final do ano
                                                                when 
                                                                    strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-12-21 15:59:01') and strftime('%m-%d %H:%M:%S','2020-12-31') 
                                                                    or 
                                                                    strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-01-01') and strftime('%m-%d %H:%M:%S','2021-03-20 09:37')
                                                                    then 'verao'
                                                                else 'verao'-- 2021-01-01 return null,por algum motivo
                                                            end as station
                                                            from 
                                                            comanda
                                                            where 
                                                                strftime('%Y',comanda.data)=strftime('%Y','now')
                                                            order by comanda.data desc 
                                                            limit  1
                                                    )
                                order by comanda.data desc 
                                limit  1
                            )

    ) as datas
        join comanda on comanda.data=datas.data
        join pizza on pizza.comanda=comanda.numero
        join pizzasabor on pizzasabor.pizza=pizza.codigo
        join sabor on sabor.codigo=pizzasabor.sabor
        join saboringrediente on saboringrediente.sabor=sabor.codigo
        join ingrediente on ingrediente.codigo=saboringrediente.ingrediente
    group by ingrediente.codigo
    having count(*) in (
                            select 
                            distinct
                            count(*)
                            from
                            (
                                select 
                                DISTINCT
                                comanda.data as data,
                                case 
                                    when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-03-20 09:37:01') and strftime('%m-%d %H:%M:%S','2021-05-21 03:32') then 'outono'
                                    when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-05-21 03:32:01') and strftime('%m-%d %H:%M:%S','2021-09-22 19:21') then 'inverno'
                                    when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-09-22 19:21:01') and strftime('%m-%d %H:%M:%S','2021-12-21 15:59') then 'primavera'
                                    --verao solcsticio de dezembro - final do ano
                                    when 
                                        strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-12-21 15:59:01') and strftime('%m-%d %H:%M:%S','2020-12-31') 
                                        or 
                                        strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-01-01') and strftime('%m-%d %H:%M:%S','2021-03-20 09:37')
                                        then 'verao'
                                    else 'verao' -- 2021-01-01 return null,por algum motivo
                                end as station
                                from 
                                comanda
                                where
                                    strftime('%Y',comanda.data)=strftime('%Y','now')
                                    and station = (
                                                        select 
                                                        distinct
                                                        case 
                                                            when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-03-20 09:37:01') and strftime('%m-%d %H:%M:%S','2021-05-21 03:32') then 'outono'
                                                            when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-05-21 03:32:01') and strftime('%m-%d %H:%M:%S','2021-09-22 19:21') then 'inverno'
                                                            when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-09-22 19:21:01') and strftime('%m-%d %H:%M:%S','2021-12-21 15:59') then 'primavera'
                                                            --verao solcsticio de dezembro - final do ano
                                                            when 
                                                                strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-12-21 15:59:01') and strftime('%m-%d %H:%M:%S','2020-12-31') 
                                                                or 
                                                                strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-01-01') and strftime('%m-%d %H:%M:%S','2021-03-20 09:37')
                                                                then 'verao'
                                                            else 'verao' -- 2021-01-01 return null,por algum motivo
                                                        end as station
                                                        from 
                                                        comanda
                                                        where 
                                                            strftime('%Y',comanda.data)=strftime('%Y','now')
                                                            and station != (
                                                                                select 
                                                                                    distinct
                                                                                    case 
                                                                                        when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-03-20 09:37:01') and strftime('%m-%d %H:%M:%S','2021-05-21 03:32') then 'outono'
                                                                                        when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-05-21 03:32:01') and strftime('%m-%d %H:%M:%S','2021-09-22 19:21') then 'inverno'
                                                                                        when strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2021-09-22 19:21:01') and strftime('%m-%d %H:%M:%S','2021-12-21 15:59') then 'primavera'
                                                                                        --verao solcsticio de dezembro - final do ano
                                                                                        when 
                                                                                            strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-12-21 15:59:01') and strftime('%m-%d %H:%M:%S','2020-12-31') 
                                                                                            or 
                                                                                            strftime('%m-%d',comanda.data) between strftime('%m-%d %H:%M:%S','2020-01-01') and strftime('%m-%d %H:%M:%S','2021-03-20 09:37')
                                                                                            then 'verao'
                                                                                        else 'verao'-- 2021-01-01 return null,por algum motivo
                                                                                    end as station
                                                                                    from 
                                                                                    comanda
                                                                                    where 
                                                                                        strftime('%Y',comanda.data)=strftime('%Y','now')
                                                                                    order by comanda.data desc 
                                                                                    limit  1
                                                                            )
                                                        order by comanda.data desc 
                                                        limit  1
                                                    )

                            ) as datas
                                join comanda on comanda.data=datas.data
                                join pizza on pizza.comanda=comanda.numero
                                join pizzasabor on pizzasabor.pizza=pizza.codigo
                                join sabor on sabor.codigo=pizzasabor.sabor
                                join saboringrediente on saboringrediente.sabor=sabor.codigo
                                join ingrediente on ingrediente.codigo=saboringrediente.ingrediente
                            group by ingrediente.codigo
                            order by count(*) desc
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
--combinação de 2 sabores mais pedida no ultimos 3 meses 
select 
        sabor1.nome,
        sabor2.nome,
        count(*)
    from
    (
        select 
            sabor1.sabor as sb1,
            sabor2.sabor as sb2
        from    (
                    select 
                    pizza.codigo as pizza
                    from 
                    comanda,pizza,pizzasabor,sabor
                    Where
                        comanda.numero=pizza.comanda and
                        pizzasabor.pizza=pizza.codigo and
                        pizzasabor.sabor=sabor.codigo and
                        date(comanda.data) between date('now','start of month','-3 months') and date('now','start of month','-1 day')
                    group by pizza.codigo
                    having count(*)=2
                ) as pizzas
                ,pizzasabor as sabor1
                ,pizzasabor as sabor2
                
        where 
            pizzas.pizza=sabor1.pizza and
            pizzas.pizza=sabor2.pizza and 
            sabor2.sabor!=sabor1.sabor
        group by pizzas.pizza
    ) as combination
    ,sabor as sabor1
    ,sabor as sabor2
    where 
    sabor1.codigo=combination.sb1 and
    sabor2.codigo=combination.sb2
    group by (combination.sb1 || " " || combination.sb2)
    having count(*)=(
                        select 
                            count(*)
                        from
                        (
                        select 
                            sabor1.sabor as sb1,
                            sabor2.sabor as sb2
                        from    (
                                    select 
                                    pizza.codigo as pizza
                                    from 
                                    comanda,pizza,pizzasabor,sabor
                                    Where
                                        comanda.numero=pizza.comanda and
                                        pizzasabor.pizza=pizza.codigo and
                                        pizzasabor.sabor=sabor.codigo and
                                        date(comanda.data) between date('now','start of month','-3 months') and date('now','start of month','-1 day')
                                    group by pizza.codigo
                                    having count(*)=2
                                ) as pizzas
                                ,pizzasabor as sabor1
                                ,pizzasabor as sabor2
                        where 
                            pizzas.pizza=sabor1.pizza and
                            pizzas.pizza=sabor2.pizza and 
                            sabor2.sabor!=sabor1.sabor
                        group by pizzas.pizza
                        ) as combination
                        group by (combination.sb1 || " " || combination.sb2)
                        order by count(*) desc
                        limit 1
                )
;

--o) Qual a combinação de 3 sabores mais pedida na mesma pizza nos últimos 3 meses?
select 
        sabor1.nome,
        sabor2.nome,
        sabor3.nome,
        count(*)
    from
    (
        select 
            sabor1.sabor as sb1,
            sabor2.sabor as sb2,
            sabor3.sabor as sb3
        from    (
                    select 
                    pizza.codigo as pizza
                    from 
                    comanda,pizza,pizzasabor,sabor
                    Where
                        comanda.numero=pizza.comanda and
                        pizzasabor.pizza=pizza.codigo and
                        pizzasabor.sabor=sabor.codigo and
                        date(comanda.data) between date('now','start of month','-3 months') and date('now','start of month','-1 day')
                    group by pizza.codigo
                    having count(*)=3
                ) as pizzas
                ,pizzasabor as sabor1
                ,pizzasabor as sabor2
                ,pizzasabor as sabor3
        where 
            pizzas.pizza=sabor1.pizza  and
            pizzas.pizza=sabor2.pizza  and 
            pizzas.pizza=sabor3.pizza  and 
            sabor2.sabor!=sabor1.sabor and
            sabor3.sabor!=sabor2.sabor and
            sabor3.sabor!=sabor1.sabor  
        group by pizzas.pizza
    ) as combination
    ,sabor as sabor1
    ,sabor as sabor2
    ,sabor as sabor3
    where 
    sabor1.codigo=combination.sb1 and
    sabor2.codigo=combination.sb2 and
    sabor3.codigo=combination.sb3
    group by (combination.sb1 || " " || combination.sb2 || " " || combination.sb3)
    having count(*)=(
                        select 
                            count(*)
                        from
                        (
                            select 
                                sabor1.sabor as sb1,
                                sabor2.sabor as sb2,
                                sabor3.sabor as sb3
                            from    (
                                        select 
                                        pizza.codigo as pizza
                                        from 
                                        comanda,pizza,pizzasabor,sabor
                                        Where
                                            comanda.numero=pizza.comanda and
                                            pizzasabor.pizza=pizza.codigo and
                                            pizzasabor.sabor=sabor.codigo and
                                            date(comanda.data) between date('now','start of month','-3 months') and date('now','start of month','-1 day')
                                        group by pizza.codigo
                                        having count(*)=3
                                    ) as pizzas
                                    ,pizzasabor as sabor1
                                    ,pizzasabor as sabor2
                                    ,pizzasabor as sabor3
                            where 
                                pizzas.pizza=sabor1.pizza  and
                                pizzas.pizza=sabor2.pizza  and 
                                pizzas.pizza=sabor3.pizza  and 
                                sabor2.sabor!=sabor1.sabor and
                                sabor3.sabor!=sabor2.sabor and
                                sabor3.sabor!=sabor1.sabor  
                            group by pizzas.pizza
                        ) as combination
                        ,sabor as sabor1
                        ,sabor as sabor2
                        ,sabor as sabor3
                        where 
                        sabor1.codigo=combination.sb1 and
                        sabor2.codigo=combination.sb2 and
                        sabor3.codigo=combination.sb3
                        group by (combination.sb1 || " " || combination.sb2 || " " || combination.sb3)
                        order by count(*) desc
                        limit 1 
                    )
;

--p) Qual a combinação de sabor e borda mais pedida na mesma pizza nos últimos 3 meses?
--combinação de sabor e borda mais pedida nos últimos 3 meses
--não entendi o "na mesma pizza"?
--pois na mesma pizza iimplica que uma pizza poder possuir mais de uma vez o mesmo sabor,o que não faz sentido
--se for na mesma pizza descomentar os pizza.codigo,
select 
    --pizza.codigo,
    sabor.nome,
    borda.nome,
    count(*)
    from comanda,pizza,pizzasabor,sabor,borda
    where 
        comanda.numero=pizza.comanda and
        pizzasabor.pizza=pizza.codigo and
        pizzasabor.sabor=sabor.codigo and
        pizza.borda is not null and
        pizza.borda=borda.codigo and
        comanda.data between  date('now','start of month','-3 months') and date('now','-1 days')
    group by 
        --(pizza.codigo || borda.codigo),
        borda.codigo,
        sabor.codigo
    having count(*)=(
                        select 
                            count(*)
                            from comanda,pizza,pizzasabor,sabor,borda
                            where 
                                comanda.numero=pizza.comanda and
                                pizzasabor.pizza=pizza.codigo and
                                pizzasabor.sabor=sabor.codigo and
                                pizza.borda is not null and
                                pizza.borda=borda.codigo and
                                comanda.data between  date('now','start of month','-3 months') and date('now','-1 days')
                            group by
                                --(pizza.codigo || borda.codigo),
                                borda.codigo,
                                sabor.codigo
                            order by count(*) desc
                            limit 1
                    )
;

