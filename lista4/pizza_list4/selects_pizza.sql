/*
3) Utilizando a modelagem da pizzaria do material, escreva comandos select para responder as
perguntas:
*/
--a) Quais os nomes dos ingredientes no sabor cujo nome é São Tomé e Príncipe?
SELECT ingrediente.nome as ingrediente_san_tome
FROM sabor JOIN saboringrediente JOIN ingrediente
ON sabor.nome like '%sao tome e principe%' AND 
sabor.codigo=saboringrediente.sabor AND 
saboringrediente.ingrediente=ingrediente.codigo;
--b) Quais os nomes dos sabores que contém o ingrediente bacon?
SELECT sabor.nome as names_from_bacon
FROM sabor JOIN saboringrediente JOIN ingrediente 
ON ingrediente.nome like '%bacon%' AND 
ingrediente.codigo=saboringrediente.ingrediente AND
saboringrediente.sabor=sabor.codigo;
--c) Quais os nomes dos sabores que contém os ingredientes bacon e gorgonzola?
    --considerando que o mesmo ingrediente não seja colocado 2 vezes no mesmo sabor
    --testado com os ingredientes lombo de porco(23) e peito de frango(30)
    --pois o banco atual não tem sabores com bacon e gorgonzola 
select sabor.nome as sabor_com_bacon_e_gorgonzola
from sabor,saboringrediente,ingrediente 
where sabor.codigo=saboringrediente.sabor AND 
(ingrediente.nome like "%bacon%" or ingrediente.nome like "%gorgonzola%") AND
saboringrediente.ingrediente=ingrediente.codigo
group by sabor 
having count(*)>1;

--d) Quais os nomes dos sabores salgados que possuem mais de 8 ingredientes?
select  tipo.nome,sabor.nome,count(*) as sabores_salgados_maisde8
from tipo,sabor,saboringrediente 
where tipo.nome like "%salgadas%" and 
tipo.codigo=sabor.tipo and 
sabor.codigo=saboringrediente.sabor 
group by sabor 
having count(*)>8;

--e) Quais os nomes dos sabores doces que possuem mais de 8 ingredientes?
select  tipo.nome,sabor.nome,count(*) as sabores_doces_maisde8
from tipo,sabor,saboringrediente 
where tipo.nome like "%doces%" and 
tipo.codigo=sabor.tipo and 
sabor.codigo=saboringrediente.sabor 
group by sabor 
having count(*)>8;

--f) Quais os nomes dos sabores que foram pedidos mais de 20 vezes no mês passado?
 select sabor.nome,count(*) as pedidos_counter
 from comanda,pizza,pizzasabor,sabor 
 where comanda.numero=pizza.comanda AND
 pizza.codigo=pizzasabor.pizza AND
 sabor.codigo=pizzasabor.sabor AND
 comanda.data between datetime('now','start of month','-1 months') and datetime('now','start of month','-1 days') 
 group by sabor 
 having count(*)>20;
--g) Quais os nomes dos sabores salgados que foram pedidos mais de 20 vezes no mês passado?
select tipo.nome,sabor.nome,count(*) as sabores_salgados_maisde20
from comanda,pizza,pizzasabor,sabor,tipo 
where tipo.nome like '%salgadas%' AND 
sabor.tipo=tipo.codigo AND
comanda.numero=pizza.comanda AND
pizza.codigo=pizzasabor.pizza AND
sabor.codigo=pizzasabor.sabor AND
comanda.data between datetime('now','start of month','-1 months') and datetime('now','start of month','-1 days') 
group by sabor 
having count(*)>20;
--h) Quais is nomes dos sabores doces que foram pedidos mais de 20 vezes no mês passado?
select tipo.nome,sabor.nome,count(*) as sabores_doces_maisde20
from comanda,pizza,pizzasabor,sabor,tipo 
where tipo.nome like '%doces%' AND 
sabor.tipo=tipo.codigo AND
comanda.numero=pizza.comanda AND
pizza.codigo=pizzasabor.pizza AND
sabor.codigo=pizzasabor.sabor AND
comanda.data between datetime('now','start of month','-1 months') and datetime('now','start of month','-1 days') 
group by sabor 
having count(*)>20;


