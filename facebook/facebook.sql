/*1*/
drop table if exists amigo;
drop table if exists reaction;
drop table if exists comentario;
drop table if exists citacao;
drop table if exists compartilhamento;
drop table if exists assuntopost;
drop table if exists assunto;
drop table if exists post;
drop table if exists grupoperfil;
drop table if exists paginaperfil;
drop table if exists grupo;
drop table if exists pagina;
drop table if exists perfil;
create table perfil (
	email varchar(100) not null,
	nome varchar(100) not null,
	senha varchar(20) not null,
	estado char(2) not null,
	cidade varchar(100) not null,
	pais varchar(100) not null,
	data datetime,
	nascimento date, --adicionado para letra j)
	genero char(1) CHECK(genero='M' or genero='F' or genero is null),--adicionada para letra j),genero is null qualquer coisa que não seja H ou M
	primary key (email)
);
insert into perfil (email, senha, nome, cidade, estado, pais, data,nascimento,genero) values
	('den@ifrs.riogrande.edu.br', '12345','IFRS Campus Rio Grande', 'Rio Grande', 'RS', 'Brasil','2010-01-01 08:00', '1921-07-30',NULL),
	('professor@hotmail.com', '12345','Professor de BD', 'Rio Grande', 'RS', 'Brasil','2010-01-01 09:00', '1981-07-30','M'),
	('joaosbras@mymail.com', '42345','João Silva Brasil', 'Rio Grande', 'RS', 'Brasil','2020-01-01 13:00', '1991-07-30','M'),
	('pedro@gmail.com', '2345','Pedro Alencar Pereira', 'Rio Grande', 'RS', 'Brasil','2020-01-01 13:05', '2001-07-30','M'),
	('mcalbuq@mymail.com', '823456','Maria Cruz Albuquerque', 'Rio Grande', 'RS', 'Brasil','2020-01-01 13:10', '1985-07-30','F'),
	('jorosamed@mymail.com', '1234','Joana Rosa Medeiros', 'Rio Grande', 'RS', 'Brasil','2020-01-01 13:15', '1995-07-30','F'),
	('pxramos@mymail.com', '123','Paulo Xavier Ramos', 'Rio Grande', 'RS', 'Brasil','2020-01-01 13:20', '1974-07-30','M'),
	('pele@cbf.com.br', '*****','Edson Arantes do Nascimento', 'Rio de Janeiro', 'RJ', 'Brasil','2009-01-01 13:20', '2002-07-30','M'),
	('pmartinssilva90@mymail.com', '*****','Paulo Martins Silva', 'Jundiai', 'SP', 'Brasil','2010-01-01 13:20', '1950-07-30','M'),
	('paulafernandes@mymail.com', '*****','Paula Fernandes Amaral', 'Tambaú', 'MG', 'Brasil','2010-01-01 13:20', '1999-08-30','F'),
	('marciasilva@mymail.com', '*****','Marcia Silva', 'Tambaú', 'MG', 'Brasil','2010-01-01 13:20', '2001-07-30','F'),
	('jessicabtstop@mymail.com', '*****','Jessica Kpopper', 'Apucarana', 'PR', 'Brasil','2010-01-01 13:20', '2000-05-23','F'),
	('pequenopedrinho@mymail.com', '*****','Pedrinho', 'Apucarana', 'PR', 'Brasil','2010-01-01 13:20', '2002-01-03','M');
create table amigo (
	perfilAmigo varchar(100) not null,
	perfil varchar(100) not null,
	data datetime,
	foreign key (perfil) references perfil(email),
	primary key (perfilAmigo, perfil)
);
insert into amigo (perfil, perfilAmigo, data) values
	('professor@hotmail.com', 'joaosbras@mymail.com', '2021-05-17 10:00'),
	('professor@hotmail.com', 'pedro@gmail.com', '2021-05-17 10:05'),
	('professor@hotmail.com', 'mcalbuq@mymail.com', '2021-05-17 10:10'),
	('professor@hotmail.com', 'jorosamed@mymail.com', '2021-05-17 10:15'),
	('professor@hotmail.com', 'pxramos@mymail.com', '2021-05-17 10:20'),
	('mcalbuq@mymail.com','jessicabtstop@mymail.com', '2021-05-17 10:10'),
	('mcalbuq@mymail.com','pequenopedrinho@mymail.com', '2021-05-17 10:10'),
	('joaosbras@mymail.com', 'pxramos@mymail.com', '2021-05-17 10:40'),
	('joaosbras@mymail.com', 'jorosamed@mymail.com', '2021-05-18 10:40');

