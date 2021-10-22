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

