-- a)
select perfil.nome from perfil, amigo where (amigo.perfilAmigo=perfil.email or amigo.perfil=perfil.email) and (amigo.perfil like '%mcalbuq@mymail.com%' or amigo.perfilAmigo like '%mcalbuq@mymail.com%') and perfil.email not like '%mcalbuq@mymail.com%';

-- b) não funciona
select * from perfil, amigo where (amigo.perfilAmigo=perfil.email or amigo.perfil=perfil.email) and (amigo.perfil like '%pxramos@mymail.com%' or amigo.perfilAmigo like '%pxramos@mymail.com%' or amigo.perfil like '%jorosamed@mymail.com%' or amigo.perfilAmigo like '%jorosamed@mymail.com%') and perfil.email not like '%pxramos@mymail.com%' or perfil.email not like '%jorosamed@mymail.com%';