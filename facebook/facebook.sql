
DROP TABLE IF EXISTS criar_grupo;
DROP TABLE IF EXISTS participa_grupo;
DROP TABLE IF EXISTS criar_pagina;
DROP TABLE IF EXISTS curtir_pagina;
DROP TABLE IF EXISTS citacao;
DROP TABLE IF EXISTS post_assunto;
DROP TABLE IF EXISTS cmt_assunto;
DROP TABLE IF EXISTS resp_assunto;
DROP TABLE IF EXISTS amizade;
DROP TABLE IF EXISTS reaction;
DROP TABLE IF EXISTS compartilhamento;
DROP TABLE IF EXISTS pagina;
DROP TABLE IF EXISTS grupo;
DROP TABLE IF EXISTS assunto;
DROP TABLE IF EXISTS resposta;
DROP TABLE IF EXISTS comentario;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS usuario;

CREATE TABLE usuario(
    user_cod INT NOT NULL CHECK(user_cod>=0),
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(30),
    user_pass VARCHAR(100) NOT NULL,
    name_user VARCHAR(70) NOT NULL,
    register_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    pais VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    qt_friends INT DEFAULT 0,
    PRIMARY KEY(user_cod)
);

CREATE TABLE amizade(
    user_cod INT NOT NULL,
    friend_cod INT NOT NULL CHECK(friend_cod != user_cod),
    amizade_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(user_cod,friend_cod),
    FOREIGN KEY (user_cod) REFERENCES usuario(user_cod),
    FOREIGN KEY (friend_cod) REFERENCES usuario(user_cod)
);
CREATE TABLE assunto(
    cod_assunto INT NOT NULL CHECK(cod_assunto>=0),
    name_assunto VARCHAR(50),--nome alterado
    PRIMARY KEY(cod_assunto)
);
CREATE TABLE post(
    cod_post INT NOT NULL CHECK (cod_post>=0),
    post_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    post_msg VARCHAR(300),
    user_cod INT NOT NULL,
    pais VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    PRIMARY KEY(cod_post),
    FOREIGN KEY (user_cod) REFERENCES usuario(user_cod)
);
CREATE TABLE comentario(
    cod_comment INT NOT NULL CHECK(cod_comment>=0),
    user_cod INT NOT NULL,
    cod_post INT NOT NULL,
    comment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    comment_msg VARCHAR(300),
    PRIMARY KEY(cod_comment),
    FOREIGN KEY (user_cod) REFERENCES usuario(user_cod)
    FOREIGN KEY (cod_post) REFERENCES post(cod_post)
);
CREATE TABLE resposta(
    cod_resp INT NOT NULL CHECK(cod_resp>=0),
    user_cod INT NOT NULL,
    cod_comment INT NOT NULL,
    resp_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    resp_msg VARCHAR(300),
    PRIMARY KEY(cod_resp),
    FOREIGN KEY (user_cod) REFERENCES usuario(user_cod)
    FOREIGN KEY (cod_comment) REFERENCES comentario(cod_comment)
);
CREATE TABLE citacao(
    user_cod INT NOT NULL,
    cod_post    INT CHECK(cod_comment=NULL AND cod_resp=NULL),
    cod_comment INT CHECK(cod_post=NULL AND cod_resp=NULL),
    cod_resp    INT CHECK(cod_comment=NULL AND cod_post=NULL),
    FOREIGN KEY (user_cod) REFERENCES usuario(user_cod)
    FOREIGN KEY (cod_post) REFERENCES post(cod_post),
    FOREIGN KEY (cod_comment) REFERENCES comentario(cod_comment),
    FOREIGN KEY (cod_resp) REFERENCES resposta(cod_resp)
);
CREATE TABLE post_assunto(
    cod_post INT NOT NULL,
    cod_assunto INT NOT NULL,
    PRIMARY KEY(cod_post,cod_assunto),
    FOREIGN KEY (cod_post) REFERENCES post(cod_post),
    FOREIGN KEY (cod_assunto) REFERENCES assunto(cod_assunto)
);
CREATE TABLE reaction(
    user_cod INT NOT NULL,
    
    cod_post    INT CHECK(cod_comment=NULL AND cod_resp=NULL),
    cod_comment INT CHECK(cod_post=NULL AND cod_resp=NULL),  
    cod_resp    INT CHECK(cod_comment=NULL AND cod_post=NULL),
    reaction_msg VARCHAR(6) CHECK(reaction_msg='triste' OR reaction_msg='curtir' OR 
                                   reaction_msg='amei'  OR reaction_msg='odiei'  OR
                                   reaction_msg='risos' OR reaction_msg='wow'),
    reaction_date DATETIME DEFAULT CURRENT_TIMESTAMP ,
    reaction_post_user_cod INT NOT NULL,
    FOREIGN KEY (cod_post) REFERENCES post(cod_post),
    FOREIGN KEY (cod_comment) REFERENCES comentario(cod_comment),
    FOREIGN KEY (cod_resp) REFERENCES resposta(cod_resp),
    FOREIGN KEY (reaction_post_user_cod) REFERENCES usuario(user_cod)
);
CREATE TABLE resp_assunto(
    cod_resp INT NOT NULL,
    cod_assunto INT NOT NULL,
    PRIMARY KEY(cod_resp,cod_assunto),
    FOREIGN KEY (cod_resp) REFERENCES resposta(cod_resp),
    FOREIGN KEY (cod_assunto) REFERENCES assunto(cod_assunto)
);
CREATE TABLE cmt_assunto(
    cod_comment INT NOT NULL,
    cod_assunto INT NOT NULL,
    PRIMARY KEY(cod_comment,cod_assunto),
    FOREIGN KEY (cod_comment) REFERENCES comentario(cod_comment),
    FOREIGN KEY (cod_assunto) REFERENCES assunto(cod_assunto)
);

