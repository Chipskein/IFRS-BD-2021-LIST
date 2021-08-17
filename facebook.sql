DROP TABLE IF EXISTS classificacaoPost;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS classificacao;
DROP TABLE IF EXISTS paginaPerfil;
DROP TABLE IF EXISTS grupoPerfil;
DROP TABLE IF EXISTS reaction;
DROP TABLE IF EXISTS citacao;
DROP TABLE IF EXISTS compartilhamento;
DROP TABLE IF EXISTS assuntoPost;
DROP TABLE IF EXISTS assunto;
DROP TABLE IF EXISTS pagina;
DROP TABLE IF EXISTS grupo;
DROP TABLE IF EXISTS amigo;
DROP TABLE IF EXISTS perfil;

CREATE TABLE perfil (
        email varchar(100) not null,
        nome varchar(100) not null,
        senha varchar(20) not null,
        estado char(2) not null,
        cidade varchar(100) not null,
        pais varchar(100) not null,
        status varchar(10) CHECK(status='ativado' or status='desativado') not null, --add para questao c)
        data datetime,
        nascimento date, --adicionado para letra j)
        genero char(1) CHECK(genero='M' or genero='F' or genero is null),--adicionada para letra j),genero is null qualquer coisa que não seja H ou M
        primary key (email)
);
INSERT INTO perfil VALUES('den@ifrs.riogrande.edu.br','IFRS Campus Rio Grande','12345','RS','Rio Grande','Brasil', 'ativado','2010-01-01 08:00','1921-07-30',NULL);
INSERT INTO perfil VALUES('professor@hotmail.com','Professor de BD','12345','RS','Rio Grande','Brasil', 'ativado','2010-01-01 09:00','1981-07-30','M');
INSERT INTO perfil VALUES('joaosbras@mymail.com','João Silva Brasil','42345','RS','Rio Grande','Brasil', 'ativado','2020-01-01 13:00','1991-07-30','M');
INSERT INTO perfil VALUES('pedro@gmail.com','Pedro Alencar Pereira','2345','RS','Rio Grande','Brasil', 'ativado','2020-01-01 13:05','2001-07-30','M');
INSERT INTO perfil VALUES('mcalbuq@mymail.com','Maria Cruz Albuquerque','823456','RS','Rio Grande','Brasil', 'ativado','2020-01-01 13:10','1985-07-30','F');
INSERT INTO perfil VALUES('jorosamed@mymail.com','Joana Rosa Medeiros','1234','RS','Rio Grande','Brasil', 'ativado','2020-01-01 13:15','1995-07-30','F');
INSERT INTO perfil VALUES('pxramos@mymail.com','Paulo Xavier Ramos','123','RS','Rio Grande','Brasil', 'ativado','2020-01-01 13:20','1974-07-30','M');
INSERT INTO perfil VALUES('pele@cbf.com.br','Edson Arantes do Nascimento','*****','RJ','Rio de Janeiro','Brasil', 'ativado','2009-01-01 13:20','2002-07-30','M');
INSERT INTO perfil VALUES('pmartinssilva90@mymail.com','Paulo Martins Silva','*****','SP','Jundiai','Brasil', 'ativado','2010-01-01 13:20','1950-07-30','M');
INSERT INTO perfil VALUES('paulafernandes@mymail.com','Paula Fernandes Amaral','*****','MG','Tambaú','Brasil', 'ativado','2010-01-01 13:20','1999-08-30','F');
INSERT INTO perfil VALUES('marciasilva@mymail.com','Marcia Silva','*****','MG','Tambaú','Brasil', 'ativado','2010-01-01 13:20','2001-07-30','F');
INSERT INTO perfil VALUES('jessicabtstop@mymail.com','Jessica Kpopper','*****','PR','Apucarana','Brasil', 'ativado','2010-01-01 13:20','2000-05-23','F');
INSERT INTO perfil VALUES('pequenopedrinho@mymail.com','Pedrinho','*****','PR','Apucarana','Brasil', 'ativado','2010-01-01 13:20','2002-01-03','M');
INSERT INTO perfil VALUES('M&M@mymail.com','Marcinha','*****','BUE','Buenos aires','Argentina', 'ativado','2010-01-01 13:20','2001-07-30','F');
INSERT INTO perfil VALUES('Flash@mymail.com','Flash','*****','BUE','Buenos aires','Argentina', 'ativado','2010-01-01 13:20','2000-05-23','F');
INSERT INTO perfil VALUES('ciclope@mymail.com','ciclope','*****','WAS','Washington','EUA', 'ativado', '2010-01-01 13:20','2002-01-03','M');
CREATE TABLE amigo (
        perfilAmigo varchar(100) not null,
        perfil varchar(100) not null,
        data datetime,
        foreign key (perfil) references perfil(email),
        primary key (perfilAmigo, perfil)
);
INSERT INTO amigo VALUES('joaosbras@mymail.com','professor@hotmail.com','2021-05-17 10:00');
INSERT INTO amigo VALUES('pedro@gmail.com','professor@hotmail.com','2021-05-17 10:05');
INSERT INTO amigo VALUES('mcalbuq@mymail.com','professor@hotmail.com','2021-05-17 10:10');
INSERT INTO amigo VALUES('jorosamed@mymail.com','professor@hotmail.com','2021-05-17 10:15');
INSERT INTO amigo VALUES('pxramos@mymail.com','professor@hotmail.com','2021-05-17 10:20');
INSERT INTO amigo VALUES('jessicabtstop@mymail.com','mcalbuq@mymail.com','2021-05-17 10:10');
INSERT INTO amigo VALUES('pequenopedrinho@mymail.com','mcalbuq@mymail.com','2021-05-17 10:10');
INSERT INTO amigo VALUES('pxramos@mymail.com','joaosbras@mymail.com','2021-05-17 10:40');
INSERT INTO amigo VALUES('jorosamed@mymail.com','joaosbras@mymail.com','2021-05-18 10:40');
CREATE TABLE grupo (
        codigo integer not null,
        nome varchar(100) not null,
        primary key (codigo)
);
INSERT INTO grupo VALUES(1,'Banco de Dados-IFRS2021');
INSERT INTO grupo VALUES(2,'SQlite');
CREATE TABLE pagina (
        codigo integer not null,
        nome varchar(100) not null,
        primary key (codigo)
);
CREATE TABLE assunto(
        codigo integer not null,
        nome varchar(100),
        primary key (codigo)
);
INSERT INTO assunto VALUES(1,'BD');
INSERT INTO assunto VALUES(2,'INSERT');
INSERT INTO assunto VALUES(3,'SQLite');
INSERT INTO assunto VALUES(4,'atendimento');
INSERT INTO assunto VALUES(5,'Paulao lindo');
INSERT INTO assunto VALUES(6,'deus grego');
INSERT INTO assunto VALUES(7,'100% jesus');
INSERT INTO assunto VALUES(8,'select');

