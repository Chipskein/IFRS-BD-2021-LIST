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

select * from sabor;


update sabor set nome=$nome,tipo=$tipo where codigo=$codigo;


delete from saboringrediente where ingrediente=$ingrediente;


select ingrediente from saboringrediente where saboringrediente.sabor=1;
delete from sabor where sabor.codigo not in (select sabor from saboringrediente group by sabor);