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
