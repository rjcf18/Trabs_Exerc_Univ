DROP TABLE Reservas1;
DROP TABLE Espacos1;
DROP TABLE Reservas2;
DROP TABLE Espacos2;
DROP TABLE Reservas3;
DROP TABLE Espacos3;

CREATE TABLE Espacos1 (
       nome varchar(50) not null,
       localizacao varchar(50) not null,
       area int,
       capacidade int,
       primary key (nome, localizacao)
);

-- Timestamp format used "1999-01-08 04:05:06"
CREATE TABLE Reservas1 (
       nome varchar(50),
       email varchar(50),
       inicio timestamp not null,
       fim timestamp,
       fg_k_nome varchar(50) not null,
       fg_k_local varchar(50) not null,
       foreign key (fg_k_nome, fg_k_local) references Espacos1(nome, localizacao) on delete restrict,
       primary key (inicio, fg_k_nome, fg_k_local)
);

CREATE TABLE Espacos2 (
       nome varchar(50) not null,
       localizacao varchar(50) not null,
       area int,
       capacidade int,
       primary key (nome, localizacao)
);

-- Timestamp format used "1999-01-08 04:05:06"
CREATE TABLE Reservas2 (
       nome varchar(50),
       email varchar(50),
       inicio timestamp not null,
       fim timestamp,
       fg_k_nome varchar(50) not null,
       fg_k_local varchar(50) not null,
       foreign key (fg_k_nome, fg_k_local) references Espacos2(nome, localizacao) on delete restrict,
       primary key (inicio, fg_k_nome, fg_k_local)
);


CREATE TABLE Espacos3 (
       nome varchar(50) not null,
       localizacao varchar(50) not null,
       area int,
       capacidade int,
       primary key (nome, localizacao)
);

-- Timestamp format used "1999-01-08 04:05:06"
CREATE TABLE Reservas3 (
       nome varchar(50),
       email varchar(50),
       inicio timestamp not null,
       fim timestamp,
       fg_k_nome varchar(50) not null,
       fg_k_local varchar(50) not null,
       foreign key (fg_k_nome, fg_k_local) references Espacos3(nome, localizacao) on delete restrict,
       primary key (inicio, fg_k_nome, fg_k_local)
);

insert into espacos1 VALUES ('Anf-1','CLAV',20, 50);
insert into espacos1 VALUES ('Anf-2','CLAV',20, 50);
insert into espacos1 VALUES ('Anf-3','CLAV',20, 50);

insert into reservas1 VALUES ('Manuel', 'm@xpto.com','2014-04-01 14:00:00', '2014-04-01 16:00:00', 'Anf-1', 'CLAV');
insert into reservas1 VALUES ('Joaquim', 'j@xpto.com','2014-04-01 14:00:00', '2014-04-01 16:00:00', 'Anf-2', 'CLAV');
insert into reservas1 VALUES ('Ricardo', 'r@xpto.com','2014-04-01 14:00:00', '2014-04-01 16:00:00', 'Anf-3', 'CLAV');



insert into espacos2 VALUES ('Anf-1','CLAV',20, 50);
insert into espacos2 VALUES ('Anf-2','CLAV',20, 50);
insert into espacos2 VALUES ('Anf-3','CLAV',20, 50);

insert into reservas2 VALUES ('Manuel', 'm@xpto.com','2014-04-01 14:00:00', '2014-04-01 16:00:00', 'Anf-1', 'CLAV');
insert into reservas2 VALUES ('Joaquim', 'j@xpto.com','2014-04-01 14:00:00', '2014-04-01 16:00:00', 'Anf-2', 'CLAV');
insert into reservas2 VALUES ('Ricardo', 'r@xpto.com','2014-04-01 14:00:00', '2014-04-01 16:00:00', 'Anf-3', 'CLAV');




insert into espacos3 VALUES ('Anf-1','CLAV',20, 50);
insert into espacos3 VALUES ('Anf-2','CLAV',20, 50);
insert into espacos3 VALUES ('Anf-3','CLAV',20, 50);

insert into reservas3 VALUES ('Manuel', 'm@xpto.com','2014-04-01 14:00:00', '2014-04-01 16:00:00', 'Anf-1', 'CLAV');
insert into reservas3 VALUES ('Joaquim', 'j@xpto.com','2014-04-01 14:00:00', '2014-04-01 16:00:00', 'Anf-2', 'CLAV');
insert into reservas3 VALUES ('Ricardo', 'r@xpto.com','2014-04-01 14:00:00', '2014-04-01 16:00:00', 'Anf-3', 'CLAV');
