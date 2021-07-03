/*3*/
--a) Quantas pizzas foram pedidas pela comanda 235?
SELECT COUNT(*) AS pizza_comanda235 FROM pizza WHERE comanda=235 ;
--b) Quantas pizzas de tamanho grande ou família foram pedidas pela comanda 235?
SELECT COUNT(*) AS pizza_comanda235_tamanho FROM pizza WHERE comanda=235 AND (tamanho='G' OR tamanho='F');
--c) Qual a quantidade de comandas não pagas na última semana(ultima semana != semana passada)
SELECT COUNT(*) AS comanda_npaga_lastweek FROM comanda WHERE pago=0 AND data BETWEEN DATE('now','weekday 0','-7 days') AND DATE('now','weekday 0');
--d) Quantos ingredientes possui o sabor margherita, sabendo que o código do sabor margherita é 123?
SELECT COUNT(*) AS qt_ingredientes_margherita FROM saboringrediente WHERE sabor=123 ;
--e) Quantos sabores contém o ingrediente catupiri, sabendo que o código do ingrediente catupiri é 234?
SELECT COUNT(*) AS qt_sabores_catupiri FROM saboringrediente WHERE ingrediente=234 ;
--f) Qual a quantidade média de ingredientes por sabor?
/*
      considerando media de ingredientes por sabor=quantidade de ingredientes agrupados por sabor/quantidade total de ingredientes
      não é possivel apenas com um select,pois para acessar o total de ingredientes será necessário fazer um sub select 
      com subselect:
      select sabor,
             cast(count(*) as real)/cast((select count(*) from saboringrediente) as real) as media_por_sabor 
             from saboringrediente 
             group by sabor;
  */
--g) Quantos sabores possuem mais de 8 ingredientes?
SELECT  
COUNT(COUNT(sabor)) OVER() AS qt_sabores_ingredientes_mais8
FROM saboringrediente 
GROUP BY sabor
HAVING COUNT(sabor)>8 LIMIT 1;
--solução adaptada de https://stackoverflow.com/questions/12927268/sum-of-grouped-count-in-sql-query?answertab=votes#tab-top

--h) Quantos sabores doces possuem mais de 8 ingredientes?
    /*
      não é possivel com apenas um select,pois para isso seria necessário acessar a tabela sabor 
      por meio de um subselect para verificar o seu tipo.
    */

--i) Qual a quantidade de comandas por dia nos últimos 15 dias?
SELECT 
STRFTIME('%Y',data) AS ano,
STRFTIME('%m',data) AS mes,
STRFTIME('%d',data) AS dia,
COUNT(*) AS comanda_por_dia 
FROM comanda 
WHERE data BETWEEN DATE('now','-15 days') AND CURRENT_DATE 
GROUP BY dia;
--j) Quais dias tiveram mais de 10 comandas nos últimos 15 dias?
SELECT 
STRFTIME('%Y',data) AS ano,
STRFTIME('%m',data) AS mes,
STRFTIME('%d',data) AS dia,
COUNT(*) AS comanda_por_dia_maisde10 
FROM comanda 
WHERE data BETWEEN DATE('now','-15 days') AND CURRENT_DATE 
GROUP BY  dia 
HAVING comanda_por_dia_maisde10>10;
--k) Qual o ranking da quantidade de comandas por dia da semana em julho de 2020?
SELECT 
CASE strftime('%w',data)
    WHEN '0' THEN 'domingo'
    WHEN '1' THEN 'segunda'
    WHEN '2' THEN 'terca'
    WHEN '3' THEN 'quarta'
    WHEN '4' THEN 'quinta'
    WHEN '5' THEN 'sexta'
    WHEN '6' THEN 'sabado'
END AS dia_semana,
COUNT(*) as comandas_por_dia_semana 
FROM comanda 
WHERE data BETWEEN DATE('2020-06-01') AND DATE('2020-06-31') 
GROUP BY dia_semana 
ORDER BY comandas_por_dia_semana desc;
--l) Qual o ranking da quantidade de comandas por dia da semana no mês passado?
SELECT 
CASE strftime('%w',data)
    WHEN '0' THEN 'domingo'
    WHEN '1' THEN 'segunda'
    WHEN '2' THEN 'terca'
    WHEN '3' THEN 'quarta'
    WHEN '4' THEN 'quinta'
    WHEN '5' THEN 'sexta'
    WHEN '6' THEN 'sabado'
END AS dia_semana,
COUNT(*) as comandas_por_dia_semana 
FROM comanda 
WHERE data BETWEEN DATE('now','start of month','-1 months') AND DATE('now','start of month','-1 days') 
GROUP BY dia_semana 
ORDER BY comandas_por_dia_semana desc;

--m) Quais dias da semana tiveram menos de 20 comandas no mês passado?
SELECT 
CASE strftime('%w',data)
    WHEN '0' THEN 'domingo'
    WHEN '1' THEN 'segunda'
    WHEN '2' THEN 'terca'
    WHEN '3' THEN 'quarta'
    WHEN '4' THEN 'quinta'
    WHEN '5' THEN 'sexta'
    WHEN '6' THEN 'sabado'
END AS dia_semana,
COUNT(*) as comandas_por_dia_semana 
FROM comanda 
WHERE data BETWEEN DATE('now','start of month','-1 months') AND DATE('now','start of month','-1 days') 
GROUP BY dia_semana 
HAVING comandas_por_dia_semana<20;

--n) Qual o ranking dos sabores mais pedidos nos últimos 15 dias?
    /*
      acessando apenas uma tabela não é possivel,os sabores das pizzas(pedidas) estão armazenados em uma 
      tabela auxiliar na qual contém o codigo da pizza pedida,a partir 
      deste codigo acessamos a sua comanda que contém a data do pedido.
    */
--o) Qual o valor a pagar da comanda 315?
    /*
      não é possivel,pois o preço é acessado a partir do tipo e 
      tamanho da pizza,não pela comanda    
    */

