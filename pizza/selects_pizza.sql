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
--ultimos domingos não conta o domingo dessa semana 
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
            date(comanda.data)=date('now','weekday 0','-35 days') or
            date(comanda.data)=date('now','weekday 0','-28 days') or
            date(comanda.data)=date('now','weekday 0','-21 days') or
            date(comanda.data)=date('now','weekday 0','-14 days') 
          ) 
;
--d) Qual mesa foi mais utilizada nos últimos 60 dias?
select 
    mesa.nome,count(*)
    from mesa
        join comanda on mesa.codigo=comanda.mesa
    where date(comanda.data) between date('now','-60 days') and date('now')
    group by mesa.codigo
    having count(*)=(
                        select 
                        count(*)
                        from mesa
                            join comanda on mesa.codigo=comanda.mesa
                        where date(comanda.data) between date('now','-60 days') and date('now')
                        group by mesa.codigo
                        order by count(*) desc
                        limit 1
                    )
;
--e) Qual mesa foi menos utilizada nos últimos 60 dias?
select 
    mesa.nome,count(*)
    from mesa
        join comanda on mesa.codigo=comanda.mesa
        where date(comanda.data) between date('now','-60 days') and date('now')
    group by mesa.codigo
    having count(*)=(
                        select 
                        count(*)
                        from mesa
                            join comanda on mesa.codigo=comanda.mesa
                            where date(comanda.data) between date('now','-60 days') and date('now')
                        group by mesa.codigo
                        order by count(*) asc
                        limit 1
                    )
;
--f) Quais mesas foram utilizadas mais de 2 vezes a média de utilização de todas as mesas nos últimos 60 dias?
--media=sum(quantas vezes cada mesa foi usada)/count(numero de mesas)
--select cast(23+30+30+22+30+25+34+35+21+35+37+32+30+28+28 as real)/15.0 
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
--último mês=mes passado
select 
    sabor.nome
    from 
    comanda
        join pizza on pizza.comanda=comanda.numero
        join pizzasabor on pizza.codigo=pizzasabor.pizza
        join sabor on sabor.codigo=pizzasabor.sabor
    where date(comanda.data) between date('now','start of month','-1 month') and  date('now','start of month','-1 days')
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
                                where date(comanda.data) between date('now','start of month','-1 month') and  date('now','start of month','-1 days')
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
    where date(comanda.data) between date('now','start of month','-2 months') and  date('now','start of month','-1 month','-1 days')        
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
                                where date(comanda.data) between date('now','start of month','-2 months') and  date('now','start of month','-1 month','-1 days')
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
    where date(comanda.data) between date('now','start of month','-1 month') and  date('now','start of month','-1 days')
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
                                where date(comanda.data) between date('now','start of month','-1 month') and  date('now','start of month','-1 days')
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
    where date(comanda.data) between date('now','start of month','-2 months') and  date('now','start of month','-1 month','-1 days')        
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
                                where date(comanda.data) between date('now','start of month','-2 months') and  date('now','start of month','-1 month','-1 days')
                                group by sabor.codigo
                                order by qt4 desc
                                limit 10
                            )
