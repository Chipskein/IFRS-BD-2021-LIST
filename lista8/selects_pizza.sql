/*a)Listar Sabores*/
select 
    sabor.codigo as codigo,
    sabor.nome as sabor,
    tipo.nome as tipo,
    group_concat(ingrediente.nome,",") as ingredientes
    from 
    sabor
    join saboringrediente on sabor.codigo=saboringrediente.sabor
    join ingrediente on ingrediente.codigo=saboringrediente.ingrediente
    join tipo on sabor.tipo=tipo.codigo
    group by sabor.codigo
;
/*delete*/
delete from sabor where sabor.codigo=15;
/*c alterar um sabor*/
/*pegar values*/
select 
    sabor.codigo as codigo,
    sabor.nome as sabor,
    tipo.nome as tipo,
    group_concat(ingrediente.nome,",") as ingredientes
    from 
    sabor
    join saboringrediente on sabor.codigo=saboringrediente.sabor
    join ingrediente on ingrediente.codigo=saboringrediente.ingrediente
    join tipo on sabor.tipo=tipo.codigo
    where sabor.codigo=1
;
insert into saboringrediente(sabor,ingrediente)
values(29,1),(30,2),(31,3),(32,4);

select * from saboringrediente where sabor=28;


update sabor set nome=$nome,tipo=$tipo where codigo=$codigo;


delete from saboringrediente where ingrediente=$ingrediente;


select ingrediente from saboringrediente where saboringrediente.sabor=1;
delete from sabor where sabor.codigo not in (select sabor from saboringrediente group by sabor);
delete from saboringrediente where saboringrediente.sabor not in (select sabor.codigo from sabor group by sabor.codigo);



