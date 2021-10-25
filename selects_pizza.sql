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






insert into comanda(mesa,data,pago) values(2,CURRENT_DATE,0),(4,CURRENT_DATE,0)

select count(*) from pizza where comanda=3880;


