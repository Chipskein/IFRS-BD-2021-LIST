/*1*/
drop table if exists amigo;
drop table if exists reaction;
drop table if exists comentario;
drop table if exists citacao;
drop table if exists assuntopost;
drop table if exists assunto;
drop table if exists post;
drop table if exists grupoperfil;
drop table if exists paginaperfil;
drop table if exists grupo;
drop table if exists pagina;
drop table if exists perfil;
create table perfil (
	--precisamos guardar a idade do usuario ou a data de nascimento
	email varchar(100) not null,
	nome varchar(100) not null,
	senha varchar(20) not null,
	estado char(2) not null,
	cidade varchar(100) not null,
	pais varchar(100) not null,
	data datetime,--data de registro
	primary key (email)
);
insert into perfil (email, senha, nome, cidade, estado, pais, data) values
	('den@ifrs.riogrande.edu.br', '12345','IFRS Campus Rio Grande', 'Rio Grande', 'RS', 'Brasil','2010-01-01 08:00'),
	('professor@hotmail.com', '12345','Professor de BD', 'Rio Grande', 'RS', 'Brasil','2010-01-01 09:00'),
	('joaosbras@mymail.com', '42345','João Silva Brasil', 'Rio Grande', 'RS', 'Brasil','2020-01-01 13:00'),
	('pedro@gmail.com', '2345','Pedro Alencar Pereira', 'Rio Grande', 'RS', 'Brasil','2020-01-01 13:05'),
	('mcalbuq@mymail.com', '823456','Maria Cruz Albuquerque', 'Rio Grande', 'RS', 'Brasil','2020-01-01 13:10'),
	('jorosamed@mymail.com', '1234','Joana Rosa Medeiros', 'Rio Grande', 'RS', 'Brasil','2020-01-01 13:15'),
	('pxramos@mymail.com', '123','Paulo Xavier Ramos', 'Rio Grande', 'RS', 'Brasil','2020-01-01 13:20'),
	--adicionados para letra k) e n)
	('pele@cbf.com.br', '*****','Edson Arantes do Nascimento', 'Rio de Janeiro', 'RJ', 'Brasil','2009-01-01 13:20'),
	('pmartinssilva90@mymail.com', '*****','Paulo Martins Silva', 'Jundiai', 'SP', 'Brasil','2010-01-01 13:20');
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
	('joaosbras@mymail.com', 'pxramos@mymail.com', '2021-05-17 10:40');
create table post (
	codigo integer not null,
	texto varchar(1000),
	perfil varchar(100) not null,
	postagem integer,
	data datetime,
	foreign key (perfil) references perfil(email),
	foreign key (postagem) references post(codigo),
	primary key (codigo)
);
insert into post (texto,perfil,postagem,data) values
	('Hoje eu aprendi como inserir dados no SQLite no IFRS','joaosbras@mymail.com', null, '2021-06-02 15:00'),
	('Atendimento de BD no GMeet amanhã para quem tiver dúvidas de INSERT','professor@hotmail.com',null, '2021-06-02 15:35');
	--(null,'joaosbras@mymail.com',8, '2021-06-02 15:35');
create table assunto(
	--tabela assunto criada
	codigo integer not null,
	nome varchar(100),
	primary key (codigo)
);
	--assuntos adicionados
insert into assunto(codigo,nome) values
				   (1,"BD"),
				   (2,"INSERT"),
				   (3,"SQLite"),
				   (4,"atendimento");

create table assuntoPost(
	assunto integer not null,
	post integer not null,
	foreign key (assunto) references assunto(codigo),
	foreign key (post) references post(codigo),
	primary key (post, assunto)
	);

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
create table comentario(
	codigo integer not null,
	texto varchar(1000),
	perfil varchar(100) not null,
	postagem integer not null,
	data datetime DEFAULT CURRENT_TIMESTAMP,
	foreign key (perfil) references perfil(email),
	foreign key (postagem) references post(codigo),
	primary key (codigo)
);
INSERT INTO comentario(texto,perfil,postagem,data) values
							('Alguém mais ficou com dúvida no comando INSERT?','pedro@gmail.com',1,'2021-06-02 15:15'),
							('Eu também','jorosamed@mymail.com', 1,'2021-06-02 15:20'),
							('Já agendaste horário de atendimento com o professor?','joaosbras@mymail.com',1,'2021-06-02 15:30'),
							('salve salve familia','pele@cbf.com.br',1,CURRENT_TIMESTAMP);
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
	('gostei','pele@cbf.com.br',1,null,CURRENT_TIMESTAMP);















create table grupo (
	codigo integer not null,
	nome varchar(100) not null,
	primary key (codigo)
);
create table grupoPerfil (
	grupo integer not null,
	perfil varchar(100) not null,
	foreign key (perfil) references perfil(email),
	foreign key (grupo) references grupo(codigo),
	primary key (grupo,perfil)
);

create table pagina (
	codigo integer not null,
	nome varchar(100) not null,
	primary key (codigo)
);

create table paginaPerfil (
	pagina integer not null,
	perfil varchar(100) not null,
	foreign key (perfil) references perfil(email),
	foreign key (pagina) references pagina(codigo),
	primary key (pagina,perfil)
);
/*2*/