select 
    comanda.numero as numero,
    comanda.data as data,
    mesa.nome as mesa,
    tmp.count as pizzas,
    tmp2.preco as preco,
    case 
        when comanda.pago=1 then "SIM"
        when comanda.pago=0 then "NAO"
    end as pago 
    from 
    comanda
    join mesa on mesa.codigo=comanda.mesa
    join (select 
            comanda.numero as comanda,count(*) as count
            from 
            comanda 
            join pizza on pizza.comanda=comanda.numero
            group by comanda.numero
        ) as tmp on comanda.numero=tmp.comanda
    join (
            select 
                tmp.comanda as comanda,
                sum(tmp.preco) as preco
            from
            (
            select 
                comanda.numero as comanda, 
                pizza.codigo as pizza,
                sum(case 
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
            group by pizza.codigo
            ) as tmp
            group by tmp.comanda 
        ) as tmp2 on comanda.numero=tmp2.comanda
;

select 
    comanda.numero,
    pizza.codigo,
    pizza.tamanho,
    pizzasabor.sabor,
    sabor.tipo

    from comanda 
    join pizza on pizza.comanda=comanda.numero
    join pizzasabor on pizza.codigo=pizzasabor.pizza
    join sabor on sabor.codigo=pizzasabor.sabor
    join precoportamanho on precoportamanho.tipo=sabor.tipo and precoportamanho.tamanho=pizza.tamanho
;


select 
        tmp.comanda as comanda,
        sum(tmp.preco) as preco
    from
    (
    select 
        comanda.numero as comanda, 
        pizza.codigo as pizza,
        sum(case 
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
    group by pizza.codigo

    ) as tmp
    group by tmp.comanda 
;


select 
    pizza.comanda as comanda,
    pizza.codigo as pizza,
    tamanho.nome as tamanho,
    case
        when borda.nome==='NULL' then 'S/BORDA' 
        when borda.nome!='NULL' then borda.nome  
    end as borda
    from 
    pizza
    join tamanho on tamanho.codigo=pizza.tamanho
    left join borda on pizza.borda=borda.codigo 
;

select 
    pizza.comanda as comanda,
    pizza.codigo as pizza,
    tamanho.nome as tamanho,
    case
        when borda.codigo is null then 'S/BORDA' 
        when borda.codigo is not null then borda.nome  
    end as borda,
    group_concat(sabor.nome,",") as sabor,
    preco.preco as preco
    from 
    pizza
    join tamanho on tamanho.codigo=pizza.tamanho
    left join borda on pizza.borda=borda.codigo 
    join pizzasabor on pizza.codigo=pizzasabor.pizza
    join sabor on sabor.codigo=pizzasabor.sabor
    join (
        select 
            pizza.codigo as pizza,
            sum(case 
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
            group by pizza.codigo
        ) as preco on preco.pizza=pizza.codigo
    group by pizza.codigo
;
select 
    pizza.comanda as comanda,
    pizza.codigo as pizza,
    tamanho.nome as tamanho,
    case
        when borda.codigo is null then 'S/BORDA' 
        when borda.codigo is not null then borda.nome  
    end as borda,
    group_concat(sabor.nome,\",\") as sabor,
    preco.preco as preco
    from 
    pizza
    join tamanho on tamanho.codigo=pizza.tamanho
    left join borda on pizza.borda=borda.codigo 
    join pizzasabor on pizza.codigo=pizzasabor.pizza
    join sabor on sabor.codigo=pizzasabor.sabor
    join (
        select 
            pizza.codigo as pizza,
            sum(case 
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
            group by pizza.codigo
        ) as preco on preco.pizza=pizza.codigo
    where pizza.comanda=$comanda
    group by pizza.codigo
;

select 
    sum(preco)
    from
    (
    select 
    pizza.codigo as pizza,
    sum(case 
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
    where pizza.comanda=1
    group by pizza.codigo
    )
;

select 
    comanda.numero as numero,
    comanda.data as data,
    mesa.nome as mesa,
    case
        when tmp.count is null then 0
        else tmp.count 
    end as pizzas,
    case
        when tmp2.preco is null then 0
        else tmp2.preco 
    end as preco,
    case 
        when comanda.pago=1 then "SIM"
        when comanda.pago=0 then "NAO"
    end as pago 
    from 
    comanda
    join mesa on mesa.codigo=comanda.mesa
     left join (select 
            comanda.numero as comanda,count(*) as count
            from 
            comanda 
            join pizza on pizza.comanda=comanda.numero
            group by comanda.numero
        ) as tmp on comanda.numero=tmp.comanda
     left join (
            select 
                tmp.comanda as comanda,
                sum(tmp.preco) as preco
            from
            (
            select 
                comanda.numero as comanda, 
                pizza.codigo as pizza,
                sum(case 
                    when borda.preco is null then 0
                    when borda.preco is not null then borda.preco
                end+precoportamanho.preco) as preco
            from 
                comanda 
                    join pizza on pizza.comanda=comanda.numero
                    join pizzasabor on pizza.codigo=pizzasabor.pizza
                    join sabor on pizzasabor.sabor=sabor.codigo
                    join precoportamanho on pizza.tamanho=precoportamanho.tamanho and sabor.tipo=precoportamanho.tipo
                    left join borda on pizza.borda=borda.codigo
            group by pizza.codigo
            ) as tmp
            group by tmp.comanda 
        ) as tmp2 on comanda.numero=tmp2.comanda
;

select numero,pago from comanda where numero=3879;
select codigo from borda;
select codigo from tipo
select * from tamanho
select codigo from sabor where tipo=1
select * from pizzasabor;

select count(*) as total from sabor where sabor.nome like "%costa rica%";

select count(*) as total from sabor join tipo on sabor.tipo=tipo.codigo where tipo.nome like "%doces%";

select count(*) as total from sabor 
    join saboringrediente on sabor.codigo=saboringrediente.sabor join ingrediente on ingrediente.codigo=saboringrediente.ingrediente 
    where ingrediente.nome like "%alface%"
;

select count(*) as total  from comanda
    join 
    (
        select 
        comanda.numero as comanda,
        case 
            when tmp2.qt_pizza is null then 0 
            when tmp2.qt_pizza is not null then tmp2.qt_pizza 
        end as qt_pizza
        from comanda left join 
        (select comanda,count(*) as qt_pizza from pizza group by comanda) as tmp2 on tmp2.comanda=comanda.numero
    ) as tmp3 on tmp3.comanda=comanda.numero
    where tmp3.qt_pizza=0
;




select count(*) as total from comanda

    join (
    select 
    comanda.numero as comanda,
    case 
        when tmp2.preco is null then 0
        when tmp2.preco is not null then tmp2.preco
    end as preco 
    from comanda
    left join
    (
    select 
        tmp.comanda as comanda,
        sum(tmp.preco) as preco
    from
    (
        select 
            comanda.numero as comanda, 
            pizza.codigo as pizza,
            sum(case 
                when borda.preco is null then 0
                when borda.preco is not null then borda.preco
            end+precoportamanho.preco) as preco
        from 
            comanda 
                join pizza on pizza.comanda=comanda.numero
                join pizzasabor on pizza.codigo=pizzasabor.pizza
                join sabor on pizzasabor.sabor=sabor.codigo
                join precoportamanho on pizza.tamanho=precoportamanho.tamanho and sabor.tipo=precoportamanho.tipo
                left join borda on pizza.borda=borda.codigo
        group by pizza.codigo
    ) as tmp
        group by tmp.comanda 
    ) as tmp2 on comanda.numero=tmp2.comanda
    ) as tmp3 on comanda.numero=tmp3.comanda
    where tmp3.preco=58
;
select 
    sabor.codigo as codigo,
    sabor.nome as sabor,
    tipo.nome as tipo,
    group_concat(ingrediente.nome,',') as ingredientes
    from 
        sabor
            join saboringrediente on sabor.codigo=saboringrediente.sabor
            join ingrediente on ingrediente.codigo=saboringrediente.ingrediente
            join tipo on sabor.tipo=tipo.codigo
        where sabor.codigo in (
            select sabor.codigo from sabor 
            join saboringrediente on saboringrediente.sabor = sabor.codigo 
            join ingrediente on ingrediente.codigo = saboringrediente.ingrediente 
        where lower(ingrediente.nome) like '%%'
        )
    group by sabor.codigo 
;
select 
    comanda.numero as numero,
    case 
    when strftime("%w",comanda.data)='0' then strftime("Dom %d-%m-%Y",comanda.data)
    when strftime("%w",comanda.data)='1' then strftime("Seg %d-%m-%Y",comanda.data)
    when strftime("%w",comanda.data)='2' then strftime("Ter %d-%m-%Y",comanda.data)
    when strftime("%w",comanda.data)='3' then strftime("Qua %d-%m-%Y",comanda.data)
    when strftime("%w",comanda.data)='4' then strftime("Qui %d-%m-%Y",comanda.data)
    when strftime("%w",comanda.data)='5' then strftime("Sex %d-%m-%Y",comanda.data)
    when strftime("%w",comanda.data)='6' then strftime("Sáb %d-%m-%Y",comanda.data)
    end as data,
    mesa.nome as mesa,
    case
    when tmp.count is null then 0
    else tmp.count 
    end as pizzas,
    tmp3.preco as preco,
    case 
    when comanda.pago=1 then "SIM"
    when comanda.pago=0 then "NAO"
    end as pago 
    from 
    comanda
    join mesa on mesa.codigo=comanda.mesa
    left join (select 
        comanda.numero as comanda,count(*) as count
        from 
        comanda 
        join pizza on pizza.comanda=comanda.numero
        group by comanda.numero
    ) as tmp on comanda.numero=tmp.comanda
    join (
        select 
        comanda.numero as comanda,
        case 
            when tmp2.preco is null then 0
            when tmp2.preco is not null then tmp2.preco
        end as preco 
        from comanda
        left join
        (
        select 
            tmp.comanda as comanda,
            sum(tmp.preco) as preco
        from
        (
            select 
                comanda.numero as comanda, 
                pizza.codigo as pizza,
                sum(case 
                    when borda.preco is null then 0
                    when borda.preco is not null then borda.preco
                end+precoportamanho.preco) as preco
            from 
                comanda 
                    join pizza on pizza.comanda=comanda.numero
                    join pizzasabor on pizza.codigo=pizzasabor.pizza
                    join sabor on pizzasabor.sabor=sabor.codigo
                    join precoportamanho on pizza.tamanho=precoportamanho.tamanho and sabor.tipo=precoportamanho.tipo
                    left join borda on pizza.borda=borda.codigo
            group by pizza.codigo
        ) as tmp
            group by tmp.comanda 
        ) as tmp2 on comanda.numero=tmp2.comanda
        ) as tmp3 on comanda.numero=tmp3.comanda

;


select * from sabor;
select group_concat(sabor.nome,",") as sabores from sabor;

 
delete from pizza where pizza.codigo in (
select
pizza.codigo
from pizza 
join pizzasabor on pizzasabor.pizza=pizza.codigo 
left join sabor on sabor.codigo=pizzasabor.sabor
where sabor.codigo is null
)
;

select * from pizza;
select * from sabor;

select group_concat(codigo,",") from sabor;












