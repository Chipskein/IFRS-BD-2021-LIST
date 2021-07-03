/*Exercicio2*/
/*Cadastros*/
INSERT INTO usuario(name_user,cidade,estado,pais,register_date,email,user_pass,user_cod) values
                   ('Professor de BD','Rio Grande', 'RS', 'Brasil','2010-01-01 09:00','professorbd@gmail.com','**********',1),--1)
                   ('João Silva Brasil','Rio Grande', 'RS', 'Brasil','2020-01-01 13:00','joaosilva@gmail.com','**********',2),--2)
                   ('Pedro Alencar Pereira','Rio Grande', 'RS', 'Brasil','2020-01-01 13:05','alencarlindao@gmail.com','**********',3),--3)
                   ('Maria Cruz Albuquerque','Rio Grande', 'RS', 'Brasil','2020-01-01 13:10','garotagamer@gmail.com','**********',4),--4)
                   ('Joana Rosa Medeiros','Rio Grande', 'RS', 'Brasil','2020-01-01 13:15','btsminhavida@gmail.com','**********',5),--5)
                   ('Paulo Xavier Ramos','Rio Grande', 'RS', 'Brasil','2020-01-01 13:20','forcajovemdovasco@gmail.com','**********',6);--6)
/*Adiciona/vira amigo*/
INSERT INTO amizade(amizade_date,user_cod,friend_cod) values
                   ('2021-05-17 10:00',1,2),--7)
                   
                   ('2021-05-17 10:05',1,3),--8)
                   
                   ('2021-05-17 10:10',1,4),--9)
                   
                   ('2021-05-17 10:15',1,5),--10)
                   
                   ('2021-05-17 10:20',1,6);--11)
                   
                   --usuario campus rio grande
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

INSERT INTO reaction(user_cod,cod_post,reaction_date,reaction_msg) values
                    (3,1,'2021-06-02 15:05','curtir'),--13
                    (4,1,'2021-06-02 15:10','curtir');--14
INSERT INTO comentario(cod_comment,user_cod,cod_post,comment_date,comment_msg) values
                      (1,5,1,'2021-06-02 15:15','Alguém mais ficou com dúvida no comando INSERT');--15
INSERT INTO cmt_assunto(cod_comment,cod_assunto) values
                       (1,1),--15
                       (1,2),
                       (1,3);
INSERT INTO resposta(cod_resp,user_cod,cod_comment,resp_date,resp_msg) values
                    (1,6,1,'2021-06-02 15:20','Eu também');--16
INSERT INTO reaction(user_cod,cod_comment,reaction_date,reaction_msg) values
                    (6,1,'2021-06-02 15:20','triste');--17
INSERT INTO resposta(cod_resp,user_cod,cod_comment,resp_date,resp_msg) values
                    (2,2,1,'2021-06-02 15:30','Já agendaste horario de atendimento com o professor?');--18
INSERT INTO resp_assunto(cod_resp,cod_assunto) values 
                        (2,1),--18
                        (2,4);

/*
    TESTANDO outras tabelas
*/

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