CREATE TABLE grupoPerfil (
        grupo integer not null,
        perfil varchar(100) not null,
        foreign key (perfil) references perfil(email),
        foreign key (grupo) references grupo(codigo),
        primary key (grupo,perfil)
);
INSERT INTO grupoPerfil VALUES(1,'professor@hotmail.com');
INSERT INTO grupoPerfil VALUES(1,'joaosbras@mymail.com');
INSERT INTO grupoPerfil VALUES(1,'mcalbuq@mymail.com');
INSERT INTO grupoPerfil VALUES(1,'pxramos@mymail.com');
INSERT INTO grupoPerfil VALUES(1,'jorosamed@mymail.com');
INSERT INTO grupoPerfil VALUES(2,'professor@hotmail.com');
INSERT INTO grupoPerfil VALUES(2,'joaosbras@mymail.com');
INSERT INTO grupoPerfil VALUES(2,'mcalbuq@mymail.com');
INSERT INTO grupoPerfil VALUES(2,'pxramos@mymail.com');
INSERT INTO grupoPerfil VALUES(2,'jorosamed@mymail.com');
INSERT INTO grupoPerfil VALUES(1,'pedro@gmail.com');
CREATE TABLE paginaPerfil (
        pagina integer not null,
        perfil varchar(100) not null,
        foreign key (perfil) references perfil(email),
        foreign key (pagina) references pagina(codigo),
        primary key (pagina,perfil)
);
CREATE TABLE classificacao (
        nome varchar(20) not null,
        cod integer not null,
        primary key(cod)
);
INSERT INTO classificacao values('odioso',1);
INSERT INTO classificacao values('comercial',2);
INSERT INTO classificacao values('fake_news',3);
INSERT INTO classificacao values('verificado',4);
CREATE TABLE post (
        codigo integer not null,
        texto varchar(1000),
        perfil varchar(100) not null,
        grupo  integer,
        pagina integer,
        postagem integer,
        data datetime,
        foreign key (perfil) references perfil(email),
        foreign key (grupo) references grupo(codigo),
        foreign key (pagina) references pagina(codigo),
        primary key (codigo)
);
INSERT INTO post VALUES(1,'Hoje eu aprendi como inserir dados no SQLite no IFRS','joaosbras@mymail.com',NULL,NULL,NULL,'2021-06-02 15:00');
INSERT INTO post VALUES(2,'Atendimento de BD no GMeet amanhã para quem tiver dúvidas de INSERT','professor@hotmail.com',NULL,NULL,NULL,'2021-06-02 15:35');
INSERT INTO post VALUES(3,'salve salve familia aqui é o paulao','pmartinssilva90@mymail.com',NULL,NULL,NULL,'2021-07-28 18:53:56');
INSERT INTO post VALUES(4,'paulão é rei po','pmartinssilva90@mymail.com',NULL,NULL,NULL,'2021-07-27 18:53:56');
INSERT INTO post VALUES(5,'Sqlite é muito tb hahahah','mcalbuq@mymail.com',2,NULL,NULL,'2021-07-27 18:53:56');
INSERT INTO post VALUES(6,'SQlite top topotpotpto muito top','jorosamed@mymail.com',2,NULL,NULL,'2021-07-27 18:53:56');
INSERT INTO post VALUES(7,'SQlite hahahahah go birrrl','professor@hotmail.com',2,NULL,NULL,'2021-07-27 18:53:56');
INSERT INTO post VALUES(8,'çafasfasfa','professor@hotmail.com',2,NULL,NULL,'2021-07-27 18:53:56');
INSERT INTO post VALUES(9,'eU sOu GAymer ksksks guys','pequenopedrinho@mymail.com',NULL,NULL,NULL,'2021-07-26 18:53:56');
INSERT INTO post VALUES(10,'salve rapeize','marciasilva@mymail.com',NULL,NULL,NULL,'2021-07-27 18:53:56');
INSERT INTO post VALUES(11,'Alguém mais ficou com dúvida no comando INSERT?','pedro@gmail.com',NULL,NULL,1,'2021-06-02 15:15');
INSERT INTO post VALUES(12,'Eu também','jorosamed@mymail.com',NULL,NULL,1,'2021-06-02 15:20');
INSERT INTO post VALUES(13,'Já agendaste horário de atendimento com o professor?','joaosbras@mymail.com',NULL,NULL,1,'2021-06-02 15:30');
INSERT INTO post VALUES(14,'salve salve familia','pele@cbf.com.br',NULL,NULL,5,'2021-07-29 18:53:56');
INSERT INTO post VALUES(15,'Eu não','ciclope@mymail.com',NULL,NULL,1,'2021-06-02 15:20');
INSERT INTO post VALUES(16,'Já agendaste horário de atendimento com o betito?','M&M@mymail.com',NULL,NULL,NULL,'2021-06-02 15:30');
INSERT INTO post VALUES(17,'salve salve familia','M&M@mymail.com',NULL,NULL,5,'2021-07-29 19:21:53');
INSERT INTO post VALUES(18,'select o seu destino','professor@hotmail.com',NULL,NULL,NULL,'2021-08-09 00:03:42');
INSERT INTO post VALUES(19,'hahah engraçadao','jorosamed@mymail.com',NULL,NULL,18,'2021-08-09 00:03:42');
INSERT INTO post VALUES(20,'num creio ksksks','pele@cbf.com.br',NULL,NULL,18,'2021-08-09 00:03:42');
INSERT INTO post VALUES(21,'select é carioca','mcalbuq@mymail.com',NULL,NULL,NULL,'2021-08-09 00:07:09');
INSERT INTO post VALUES(22,'hahah engraçadao','jorosamed@mymail.com',NULL,NULL,18,'2021-08-09 00:07:09');
INSERT INTO post VALUES(23,'hahah engraçadao','jorosamed@mymail.com',NULL,NULL,21,'2021-08-09 00:07:33');
INSERT INTO post VALUES(24,'Brasil: 20 medalhas nas Olimpíadas 2020/2021 em Tóquio','pele@cbf.com.br',NULL,NULL,21,'2021-08-12 00:17:33');
INSERT INTO post VALUES(25,'hahah engraçadao','jorosamed@mymail.com',2,NULL,21,'2021-08-09 00:07:33');
CREATE TABLE assuntoPost(
        assunto integer not null,
        post integer not null,
        foreign key (assunto) references assunto(codigo),
        foreign key (post) references post(codigo),
        primary key (post, assunto)
        );