--i) Qual o ranking dos ingredientes mais pedidos nos últimos 12 meses?
select ingrediente.nome, count(*) as ingredientes_mais_pedidos
from ingrediente,comanda, pizza, tipo, sabor, pizzasabor, saboringrediente
where ingrediente.codigo= saboringrediente.ingrediente AND
sabor.tipo=tipo.codigo AND
comanda.numero=pizza.comanda AND
pizza.codigo=pizzasabor.pizza AND
sabor.codigo=pizzasabor.sabor AND
comanda.data between datetime('now','start of month','-12 months') and datetime('now','start of month','-1 days') 
group by ingrediente 
order by count(*) desc;
--j) Qual o ranking dos sabores salgados mais pedidos por mês nos últimos 12 meses?
select 
strftime('%Y-%m',comanda.data) ano_mes,
case strftime('%m',comanda.data)
    when '01' then 'janeiro'
    when '02' then 'fevereiro'
    when '03' then 'marco'
    when '04' then 'abril'
    when '05' then 'maio'
    when '06' then 'junho'
    when '07' then 'julho'
    when '08' then 'agosto'
    when '09' then 'setembro'
    when '10' then 'outubro'
    when '11' then 'novembro'
    when '12' then 'dezembro'
end as mes_nome,
sabor.nome,count(sabor.nome) as por_mes
from comanda,pizza,pizzasabor,sabor,tipo 
where comanda.numero=pizza.comanda 
and pizzasabor.pizza=pizza.codigo 
and pizzasabor.sabor=sabor.codigo
and tipo.nome like "%salgadas%"
and sabor.tipo=tipo.codigo
and comanda.data between datetime('now','-12 months') and datetime('now')
group by ano_mes,sabor.nome
order by comanda.data,por_mes desc;
--k) Qual o ranking dos sabores doces mais pedidos por mês nos últimos 12 meses?
select 
strftime('%Y-%m',comanda.data) ano_mes,
case strftime('%m',comanda.data)
    when '01' then 'janeiro'
    when '02' then 'fevereiro'
    when '03' then 'marco'
    when '04' then 'abril'
    when '05' then 'maio'
    when '06' then 'junho'
    when '07' then 'julho'
    when '08' then 'agosto'
    when '09' then 'setembro'
    when '10' then 'outubro'
    when '11' then 'novembro'
    when '12' then 'dezembro'
end as mes_nome,
sabor.nome,count(sabor.nome) as por_mes
from comanda,pizza,pizzasabor,sabor,tipo 
where comanda.numero=pizza.comanda 
and pizzasabor.pizza=pizza.codigo 
and pizzasabor.sabor=sabor.codigo
and tipo.nome like "%doces%"
and sabor.tipo=tipo.codigo
and comanda.data between datetime('now','-12 months') and datetime('now')
group by ano_mes,sabor.nome
order by comanda.data,por_mes desc;
--l) Qual o ranking da quantidade de pizzas pedidas por tipo por tamanho nos últimos 6 meses?
select 
DISTINCT
tipo.nome as tipo,
pizza.tamanho as tamanho,
count(*) as pizzasp_tipop_tamanho
from comanda,pizza,pizzasabor,sabor,tipo
where pizza.comanda=comanda.numero and
pizzasabor.pizza=pizza.codigo AND
pizzasabor.sabor=sabor.codigo and
tipo.codigo=sabor.tipo and
comanda.data BETWEEN datetime('now','-6 months') and datetime('now') 
group by tipo.codigo,pizza.tamanho
order by pizzasp_tipop_tamanho desc;
--m) Qual o ranking dos ingredientes mais pedidos acompanhando cada borda nos últimos 6 meses?
--ingredientes mais pedidos + borda
