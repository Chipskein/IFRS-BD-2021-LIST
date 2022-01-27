/*Exercicio2*/
/*Cadastros*/
INSERT INTO usuario(name_user,cidade,estado,pais,register_date,email,user_pass,user_cod,qt_friends) values
                   ('Professor de BD','Rio Grande', 'RS', 'Brasil','2010-01-01 09:00','professorbd@gmail.com','**********',1,6),--1)
                   ('João Silva Brasil','Rio Grande', 'RS', 'Brasil','2020-01-01 13:00','joaosilva@gmail.com','**********',2,2),--2)
                   ('Pedro Alencar Pereira','Rio Grande', 'RS', 'Brasil','2020-01-01 13:05','alencarlindao@gmail.com','**********',3,3),--3)
                   ('Maria Cruz Albuquerque','Rio Grande', 'RS', 'Brasil','2020-01-01 13:10','garotagamer@gmail.com','**********',4,1),--4)
                   ('Joana Rosa Medeiros','Rio Grande', 'RS', 'Brasil','2020-01-01 13:15','btsminhavida@gmail.com','**********',5,2),--5)
                   ('Paulo Xavier Ramos','Rio Grande', 'RS', 'Brasil','2020-01-01 13:20','forcajovemdovasco@gmail.com','**********',6,2);--6)
/*Adiciona/vira amigo*/
INSERT INTO amizade(amizade_date,user_cod,friend_cod) values
                   ('2021-05-17 10:00',1,2),--7)
                   ('2021-05-17 10:00',2,1),
                   ('2021-05-17 10:05',1,3),--8)
                   ('2021-05-17 10:05',3,1),
                   ('2021-05-17 10:10',1,4),--9)
                   ('2021-05-17 10:10',4,1),
                   ('2021-05-17 10:15',1,5),--10)
                   ('2021-05-17 10:15',5,1),
                   ('2021-05-17 10:20',1,6),--11)
                   ('2021-05-17 10:20',6,1);
                 
INSERT INTO usuario(name_user,cidade,estado,pais,register_date,email,user_pass,user_cod) values
                    ('IFRS campus Rio Grande','Rio Grande','RS','Brasil','2010-01-01 00:00','campus@riogrande.ifrs.edu.br','*******',7);--12
--assunto
INSERT INTO assunto(cod_assunto,name_assunto) values
                   (1,'BD'),--12
                   (2,'SQLite'),--12
                   (3,'INSERT'),--15
                   (4,'atendimento');--18
--post                    
INSERT INTO post(cod_post,user_cod,post_msg,post_date,pais,estado,cidade) values
                (1,2,'Hojé aprendi como inserir dados no SQLite no IFRS','2021-06-02 15:00','Brasil','RS','Rio Grande'),--12
                (2,1,'Atendimento de BD no GMeet amanhã pra quem estiver com dúvidas de INSERT','2021-06-02 15:35','Brasil','RS','Rio Grande');--19        
--post_assunto
INSERT INTO post_assunto(cod_post,cod_assunto) values
                        (1,1),
                        (1,2),
                        (2,4),
                        (2,1),
                        (2,2),
                        (2,3);
--citação
INSERT INTO citacao(cod_post,user_cod) values
                   (1,7),
                   (2,5),
                   (2,6);
INSERT INTO compartilhamento(user_cod,cod_post,comp_date) values 
                            (2,2,'2021-06-02 15:40');--20

INSERT INTO reaction(user_cod,cod_post,reaction_date,reaction_msg,reaction_post_user_cod) values
                    (3,1,'2021-06-02 15:05','curtir',2),--13
                    (4,1,'2021-06-02 15:10','curtir',2);--14
INSERT INTO comentario(cod_comment,user_cod,cod_post,comment_date,comment_msg) values
                      (1,5,1,'2021-06-02 15:15','Alguém mais ficou com dúvida no comando INSERT');--15
INSERT INTO cmt_assunto(cod_comment,cod_assunto) values
                       (1,1),--15
                       (1,2),
                       (1,3);
INSERT INTO resposta(cod_resp,user_cod,cod_comment,resp_date,resp_msg) values
                    (1,6,1,'2021-06-02 15:20','Eu também');--16