CREATE TABLE compartilhamento(
    user_cod INT NOT NULL,
    cod_post INT NOT NULL,
    comp_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_cod) REFERENCES usuario(user_cod),
    FOREIGN KEY (cod_post) REFERENCES post(cod_post)
);
CREATE TABLE grupo(
    cod_group INT NOT NULL CHECK(cod_group>=0),
    name_group VARCHAR(70),
    PRIMARY KEY(cod_group)
);
CREATE TABLE pagina(
    cod_pagina INT NOT NULL CHECK(cod_pagina>=0),
    name_pagina VARCHAR(70),
    PRIMARY KEY(cod_pagina)
);
CREATE TABLE criar_grupo(
    user_cod INT NOT NULL,
    cod_group INT NOT NULL UNIQUE, 
    date_group DATETIME DEFAULT CURRENT_TIMESTAMP  ,
    FOREIGN KEY (user_cod) REFERENCES usuario(user_cod),
    FOREIGN KEY (cod_group) REFERENCES grupo(cod_group)
);
CREATE TABLE participa_grupo(
    user_cod INT NOT NULL,
    cod_group INT NOT NULL ,
    participa_date DATETIME DEFAULT CURRENT_TIMESTAMP  ,
    FOREIGN KEY (user_cod) REFERENCES usuario(user_cod),
    FOREIGN KEY (cod_group) REFERENCES grupo(cod_group)
);
CREATE TABLE criar_pagina(
    user_cod INT NOT NULL,
    cod_pagina INT NOT NULL UNIQUE, 
    date_pagina DATETIME DEFAULT CURRENT_TIMESTAMP  ,
    FOREIGN KEY (user_cod) REFERENCES usuario(user_cod),
    FOREIGN KEY (cod_pagina) REFERENCES pagina(cod_pagina)
);
CREATE TABLE curtir_pagina(
    user_cod INT NOT NULL,
    cod_pagina INT NOT NULL UNIQUE,
    FOREIGN KEY (user_cod) REFERENCES usuario(user_cod),
    FOREIGN KEY (cod_pagina) REFERENCES pagina(cod_pagina)
);