;
--i) Quais sabores não foram pedidos nos últimos 3 meses?
--último 3 meses=mes passado + 2 meses retrasados
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
                                    where date(comanda.data) between date('now','start of month','-3 months') and date('now','start of month','-1 days')
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
--tabela com a data dos solcsticios e quinocios entre (2001-2100)
create table if not exists solcs_equinox(
    march_equinox datetime not null,
    june_solcstice datetime not null,
    sep_equinox datetime not null,
    dec_equinox datetime not null
);
insert into solcs_equinox(march_equinox,june_solcstice,sep_equinox,dec_equinox) values
    (datetime('2001-03-20  13:31'),datetime('2001-06-21  07:38'),datetime('2001-09-22  23:05'),datetime('2001-12-21  19:22')),    
    (datetime('2002-03-20  19:16'),datetime('2002-06-21  13:25'),datetime('2002-09-23  04:56'),datetime('2002-12-22  01:15')),    
    (datetime('2003-03-21  01:00'),datetime('2003-06-21  19:11'),datetime('2003-09-23  10:47'),datetime('2003-12-22  07:04')),    
    (datetime('2004-03-20  06:49'),datetime('2004-06-21  00:57'),datetime('2004-09-22  16:30'),datetime('2004-12-21  12:42')),    
    (datetime('2005-03-20  12:34'),datetime('2005-06-21  06:46'),datetime('2005-09-22  22:23'),datetime('2005-12-21  18:35')),    
    (datetime('2006-03-20  18:25'),datetime('2006-06-21  12:26'),datetime('2006-09-23  04:04'),datetime('2006-12-22  00:22')),    
    (datetime('2007-03-21  00:07'),datetime('2007-06-21  18:06'),datetime('2007-09-23  09:51'),datetime('2007-12-22  06:08')),    
    (datetime('2008-03-20  05:49'),datetime('2007-06-21  00:00'),datetime('2008-09-22  15:45'),datetime('2008-12-21  12:04')),    
    (datetime('2009-03-20  11:44'),datetime('2009-06-21  05:45'),datetime('2009-09-22  21:18'),datetime('2009-12-21  17:47')),    
    (datetime('2010-03-20  17:32'),datetime('2010-06-21  11:28'),datetime('2010-09-23  03:09'),datetime('2010-12-21  23:38')),    
    (datetime('2011-03-20  23:21'),datetime('2011-06-21  17:16'),datetime('2011-09-23  09:05'),datetime('2011-12-22  05:30')),    
    (datetime('2012-03-20  05:15'),datetime('2012-06-20  23:08'),datetime('2012-09-22  14:49'),datetime('2012-12-21  11:12')),    
    (datetime('2013-03-20  11:02'),datetime('2013-06-21  05:04'),datetime('2013-09-22  20:44'),datetime('2013-12-21  17:11')),    
    (datetime('2014-03-20  16:57'),datetime('2014-06-21  10:52'),datetime('2014-09-23  02:30'),datetime('2014-12-21  23:03')),    
    (datetime('2015-03-20  22:45'),datetime('2015-06-21  16:38'),datetime('2015-09-23  08:20'),datetime('2015-12-22  04:48')),    
    (datetime('2016-03-20  04:31'),datetime('2016-06-20  22:35'),datetime('2016-09-22  14:21'),datetime('2016-12-21  10:45')),    
    (datetime('2017-03-20  10:29'),datetime('2017-06-21  04:25'),datetime('2017-09-22  20:02'),datetime('2017-12-21  16:29')),    
    (datetime('2018-03-20  16:15'),datetime('2018-06-21  10:07'),datetime('2018-09-23  01:54'),datetime('2018-12-21  22:22')),    
    (datetime('2019-03-20  21:58'),datetime('2019-06-21  15:54'),datetime('2019-09-23  07:50'),datetime('2019-12-22  04:19')),    
    (datetime('2020-03-20  03:50'),datetime('2020-06-20  21:43'),datetime('2020-09-22  13:31'),datetime('2020-12-21  10:03')),    
    (datetime('2021-03-20  09:37'),datetime('2021-06-21  03:32'),datetime('2021-09-22  19:21'),datetime('2021-12-21  15:59')),    
    (datetime('2022-03-20  15:33'),datetime('2022-06-21  09:14'),datetime('2022-09-23  01:04'),datetime('2022-12-21  21:48')),    
    (datetime('2023-03-20  21:25'),datetime('2023-06-21  14:58'),datetime('2023-09-23  06:50'),datetime('2023-12-22  03:28')),    
    (datetime('2024-03-20  03:07'),datetime('2024-06-20  20:51'),datetime('2024-09-22  12:44'),datetime('2024-12-21  09:20')),    
    (datetime('2025-03-20  09:02'),datetime('2025-06-21  02:42'),datetime('2025-09-22  18:20'),datetime('2025-12-21  15:03')),    
    (datetime('2026-03-20  14:46'),datetime('2026-06-21  08:25'),datetime('2026-09-23  00:06'),datetime('2026-12-21  20:50')),    
    (datetime('2027-03-20  20:25'),datetime('2027-06-21  14:11'),datetime('2027-09-23  06:02'),datetime('2027-12-22  02:43')),    
    (datetime('2028-03-20  02:17'),datetime('2028-06-20  20:02'),datetime('2028-09-22  11:45'),datetime('2028-12-21  08:20')),    
    (datetime('2029-03-20  08:01'),datetime('2029-06-21  01:48'),datetime('2029-09-22  17:37'),datetime('2029-12-21  14:14')),    
    (datetime('2030-03-20  13:51'),datetime('2030-06-21  07:31'),datetime('2030-09-22  23:27'),datetime('2030-12-21  20:09')),    
    (datetime('2031-03-20  19:41'),datetime('2031-06-21  13:17'),datetime('2031-09-23  05:15'),datetime('2031-12-22  01:56')),    
    (datetime('2032-03-20  01:23'),datetime('2032-06-20  19:09'),datetime('2032-09-22  11:11'),datetime('2032-12-21  07:57')),    
    (datetime('2033-03-20  07:23'),datetime('2033-06-21  01:01'),datetime('2033-09-22  16:52'),datetime('2033-12-21  13:45')),    
    (datetime('2034-03-20  13:18'),datetime('2034-06-21  06:45'),datetime('2034-09-22  22:41'),datetime('2034-12-21  19:35')),    
    (datetime('2035-03-20  19:03'),datetime('2035-06-21  12:33'),datetime('2035-09-23  04:39'),datetime('2035-12-22  01:31')),    
    (datetime('2036-03-20  01:02'),datetime('2036-06-20  18:31'),datetime('2036-09-22  10:23'),datetime('2036-12-21  07:12')),    
    (datetime('2037-03-20  06:50'),datetime('2037-06-21  00:22'),datetime('2037-09-22  16:13'),datetime('2037-12-21  13:08')),    
    (datetime('2038-03-20  12:40'),datetime('2038-06-21  06:09'),datetime('2038-09-22  22:02'),datetime('2038-12-21  19:01')),    
    (datetime('2039-03-20  18:32'),datetime('2039-06-21  11:58'),datetime('2039-09-23  03:50'),datetime('2039-12-22  00:41')),    
    (datetime('2040-03-20  00:11'),datetime('2040-06-20  17:46'),datetime('2040-09-22  09:44'),datetime('2040-12-21  06:33')),    
    (datetime('2041-03-20  06:07'),datetime('2041-06-20  23:37'),datetime('2041-09-22  15:27'),datetime('2041-12-21  12:19')),    
    (datetime('2042-03-20  11:53'),datetime('2042-06-21  05:16'),datetime('2042-09-22  21:11'),datetime('2042-12-21  18:04')),    
    (datetime('2043-03-20  17:29'),datetime('2043-06-21  10:59'),datetime('2043-09-23  03:07'),datetime('2043-12-22  00:02')),    
    (datetime('2044-03-19  23:20'),datetime('2044-06-20  16:50'),datetime('2044-09-22  08:47'),datetime('2044-12-21  05:43')),    
    (datetime('2045-03-20  05:08'),datetime('2045-06-20  22:34'),datetime('2045-09-22  14:33'),datetime('2045-12-21  11:36')),    
    (datetime('2046-03-20  10:58'),datetime('2046-06-21  04:15'),datetime('2046-09-22  20:22'),datetime('2046-12-21  17:28')),    
    (datetime('2047-03-20  16:52'),datetime('2047-06-21  10:02'),datetime('2047-09-23  02:07'),datetime('2047-12-21  23:07')),    
    (datetime('2048-03-19  22:34'),datetime('2048-06-20  15:54'),datetime('2048-09-22  08:01'),datetime('2048-12-21  05:02')),    
    (datetime('2049-03-20  04:28'),datetime('2049-06-20  21:47'),datetime('2049-09-22  13:42'),datetime('2049-12-21  10:51')),    
    (datetime('2050-03-20  10:20'),datetime('2050-06-21  03:33'),datetime('2050-09-22  19:29'),datetime('2050-12-21  16:39')),
    (datetime('2051-03-20  15:58'),datetime('2051-06-21  09:17'),datetime('2051-09-23  01:26'),datetime('2051-12-21  22:33')),    
    (datetime('2052-03-19  21:56'),datetime('2052-06-20  15:16'),datetime('2052-09-22  07:16'),datetime('2052-12-21  04:18')),    
    (datetime('2053-03-20  03:46'),datetime('2053-06-20  21:03'),datetime('2053-09-22  13:05'),datetime('2053-12-21  10:09')),    
    (datetime('2054-03-20  09:35'),datetime('2054-06-21  02:47'),datetime('2054-09-22  19:00'),datetime('2054-12-21  16:10')),    
    (datetime('2055-03-20  15:28'),datetime('2055-06-21  08:39'),datetime('2055-09-23  00:48'),datetime('2055-12-21  21:56')),    
    (datetime('2056-03-19  21:11'),datetime('2056-06-20  14:29'),datetime('2056-09-22  06:40'),datetime('2056-12-21  03:52')),    
    (datetime('2057-03-20  03:08'),datetime('2057-06-20  20:19'),datetime('2057-09-22  12:23'),datetime('2057-12-21  09:42')),    
    (datetime('2058-03-20  09:04'),datetime('2058-06-21  02:03'),datetime('2058-09-22  18:07'),datetime('2058-12-21  15:24')),    
    (datetime('2059-03-20  14:44'),datetime('2059-06-21  07:47'),datetime('2059-09-23  00:03'),datetime('2059-12-21  21:18')),    
    (datetime('2060-03-19  20:37'),datetime('2060-06-20  13:44'),datetime('2060-09-22  05:47'),datetime('2060-12-21  03:00')),    
    (datetime('2061-03-20  02:26'),datetime('2061-06-20  19:33'),datetime('2061-09-22  11:31'),datetime('2061-12-21  08:49')),    
    (datetime('2062-03-20  08:07'),datetime('2062-06-21  01:10'),datetime('2062-09-22  17:19'),datetime('2062-12-21  14:42')),    
    (datetime('2063-03-20  13:59'),datetime('2063-06-21  07:02'),datetime('2063-09-22  23:08'),datetime('2063-12-21  20:22')),    
    (datetime('2064-03-19  19:40'),datetime('2064-06-20  12:47'),datetime('2064-09-22  04:58'),datetime('2064-12-21  02:10')),    
    (datetime('2065-03-20  01:27'),datetime('2065-06-20  18:31'),datetime('2065-09-22  10:41'),datetime('2065-12-21  07:59')),    
    (datetime('2066-03-20  07:19'),datetime('2066-06-21  00:16'),datetime('2066-09-22  16:27'),datetime('2066-12-21  13:45')),    
    (datetime('2067-03-20  12:55'),datetime('2067-06-21  05:56'),datetime('2067-09-22  22:20'),datetime('2067-12-21  19:44')),    
    (datetime('2068-03-19  18:51'),datetime('2068-06-20  11:55'),datetime('2068-09-22  04:09'),datetime('2068-12-21  01:34')),    
    (datetime('2069-03-20  00:44'),datetime('2069-06-20  17:40'),datetime('2069-09-22  09:51'),datetime('2069-12-21  07:21')),    
    (datetime('2070-03-20  06:35'),datetime('2070-06-20  23:22'),datetime('2070-09-22  15:45'),datetime('2070-12-21  13:19')),    
    (datetime('2071-03-20  12:36'),datetime('2071-06-21  05:21'),datetime('2071-09-22  21:39'),datetime('2071-12-21  19:05')),    
    (datetime('2072-03-19  18:19'),datetime('2072-06-20  11:12'),datetime('2072-09-22  03:26'),datetime('2072-12-21  00:54')),    
    (datetime('2073-03-20  00:12'),datetime('2073-06-20  17:06'),datetime('2073-09-22  09:14'),datetime('2073-12-21  06:50')),    
    (datetime('2074-03-20  06:09'),datetime('2074-06-20  22:59'),datetime('2074-09-22  15:04'),datetime('2074-12-21  12:36')),    
    (datetime('2075-03-20  11:48'),datetime('2075-06-21  04:41'),datetime('2075-09-22  21:00'),datetime('2075-12-21  18:28')),    
    (datetime('2076-03-19  17:37'),datetime('2076-06-20  10:35'),datetime('2076-09-22  02:48'),datetime('2076-12-21  00:12')),    
    (datetime('2077-03-19  23:30'),datetime('2077-06-20  16:23'),datetime('2077-09-22  08:35'),datetime('2077-12-21  06:00')),    
    (datetime('2078-03-20  05:11'),datetime('2078-06-20  21:58'),datetime('2078-09-22  14:25'),datetime('2078-12-21  11:59')),    
    (datetime('2079-03-20  11:03'),datetime('2079-06-21  03:51'),datetime('2079-09-22  20:15'),datetime('2079-12-21  17:46')),    
    (datetime('2080-03-19  16:43'),datetime('2080-06-20  09:33'),datetime('2080-09-22  01:55'),datetime('2080-12-20  23:31')),    
    (datetime('2081-03-19  22:34'),datetime('2081-06-20  15:16'),datetime('2081-09-22  07:38'),datetime('2081-12-21  05:22')),    
    (datetime('2082-03-20  04:32'),datetime('2082-06-20  21:04'),datetime('2082-09-22  13:24'),datetime('2082-12-21  11:06')),    
    (datetime('2083-03-20  10:08'),datetime('2083-06-21  02:41'),datetime('2083-09-22  19:10'),datetime('2083-12-21  16:51')),    
    (datetime('2084-03-19  15:58'),datetime('2084-06-20  08:39'),datetime('2084-09-22  00:58'),datetime('2084-12-20  22:40')),    
    (datetime('2085-03-19  21:53'),datetime('2085-06-20  14:33'),datetime('2085-09-22  06:43'),datetime('2085-12-21  04:29')),    
    (datetime('2086-03-20  03:36'),datetime('2086-06-20  20:11'),datetime('2086-09-22  12:33'),datetime('2086-12-21  10:24')),    
    (datetime('2087-03-20  09:27'),datetime('2087-06-21  02:05'),datetime('2087-09-22  18:27'),datetime('2087-12-21  16:07')),    
    (datetime('2088-03-19  15:16'),datetime('2088-06-20  07:57'),datetime('2088-09-22  00:18'),datetime('2088-12-20  21:56')),    
    (datetime('2089-03-19  21:07'),datetime('2089-06-20  13:43'),datetime('2089-09-22  06:07'),datetime('2089-12-21  03:53')),    
    (datetime('2090-03-20  03:03'),datetime('2090-06-20  19:37'),datetime('2090-09-22  12:01'),datetime('2090-12-21  09:45')),    
    (datetime('2091-03-20  08:40'),datetime('2091-06-21  01:17'),datetime('2091-09-22  17:49'),datetime('2091-12-21  15:37')),    
    (datetime('2092-03-19  14:33'),datetime('2092-06-20  07:14'),datetime('2092-09-21  23:41'),datetime('2092-12-20  21:31')),    
    (datetime('2093-03-19  20:35'),datetime('2093-06-20  13:08'),datetime('2093-09-22  05:30'),datetime('2093-12-21  03:21')),    
    (datetime('2094-03-20  02:20'),datetime('2094-06-20  18:40'),datetime('2094-09-22  11:15'),datetime('2094-12-21  09:11')),    
    (datetime('2095-03-20  08:14'),datetime('2095-06-21  00:38'),datetime('2095-09-22  17:10'),datetime('2095-12-21  15:00')),    
    (datetime('2096-03-19  14:03'),datetime('2096-06-20  06:31'),datetime('2096-09-21  22:55'),datetime('2096-12-20  20:46')),    
    (datetime('2097-03-19  19:49'),datetime('2097-06-20  12:14'),datetime('2097-09-22  04:37'),datetime('2097-12-21  02:38')),    
    (datetime('2098-03-20  01:38'),datetime('2098-06-20  18:01'),datetime('2098-09-22  10:22'),datetime('2098-12-21  08:19')),    
    (datetime('2099-03-20  07:17'),datetime('2099-06-20  23:41'),datetime('2099-09-22  16:10'),datetime('2099-12-21  14:04')),    
    (datetime('2100-03-20  13:04'),datetime('2100-06-21  05:32'),datetime('2100-09-22  22:00'),datetime('2100-12-21  19:51'))
