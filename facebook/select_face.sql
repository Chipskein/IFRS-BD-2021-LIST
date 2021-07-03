
/*
1) Escreva comandos select, utilizando as tabelas para uma rede social criadas nas listas de
exercícios anteriores, para responder as perguntas:
* Todas as perguntas devem ser respondidas com 1 comando select que acessa apenas 1 tabela.
Se sua modelagem não permite isto, ajuste sua modelagem!
*/
--a) Quais os assuntos da postagem do usuário João Silva Brasil, em Rio Grande, RS, Brasil às 15:00 de 02/06/2021?
SELECT cod_assunto AS assuntos_joao_silva FROM post_assunto WHERE cod_post=1;--a
--b) Quantos usuários curtiram a postagem do usuário João Silva Brasil, em Rio Grande, RS, Brasil às 15:00 de 02/06/2021?
SELECT COUNT(*) AS curtidas_post_joaodsilva FROM reaction WHERE cod_post=1 AND reaction_msg='curtir'; --b
--c) Quantas postagens o usuário João Silva Brasil realizou nos últimos 30 dias?
SELECT COUNT(*) AS post_joaodasilva_last30days FROM post  WHERE user_cod=2 AND post_date BETWEEN DATETIME('now','-30 days') AND CURRENT_TIMESTAMP;--c
--d) Quando foi a última postagem do usuário Maria Cruz Albuquerque?
SELECT post_date AS last_post_mariacruz FROM post WHERE user_cod=4 ORDER BY post_date DESC LIMIT 1 OFFSET 0;--d

--e) Quantos usuários realizaram mais de 50 postagens no Brasil nos últimos 30 dias?
select count(count(user_cod)) over() as total_users_50_posts from post where post_date between datetime('now','-30 days') and current_timestamp group by user_cod having count(user_cod) > 50 limit 1;
--f) Qual o ranking da quantidade de postagens por dia da semana no Brasil nos últimos 7 dias?
select  
CASE strftime('%w',post_date)
    WHEN '0' THEN 'domingo'
    WHEN '1' THEN 'segunda'
    WHEN '2' THEN 'terca'
    WHEN '3' THEN 'quarta'
    WHEN '4' THEN 'quinta'
    WHEN '5' THEN 'sexta'
    WHEN '6' THEN 'sabado'
END AS dia,
count(*) as qt_post_last_7days 
from post 
where pais='Brasil' and post_date between datetime('now','-7 days') and datetime('now') 
group by dia 
order by qt_post_last_7days;
--g) Qual o ranking da quantidade de usuários por cidade do RS?
select cidade,count(*) as user_by_city from usuario where estado='RS' group by cidade order by user_by_city desc;
--h) Qual o ranking da quantidade de usuários por estado no Brasil?
select estado,count(*) as user_by_state from usuario group by estado order by user_by_state desc;
--i) Quantos usuários possuem mais de 100 amigos?
select count(count(user_cod))  over() as user_with_100more_frined from amizade group by user_cod having count(user_cod)>100 limit 1;
--j) Quantos usuários possuem mais de 100 amigos por estado do Brasil?
--k) Quantos usuários novos se cadastraram nos últimos 12 meses no Brasil?
select count(*) from usuario where pais='Brasil' and register_date between datetime('now','-12 months') and current_timestamp;
--l) Quantas postagens foram realizadas por dia no Brasil nos últimos 3 meses?
select date(post_date),count(*) as post_por_dia from post where pais='Brasil' and post_date between datetime('now','-3 months') and datetime('now') group by date(post_date);
--m) Qual a quantidade média de curtidas nas postagens do usuário Joana Rosa Medeiros nos últimos 3 meses?
--n) Quantos usuários não realizaram postagem nos últimos 12 meses?

/*2) Descreva e justifique as adequações/alterações que foram realizadas nas tabelas criadas para
uma rede social nas listas de exercícios anteriores para que o exercício 1 acima pudesse ser
resolvido.
**Adicionado
    *post(cidade,estado,pais)
    -para cumprir as letras e,f é necessário que a tabela post receba a cidade,o estado e o pais.
    *reaction_post_user_cod
    
*/
   
   
 
insert into usuario values 
(8,'ascax@hotmail.com',null,'****','BETATESTER1',current_timestamp,'Brasil','SP','Sao paulo'),
(9,'asfas@email.com',null,'***','betatester2',current_timestamp,'Brasil','SP','campinas'),
(10,'asfa@emai.com',null,'afas','BETATESTER3',current_timestamp,'Brasil','RJ','Pau Grande'),
(12,'afds412412a@mail.com',null,'!1234124','betatester5',current_timestamp,'Brasil','RS','São jose do norte'),
(13,'afdsfasfa@mail.com',null,'!1234124','betatester6',current_timestamp,'Brasil','RS','São jose do norte'),
(14,'afdsaszzfa@mail.com',null,'!1234124','betatester7',current_timestamp,'Brasil','RS','São leopoldo');
insert into post values
(3,current_timestamp,'lorem ipsulun',4,'Brasil','RS','Rio Grande'),
(4,current_timestamp,'afsfasasgadgas asfasfa ',5,'Brasil','RS','Rio Grande'),
(5,current_timestamp,'lorem ipsulun',8,'Brasil','SP','São Paulo'),
(6,current_timestamp,'lorem ipsulun',9,'Brasil','SP','campinas'),
(7,current_timestamp,'lorem ipsulun',10,'Brasil','RJ','Pau Grande'),
(8,current_timestamp,'lorem ipsulun',11,'Brasil','RJ','Rio de Janeiro'),
(9,current_timestamp,'lorem ipsulun',5,'Brasil','RS','Rio Grande')

insert into amizade values
(8,1,current_timestamp),(8,2,current_timestamp),(8,3,current_timestamp),
(12,5,current_timestamp),(12,6,current_timestamp),(12,9,current_timestamp);

insert into reaction values
        (8,4,null,null,'curtir',current_timestamp),
        (9,9,null,null,'curtir',current_timestamp);