create table grupo (
	codigo integer not null,
	nome varchar(100) not null,
	primary key (codigo)
);
INSERT INTO grupo(codigo,nome) values
				(1,'Banco de Dados-IFRS2021'),
				(2,'SQlite');
create table pagina (
	codigo integer not null,
	nome varchar(100) not null,
	primary key (codigo)
);
create table post (
	codigo integer not null,
	texto varchar(1000),
	perfil varchar(100) not null,
	postagem integer,
	grupo  integer,
	pagina integer,
	data datetime,
	foreign key (perfil) references perfil(email),
	foreign key (grupo) references grupo(codigo),
	foreign key (pagina) references pagina(codigo),
	primary key (codigo)
);
insert into post (texto,perfil,postagem,data,grupo) values
	('Hoje eu aprendi como inserir dados no SQLite no IFRS','joaosbras@mymail.com',null,'2021-06-02 15:00',null),
	('Atendimento de BD no GMeet amanhã para quem tiver dúvidas de INSERT','professor@hotmail.com',null,'2021-06-02 15:35',null),
	('salve salve familia aqui é o paulao','pmartinssilva90@mymail.com',null,datetime(CURRENT_TIMESTAMP,'-1 days'),null),
	('paulão é rei po','pmartinssilva90@mymail.com',null,datetime(CURRENT_TIMESTAMP,'-2 days'),null),
	('Sqlite é muito tb hahahah','mcalbuq@mymail.com',null,datetime(CURRENT_TIMESTAMP,'-2 days'),2),
	('SQlite top topotpotpto muito top','jorosamed@mymail.com',null,datetime(CURRENT_TIMESTAMP,'-2 days'),2),
	('SQlite hahahahah go birrrl','professor@hotmail.com',null,datetime(CURRENT_TIMESTAMP,'-2 days'),2),
	('çafasfasfa','professor@hotmail.com',null,datetime(CURRENT_TIMESTAMP,'-2 days'),2),
	('eU sOu GAymer ksksks guys','pequenopedrinho@mymail.com',null,datetime(CURRENT_TIMESTAMP,'-3 days'),NULL),
	('salve rapeize','marciasilva@mymail.com',null,datetime(CURRENT_TIMESTAMP,'-2 days'),NULL),
	('Alguém mais ficou com dúvida no comando INSERT?','pedro@gmail.com',1,'2021-06-02 15:15', null),
	('Eu também','jorosamed@mymail.com',1,'2021-06-02 15:20', null),
	('Já agendaste horário de atendimento com o professor?','joaosbras@mymail.com',1,'2021-06-02 15:30', null),
	('salve salve familia','pele@cbf.com.br',5,CURRENT_TIMESTAMP, null);
create table assunto(
	codigo integer not null,
	nome varchar(100),
	primary key (codigo)
);
insert into assunto(codigo,nome) values
				   (1,'BD'),
				   (2,'INSERT'),
				   (3,'SQLite'),
				   (4,'atendimento'),
				   (5,'Paulao lindo'),
				   (6,'deus grego'),
				   (7,'100% jesus');

create table assuntoPost(
	assunto integer not null,
	post integer not null,
	foreign key (assunto) references assunto(codigo),
	foreign key (post) references post(codigo),
	primary key (post, assunto)
	);
insert into assuntoPost(post,assunto) values
					   (1,1),
					   (1,2),
					   (2,1),
					   (2,2),
					   (2,3),
					   (2,4),
					   (3,1),
					   (3,5),
					   (3,6),
					   (3,7),
					   (4,6),
					   (4,7),
					   (8,1),
					   (9,1),
					   (10,1);
--tabela compartilhamento adicionada para letra n)
create table compartilhamento(
	perfil varchar(100) not null,
	codigo_post integer not null,
	data_compartilhamento datetime DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (perfil) REFERENCES perfil(email),
	FOREIGN KEY (codigo_post) REFERENCES post(codigo)
);
insert into compartilhamento(perfil,codigo_post,data_compartilhamento) values
		('joaosbras@mymail.com',2,'2021-06-02 15:40'),
		('joaosbras@mymail.com',3,datetime(CURRENT_TIMESTAMP,'-1 hours')),
		('joaosbras@mymail.com',4,CURRENT_TIMESTAMP);
