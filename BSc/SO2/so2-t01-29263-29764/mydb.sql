DROP TABLE Reservas;
DROP TABLE Horarios;
DROP TABLE Espacos;

CREATE TABLE Espacos (
       nome varchar(50) not null,
       localizacao varchar(50) not null,
       area int,
       capacidade int,
       primary key (nome, localizacao)
);

-- Timestamp format used "1999-01-08 04:05:06"
CREATE TABLE Reservas (
       nome varchar(50),
       email varchar(50),
       inicio timestamp not null,
       fim timestamp,
       fg_k_nome varchar(50) not null, 
       fg_k_local varchar(50) not null,
       foreign key (fg_k_nome, fg_k_local) references Espacos(nome, localizacao) on delete restrict,
       primary key (inicio, fg_k_nome, fg_k_local)
);


CREATE TABLE Horarios (
       inicio timestamp not null,
       fim timestamp,
       fg_k_nome varchar(50) not null, 
       fg_k_local varchar(50) not null,
       foreign key (fg_k_nome, fg_k_local) references Espacos(nome, localizacao) on delete restrict,
       primary key (inicio, fg_k_nome, fg_k_local)
);

insert into espacos VALUES ('Anf-1','CLAV',20, 50);
insert into espacos VALUES ('Anf-2','CLAV',20, 50);
insert into espacos VALUES ('Anf-3','CLAV',20, 50);
insert into espacos VALUES ('Anf-4','CLAV',20, 50);
insert into espacos VALUES ('Anf-5','CLAV',20, 50);
insert into espacos VALUES ('125','CLAV',20, 25);
insert into espacos VALUES ('126','CLAV',20, 25);
insert into espacos VALUES ('127','CLAV',20, 25);
insert into espacos VALUES ('128','CLAV',20, 25);
insert into espacos VALUES ('129','CLAV',20, 25);
insert into espacos VALUES ('130','CLAV',20, 25);
insert into espacos VALUES ('131','CLAV',20, 25);
insert into espacos VALUES ('132','CLAV',20, 25);
insert into espacos VALUES ('133','CLAV',20, 25);
insert into espacos VALUES ('134','CLAV',20, 25);
insert into espacos VALUES ('135','CLAV',20, 25);
insert into espacos VALUES ('136','CLAV',20, 25);
insert into espacos VALUES ('137','CLAV',20, 25);
insert into espacos VALUES ('138','CLAV',20, 25);
insert into espacos VALUES ('139','CLAV',20, 25);
insert into espacos VALUES ('140','CLAV',20, 25);

insert into reservas VALUES ('Manuel', 'm@xpto.com','2014-04-01 14:00:00', '2014-04-01 16:00:00', 'Anf-1', 'CLAV');
insert into reservas VALUES ('Joaquim', 'j@xpto.com','2014-04-01 14:00:00', '2014-04-01 16:00:00', 'Anf-2', 'CLAV');
insert into reservas VALUES ('Ricardo', 'r@xpto.com','2014-04-01 14:00:00', '2014-04-01 16:00:00', 'Anf-3', 'CLAV');





