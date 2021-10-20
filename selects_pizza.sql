/*a)Listar Sabores*/
select 
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
/*b)*/
 