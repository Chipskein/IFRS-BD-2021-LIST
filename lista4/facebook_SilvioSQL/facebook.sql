
--drop table amigo;
--drop table citacao;
--drop table assuntopost;
--drop table assunto;
--drop table post;
--drop table grupoperfil;
--drop table paginaperfil;
--drop table grupo;
--drop table pagina;
--drop table perfil;
create table perfil (
	email varchar(100) not null,
	nome varchar(100) not null,
	senha varchar(20) not null,
	estado char(2) not null,
	cidade varchar(100) not null,
	pais varchar(100) not null,
	data datetime,
	primary key (email)
);

insert into perfil (email, senha, nome, cidade, estado, pais, data) values
('den@ifrs.riogrande.edu.br', '12345','IFRS Campus Rio Grande', 'Rio Grande', 'RS', 'Brasil','2010-01-01 08:00'),
('professor@hotmail.com', '12345','Professor de BD', 'Rio Grande', 'RS', 'Brasil','2010-01-01 09:00'),
('joao@hotmail.com', '42345','João Silva Brasil', 'Rio Grande', 'RS', 'Brasil','2020-01-01 13:00'),
('pedro@gmail.com', '2345','Pedro Alencar Pereira', 'Rio Grande', 'RS', 'Brasil','2020-01-01 13:05'),
('mariazinha@hotmail.com', '823456','Maria Cruz Albuquerque', 'Rio Grande', 'RS', 'Brasil','2020-01-01 13:10'),
('joana@hotmail.com', '1234','Joana Rosa Medeiros', 'Rio Grande', 'RS', 'Brasil','2020-01-01 13:15'),
('xmen@hotmail.com', '123','Paulo Xavier Ramos', 'Rio Grande', 'RS', 'Brasil','2020-01-01 13:20');
create table amigo (
	perfilAmigo varchar(100) not null,
	perfil varchar(100) not null,
	data datetime,
	foreign key (perfil) references perfil(email),
	primary key (perfilAmigo, perfil)
);
insert into amigo (perfil, perfilAmigo, data) values
	('professor@hotmail.com', 'joao@hotmail.com', '2021-05-17 10:00'),
	('professor@hotmail.com', 'pedro@gmail.com', '2021-05-17 10:05'),
	('professor@hotmail.com', 'mariazinha@hotmail.com', '2021-05-17 10:10'),
	('professor@hotmail.com', 'joana@hotmail.com', '2021-05-17 10:15'),
	('professor@hotmail.com', 'xmen@hotmail.com', '2021-05-17 10:20'),
	('joao@hotmail.com', 'xmen@hotmail.com', '2021-05-17 10:40'),
	('xmen@hotmail.com', 'joao@hotmail.com', '2021-05-17 10:40');
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
insert into post (texto,perfil, postagem, data) values
	('Hoje eu aprendi como inserir dados no SQLite no IFRS','joao@hotmail.com', null, '2021-06-02 15:00'),
	('gostei','pedro@gmail.com', 1 ,'2021-06-02 15:05'),
	('gostei','mariazinha@hotmail.com', 1 ,'2021-06-02 15:10'),
	('Alguém mais ficou com dúvida no comando INSERT?','pedro@gmail.com',1,'2021-06-02 15:15'),
	('Eu também','joana@hotmail.com', 4,'2021-06-02 15:20'),
	('triste','xmen@hotmail.com', 4 ,'2021-06-02 15:20'),
	('Já agendaste horário de atendimento com o professor?','joao@hotmail.com',5,'2021-06-02 15:30'),
	('Atendimento de BD no GMeet amanhã para quem tiver dúvidas de INSERT','professor@hotmail.com',null, '2021-06-02 15:35'),
	(null,'joao@hotmail.com',8, '2021-06-02 15:35');
create table assuntoPost(
	assunto integer not null,
	post integer not null,
	foreign key (assunto) references assunto(codigo),
	foreign key (post) references post(codigo),
	primary key (post, assunto)
	);
insert into assuntoPost (assunto, post) values
	(1,1),
	(2,1),
	(1,2),
	(2,2),
	(3,2),
	(1,4),
	(4,4),
	(1,5),
	(2,5),
	(3,5),
	(4,5);
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
	('joana@hotmail.com',8),
	('xmen@hotmail.com',8);


create table grupo (
	codigo integer not null
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
	codigo integer not null
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