;    

--j) Quais foram os 3 sabores mais pedidos na última estação do ano?
 select 
    datas.station,sabor.nome,count(*)
    from
    (
        select 
        DISTINCT
        comanda.data as data,
        case 
            when 
                strftime('%m-%d',comanda.data) between 
                strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
            then 'outono'
            
            when 
                strftime('%m-%d',comanda.data) between 
                strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
            then 'inverno'
        
            when 
                strftime('%m-%d',comanda.data) between 
                strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
            then 'primavera'
            --verao solcsticio de dezembro - final do ano
            when 
                strftime('%m-%d',comanda.data) between 
                strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data,'-1 year'))) and 
                strftime('%m-%d %H:%M:%S','2020-12-31')
                or 
                strftime('%m-%d',comanda.data) between
                strftime('%m-%d %H:%M:%S','2021-01-01') 
                and strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
            then 'verao'
            else 'verao'
        end as station
        from 
        comanda
        where
            strftime('%Y',comanda.data)=strftime('%Y','now')
            and station = (
                                select 
                                distinct
                                case 
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                        strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'outono'
                                    
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                        strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'inverno'
                                
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                        strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'primavera'
                                    --verao solcsticio de dezembro - final do ano
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data,'-1 year'))) and 
                                        strftime('%m-%d %H:%M:%S','2020-12-31')
                                        or 
                                        strftime('%m-%d',comanda.data) between
                                        strftime('%m-%d %H:%M:%S','2021-01-01') 
                                        and strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'verao'
                                    else 'verao'
                                end as station
                                from 
                                comanda
                                where 
                                    strftime('%Y',comanda.data)=strftime('%Y','now')
                                    and station != (
                                                        select 
                                                            distinct
                                                            case 
                                                                when 
                                                                    strftime('%m-%d',comanda.data) between 
                                                                    strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                    strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                then 'outono'
                                                                
                                                                when 
                                                                    strftime('%m-%d',comanda.data) between 
                                                                    strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                    strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                then 'inverno'
                                                            
                                                                when 
                                                                    strftime('%m-%d',comanda.data) between 
                                                                    strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                    strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                then 'primavera'
                                                                --verao solcsticio de dezembro - final do ano
                                                                when 
                                                                    strftime('%m-%d',comanda.data) between 
                                                                    strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data,'-1 year'))) and 
                                                                    strftime('%m-%d %H:%M:%S','2020-12-31')
                                                                    or 
                                                                    strftime('%m-%d',comanda.data) between
                                                                    strftime('%m-%d %H:%M:%S','2021-01-01') 
                                                                    and strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                then 'verao'
                                                                else 'verao'
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
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                        strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'outono'
                                    
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                        strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'inverno'
                                
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                        strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'primavera'
                                    --verao solcsticio de dezembro - final do ano
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data,'-1 year'))) and 
                                        strftime('%m-%d %H:%M:%S','2020-12-31')
                                        or 
                                        strftime('%m-%d',comanda.data) between
                                        strftime('%m-%d %H:%M:%S','2021-01-01') 
                                        and strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'verao'
                                    else 'verao'
                                end as station
                                from 
                                comanda
                                where
                                    strftime('%Y',comanda.data)=strftime('%Y','now')
                                    and station = (
                                                        select 
                                                        distinct
                                                        case 
                                                            when 
                                                                strftime('%m-%d',comanda.data) between 
                                                                strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                            then 'outono'
                                                            
                                                            when 
                                                                strftime('%m-%d',comanda.data) between 
                                                                strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                            then 'inverno'
                                                        
                                                            when 
                                                                strftime('%m-%d',comanda.data) between 
                                                                strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                            then 'primavera'
                                                            --verao solcsticio de dezembro - final do ano
                                                            when 
                                                                strftime('%m-%d',comanda.data) between 
                                                                strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data,'-1 year'))) and 
                                                                strftime('%m-%d %H:%M:%S','2020-12-31')
                                                                or 
                                                                strftime('%m-%d',comanda.data) between
                                                                strftime('%m-%d %H:%M:%S','2021-01-01') 
                                                                and strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                            then 'verao'
                                                            else 'verao'
                                                        end as station
                                                        from 
                                                        comanda
                                                        where 
                                                            strftime('%Y',comanda.data)=strftime('%Y','now')
                                                            and station != (
                                                                                select 
                                                                                    distinct
                                                                                    case 
                                                                                        when 
                                                                                            strftime('%m-%d',comanda.data) between 
                                                                                            strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                                            strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                                        then 'outono'
                                                                                        
                                                                                        when 
                                                                                            strftime('%m-%d',comanda.data) between 
                                                                                            strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                                            strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                                        then 'inverno'
                                                                                    
                                                                                        when 
                                                                                            strftime('%m-%d',comanda.data) between 
                                                                                            strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                                            strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                                        then 'primavera'
                                                                                        --verao solcsticio de dezembro - final do ano
                                                                                        when 
                                                                                            strftime('%m-%d',comanda.data) between 
                                                                                            strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data,'-1 year'))) and 
                                                                                            strftime('%m-%d %H:%M:%S','2020-12-31')
                                                                                            or 
                                                                                            strftime('%m-%d',comanda.data) between
                                                                                            strftime('%m-%d %H:%M:%S','2021-01-01') 
                                                                                            and strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                                        then 'verao'
                                                                                        else 'verao'
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
            when 
                strftime('%m-%d',comanda.data) between 
                strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
            then 'outono'
            
            when 
                strftime('%m-%d',comanda.data) between 
                strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
            then 'inverno'
        
            when 
                strftime('%m-%d',comanda.data) between 
                strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
            then 'primavera'
            --verao solcsticio de dezembro - final do ano
            when 
                strftime('%m-%d',comanda.data) between 
                strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data,'-1 year'))) and 
                strftime('%m-%d %H:%M:%S','2020-12-31')
                or 
                strftime('%m-%d',comanda.data) between
                strftime('%m-%d %H:%M:%S','2021-01-01') 
                and strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
            then 'verao'
            else 'verao'
        end as station
        from 
        comanda
        where
            strftime('%Y',comanda.data)=strftime('%Y','now')
            and station = (
                                select 
                                distinct
                                case 
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                        strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'outono'
                                    
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                        strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'inverno'
                                
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                        strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'primavera'
                                    --verao solcsticio de dezembro - final do ano
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data,'-1 year'))) and 
                                        strftime('%m-%d %H:%M:%S','2020-12-31')
                                        or 
                                        strftime('%m-%d',comanda.data) between
                                        strftime('%m-%d %H:%M:%S','2021-01-01') 
                                        and strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'verao'
                                    else 'verao'
                                end as station
                                from 
                                comanda
                                where 
                                    strftime('%Y',comanda.data)=strftime('%Y','now')
                                    and station != (
                                                        select 
                                                            distinct
                                                            case 
                                                                when 
                                                                    strftime('%m-%d',comanda.data) between 
                                                                    strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                    strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                then 'outono'
                                                                
                                                                when 
                                                                    strftime('%m-%d',comanda.data) between 
                                                                    strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                    strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                then 'inverno'
                                                            
                                                                when 
                                                                    strftime('%m-%d',comanda.data) between 
                                                                    strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                    strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                then 'primavera'
                                                                --verao solcsticio de dezembro - final do ano
                                                                when 
                                                                    strftime('%m-%d',comanda.data) between 
                                                                    strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data,'-1 year'))) and 
                                                                    strftime('%m-%d %H:%M:%S','2020-12-31')
                                                                    or 
                                                                    strftime('%m-%d',comanda.data) between
                                                                    strftime('%m-%d %H:%M:%S','2021-01-01') 
                                                                    and strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                then 'verao'
                                                                else 'verao'
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
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                        strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'outono'
                                    
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                        strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'inverno'
                                
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                        strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'primavera'
                                    --verao solcsticio de dezembro - final do ano
                                    when 
                                        strftime('%m-%d',comanda.data) between 
                                        strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data,'-1 year'))) and 
                                        strftime('%m-%d %H:%M:%S','2020-12-31')
                                        or 
                                        strftime('%m-%d',comanda.data) between
                                        strftime('%m-%d %H:%M:%S','2021-01-01') 
                                        and strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                    then 'verao'
                                    else 'verao'
                                end as station
                                from 
                                comanda
                                where
                                    strftime('%Y',comanda.data)=strftime('%Y','now')
                                    and station = (
                                                        select 
                                                        distinct
                                                        case 
                                                            when 
                                                                strftime('%m-%d',comanda.data) between 
                                                                strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                            then 'outono'
                                                            
                                                            when 
                                                                strftime('%m-%d',comanda.data) between 
                                                                strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                            then 'inverno'
                                                        
                                                            when 
                                                                strftime('%m-%d',comanda.data) between 
                                                                strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                            then 'primavera'
                                                            --verao solcsticio de dezembro - final do ano
                                                            when 
                                                                strftime('%m-%d',comanda.data) between 
                                                                strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data,'-1 year'))) and 
                                                                strftime('%m-%d %H:%M:%S','2020-12-31')
                                                                or 
                                                                strftime('%m-%d',comanda.data) between
                                                                strftime('%m-%d %H:%M:%S','2021-01-01') 
                                                                and strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                            then 'verao'
                                                            else 'verao'
                                                        end as station
                                                        from 
                                                        comanda
                                                        where 
                                                            strftime('%Y',comanda.data)=strftime('%Y','now')
                                                            and station != (
                                                                                select 
                                                                                    distinct
                                                                                    case 
                                                                                        when 
                                                                                            strftime('%m-%d',comanda.data) between 
                                                                                            strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                                            strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                                        then 'outono'
                                                                                        
                                                                                        when 
                                                                                            strftime('%m-%d',comanda.data) between 
                                                                                            strftime('%m-%d %H:%M:%S',(select june_solcstice from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                                            strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                                        then 'inverno'
                                                                                    
                                                                                        when 
                                                                                            strftime('%m-%d',comanda.data) between 
                                                                                            strftime('%m-%d %H:%M:%S',(select sep_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) and 
                                                                                            strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                                        then 'primavera'
                                                                                        --verao solcsticio de dezembro - final do ano
                                                                                        when 
                                                                                            strftime('%m-%d',comanda.data) between 
                                                                                            strftime('%m-%d %H:%M:%S',(select dec_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data,'-1 year'))) and 
                                                                                            strftime('%m-%d %H:%M:%S','2020-12-31')
                                                                                            or 
                                                                                            strftime('%m-%d',comanda.data) between
                                                                                            strftime('%m-%d %H:%M:%S','2021-01-01') 
                                                                                            and strftime('%m-%d %H:%M:%S',(select march_equinox from solcs_equinox where strftime('%Y',march_equinox)=strftime('%Y',comanda.data))) 
                                                                                        then 'verao'
                                                                                        else 'verao'
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
        comanda.data between  date('now','start of month','-3 months') and date('now','start of month','-1 days')
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
                                comanda.data between  date('now','start of month','-3 months') and date('now','start of month','-1 days')
                            group by
                                --(pizza.codigo || borda.codigo),
                                borda.codigo,
                                sabor.codigo
                            order by count(*) desc
                            limit 1
                    )
;