INSERT INTO assuntoPost VALUES(1,1);
INSERT INTO assuntoPost VALUES(2,1);
INSERT INTO assuntoPost VALUES(1,2);
INSERT INTO assuntoPost VALUES(2,2);
INSERT INTO assuntoPost VALUES(3,2);
INSERT INTO assuntoPost VALUES(4,2);
INSERT INTO assuntoPost VALUES(1,3);
INSERT INTO assuntoPost VALUES(5,3);
INSERT INTO assuntoPost VALUES(6,3);
INSERT INTO assuntoPost VALUES(7,3);
INSERT INTO assuntoPost VALUES(6,4);
INSERT INTO assuntoPost VALUES(7,4);
INSERT INTO assuntoPost VALUES(1,8);
INSERT INTO assuntoPost VALUES(1,9);
INSERT INTO assuntoPost VALUES(1,10);
INSERT INTO assuntoPost VALUES(3,15);
INSERT INTO assuntoPost VALUES(5,16);
INSERT INTO assuntoPost VALUES(3,16);
INSERT INTO assuntoPost VALUES(1,17);
INSERT INTO assuntoPost VALUES(4,17);
INSERT INTO assuntoPost VALUES(1,15);
INSERT INTO assuntoPost VALUES(6,15);
INSERT INTO assuntoPost VALUES(2,17);
INSERT INTO assuntoPost VALUES(3,17);
INSERT INTO assuntoPost VALUES(8,18);
INSERT INTO assuntoPost VALUES(8,20);
INSERT INTO assuntoPost VALUES(8,21);
CREATE TABLE compartilhamento(
        perfil varchar(100) not null,
        codigo_post integer not null,
        data_compartilhamento datetime DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (perfil) REFERENCES perfil(email),
        FOREIGN KEY (codigo_post) REFERENCES post(codigo)
);
INSERT INTO compartilhamento VALUES('joaosbras@mymail.com',2,'2021-06-02 15:40');
INSERT INTO compartilhamento VALUES('joaosbras@mymail.com',3,'2021-07-19 13:03:42');
INSERT INTO compartilhamento VALUES('joaosbras@mymail.com',4,'2021-07-19 14:03:42');
CREATE TABLE citacao (
        codigo integer not null,
        perfil varchar(100) not null,
        post integer not null,
        foreign key (post) references post(codigo),
        foreign key (perfil) references perfil(email),
        primary key (codigo)
);
INSERT INTO citacao VALUES(1,'den@ifrs.riogrande.edu.br',1);
INSERT INTO citacao VALUES(2,'jorosamed@mymail.com',2);
INSERT INTO citacao VALUES(3,'pxramos@mymail.com',2);
CREATE TABLE reaction(
        codigo integer not null,
        texto varchar(7) CHECK(texto='gostei' or texto='amei' or texto='risos' or texto='triste'),
        perfil varchar(100) not null,
        postagem integer,
        data datetime DEFAULT CURRENT_TIMESTAMP,
        foreign key (perfil) references perfil(email),
        foreign key (postagem) references post(codigo)
        primary key (codigo)
);
INSERT INTO reaction VALUES(1,'gostei','pedro@gmail.com',1,'2021-06-02 15:05');
INSERT INTO reaction VALUES(2,'gostei','mcalbuq@mymail.com',1,'2021-06-02 15:10');
INSERT INTO reaction VALUES(3,'triste','pxramos@mymail.com',1,'2021-06-02 15:20');
INSERT INTO reaction VALUES(4,'gostei','pele@cbf.com.br',1,'2021-07-19 14:03:43');
INSERT INTO reaction VALUES(5,'gostei','pxramos@mymail.com',5,'2021-06-02 15:20');
INSERT INTO reaction VALUES(6,'triste','pele@cbf.com.br',6,'2021-07-19 14:03:43');
INSERT INTO reaction VALUES(7,'gostei','pedro@gmail.com',6,'2021-06-02 15:05');
INSERT INTO reaction VALUES(8,'gostei','mcalbuq@mymail.com',5,'2021-06-02 15:10');
INSERT INTO reaction VALUES(9,'gostei','pedro@gmail.com',8,'2021-07-16 15:05');
INSERT INTO reaction VALUES(10,'gostei','mcalbuq@mymail.com',8,'2021-07-16 15:10');
INSERT INTO reaction VALUES(11,'gostei','pxramos@mymail.com',8,'2021-07-16 15:12');
INSERT INTO reaction VALUES(12,'gostei','pedro@gmail.com',2,'2021-07-17 15:05');
INSERT INTO reaction VALUES(13,'gostei','pxramos@mymail.com',2,'2021-07-17 15:15');
INSERT INTO reaction VALUES(14,'amei','pedro@gmail.com',2,'2021-07-16 15:05');
INSERT INTO reaction VALUES(15,'amei','pedro@gmail.com',3,'2021-07-16 15:05');
INSERT INTO reaction VALUES(16,'amei','pedro@gmail.com',8,'2021-07-16 15:05');
INSERT INTO reaction VALUES(17,'amei','pedro@gmail.com',9,'2021-07-16 15:05');
INSERT INTO reaction VALUES(18,'amei','mcalbuq@mymail.com',2,'2021-07-16 15:10');
INSERT INTO reaction VALUES(19,'gostei','pedro@gmail.com',5,'2021-07-16 15:05');
INSERT INTO reaction VALUES(20,'gostei','mcalbuq@mymail.com',5,'2021-07-16 15:10');
INSERT INTO reaction VALUES(21,'gostei','pxramos@mymail.com',5,'2021-07-16 15:12');
INSERT INTO reaction VALUES(22,'gostei','pxramos@mymail.com',25,'2021-07-16 15:12');
CREATE TABLE classificacaoPost (
        post integer not null,
        classificacao integer not null,
        FOREIGN KEY (post) REFERENCES post(codigo),
        FOREIGN KEY (classificacao) REFERENCES classificacao(cod)
);

INSERT INTO classificacaoPost values(9,1);
INSERT INTO classificacaoPost values(24,3);
INSERT INTO classificacaoPost values(4,4);
INSERT INTO classificacaoPost values(5,4);
INSERT INTO classificacaoPost values(6,4);
INSERT INTO classificacaoPost values(7,4);
INSERT INTO classificacaoPost values(8,4);
INSERT INTO classificacaoPost values(25,4);