INSERT INTO reaction(user_cod,cod_comment,reaction_date,reaction_msg,reaction_post_user_cod) values
                    (6,1,'2021-06-02 15:20','triste',5);--17
INSERT INTO resposta(cod_resp,user_cod,cod_comment,resp_date,resp_msg) values
                    (2,2,1,'2021-06-02 15:30','Já agendaste horario de atendimento com o professor?');--18
INSERT INTO resp_assunto(cod_resp,cod_assunto) values 
                        (2,1),--18
                        (2,4);
INSERT INTO pagina(cod_pagina,name_pagina) values
                  (1,'trutas'),
                  (2,'carros tunados'),
                  (3,'cheat cartown');
INSERT INTO criar_pagina(user_cod,cod_pagina) values
                        (3,1),
                        (3,2),
                        (3,3);
INSERT INTO curtir_pagina(user_cod,cod_pagina) values
                         (2,2),
                         (4,3);
INSERT INTO grupo(cod_group,name_group) values 
                 (1,'Turma BD'),
                 (2,'Turma BD 2 ano');
INSERT INTO criar_grupo(cod_group,user_cod)values
                       (1,1),
                       (2,1);
INSERT INTO participa_grupo(cod_group,user_cod) values
                           (1,1),
                           (2,1),
                           (1,2);
insert into usuario values 
(8,'ascax@hotmail.com',null,'****','BETATESTER1',current_timestamp,'Brasil','SP','Sao paulo',3),
(9,'asfas@email.com',null,'***','betatester2',current_timestamp,'Brasil','SP','campinas',0),
(10,'asfa@emai.com',null,'afas','BETATESTER3',current_timestamp,'Brasil','RJ','Rio de Janeiro',0),
(11,'afds412412a@mail.com',null,'!1234124','betatester5',current_timestamp,'Brasil','RJ','Rio de Janeiro',0),
(12,'afdsfasfa@mail.com',null,'!1234124','betatester6',current_timestamp,'Brasil','RS','Sao jose do norte',3),
(13,'afdsaszzfa@mail.com',null,'!1234124','betatester7',current_timestamp,'Brasil','RS','Sao leopoldo',1);
insert into post (cod_post,post_msg,user_cod,pais,estado,cidade)values
(3,'lorem ipsulun',4,'Brasil','RS','Rio Grande'),
(4,'afsfasasgadgas',5,'Brasil','RS','Rio Grande'),
(5,'lorem ipsulun',8,'Brasil','SP','São Paulo'),
(6,'lorem ipsulun',9,'Brasil','SP','campinas'),
(7,'lorem ipsulun',10,'Brasil','RJ','Rio de Janeiro'),
(8,'lorem ipsulun',11,'Brasil','RJ','Rio de Janeiro'),
(9,'afsfasasgadgas',5,'Brasil','RS','Rio Grande');

insert into amizade values
(8,1,current_timestamp),
(1,8,current_timestamp),

(8,2,current_timestamp),
(2,8,current_timestamp),

(8,3,current_timestamp),
(3,8,current_timestamp),

(12,5,current_timestamp),
(5,12,current_timestamp),

(12,6,current_timestamp),
(6,12,current_timestamp),

(12,9,current_timestamp),
(9,12,current_timestamp);

insert into reaction values
        (2,4,null,null,'curtir',current_timestamp,5),
        (3,4,null,null,'curtir',current_timestamp,5),
        (4,9,null,null,'curtir',current_timestamp,5),
        (4,9,null,null,'curtir',current_timestamp,5),
        (8,4,null,null,'curtir',current_timestamp,5),
        (9,9,null,null,'curtir',current_timestamp,5),
        (7,4,NULL,NULL,'wow','2021-07-03 15:51:16',5),
        (10,9,NULL,NULL,'wow','2021-07-03 15:51:16',5),
        (11,9,NULL,NULL,'triste','2021-07-03 15:51:16',5),
        (12,4,NULL,NULL,'odiei','2021-07-03 15:51:16',5),
        (1,9,NULL,NULL,'risos','2021-07-03 15:51:16',5);