create table citacao (
	codigo integer not null,
	perfil varchar(100) not null,
	post integer not null,
	foreign key (post) references post(codigo),
	foreign key (perfil) references perfil(email),
	primary key (codigo)
);
insert into citacao (perfil,post) values
	('den@ifrs.riogrande.edu.br',1),
	('jorosamed@mymail.com',2),
	('pxramos@mymail.com',2);
--tabela de comentario adicionada
-- create table comentario(
-- 	codigo integer not null,
-- 	texto varchar(1000),
-- 	perfil varchar(100) not null,
-- 	postagem integer not null,
-- 	data datetime DEFAULT CURRENT_TIMESTAMP,
-- 	foreign key (perfil) references perfil(email),
-- 	foreign key (postagem) references post(codigo),
-- 	primary key (codigo)
-- );
-- INSERT INTO comentario(texto,perfil,postagem,data) values

--tabela reações adicionado
create table reaction(
	--codigo integer not null,
	texto varchar(7) CHECK(texto='gostei' or texto='amei' or texto='risos' or texto='triste'),
	perfil varchar(100) not null,
	postagem integer CHECK(comentario=null),
	comentario integer CHECK(postagem=null),
	data datetime DEFAULT CURRENT_TIMESTAMP,
	foreign key (perfil) references perfil(email),
	foreign key (postagem) references post(codigo),
	foreign key (comentario) references comentario(codigo)
	--primary key (codigo)
);
insert into reaction(texto,perfil,postagem,comentario,data) values
	('gostei','pedro@gmail.com',1,null,'2021-06-02 15:05'),
	('gostei','mcalbuq@mymail.com',1,null,'2021-06-02 15:10'),
	('triste','pxramos@mymail.com',null,1,'2021-06-02 15:20'),
	('gostei','pele@cbf.com.br',1,null,CURRENT_TIMESTAMP),
	('gostei','pxramos@mymail.com',5,null,'2021-06-02 15:20'),
	('triste','pele@cbf.com.br',6,null,CURRENT_TIMESTAMP),
	('gostei','pedro@gmail.com',6,null,'2021-06-02 15:05'),
	('gostei','mcalbuq@mymail.com',5,null,'2021-06-02 15:10'),
	('gostei','pedro@gmail.com',8,null,'2021-07-16 15:05'),
	('gostei','mcalbuq@mymail.com',8,null,'2021-07-16 15:10'),
	('gostei','pxramos@mymail.com',8,null,'2021-07-16 15:12'),
	('gostei','pedro@gmail.com',2,null,'2021-07-17 15:05'),
	('gostei','pxramos@mymail.com',2,null,'2021-07-17 15:15'),
	('amei','pedro@gmail.com',2,null,'2021-07-16 15:05'),
	('amei','pedro@gmail.com',3,null,'2021-07-16 15:05'),
	('amei','pedro@gmail.com',8,null,'2021-07-16 15:05'),
	('amei','pedro@gmail.com',9,null,'2021-07-16 15:05'),
	('amei','mcalbuq@mymail.com',2,null,'2021-07-16 15:10');


create table grupoPerfil (
	grupo integer not null,
	perfil varchar(100) not null,
	foreign key (perfil) references perfil(email),
	foreign key (grupo) references grupo(codigo),
	primary key (grupo,perfil)
);
INSERT INTO grupoPerfil(grupo,perfil) values
						(1,'professor@hotmail.com'),
						(1,'joaosbras@mymail.com'),
						(1,'mcalbuq@mymail.com'),
						(1,'pxramos@mymail.com'),
						(1,'jorosamed@mymail.com'),
						(1,'pedro@gmail.com'),
						(2,'professor@hotmail.com'),
						(2,'joaosbras@mymail.com'),
						(2,'mcalbuq@mymail.com'),
						(2,'pxramos@mymail.com'),
						(2,'jorosamed@mymail.com');

create table paginaPerfil (
	pagina integer not null,
	perfil varchar(100) not null,
	foreign key (perfil) references perfil(email),
	foreign key (pagina) references pagina(codigo),
	primary key (pagina,perfil)
);
/*2*/

