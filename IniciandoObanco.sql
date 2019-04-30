SET FOREIGN_KEY_CHECKS=0;

create database Escola;

use Escola;

drop table if exists PreReq cascade;
drop table if exists Disciplina cascade;
drop table if exists Turma cascade;
drop table if exists Horario cascade;
drop table if exists Sala cascade;
drop table if exists Predio cascade;
drop table if exists Depto cascade;
drop table if exists Professor cascade;
drop table if exists ProfTurma cascade;
drop table if exists Titulacao cascade;


create table if not exists PreReq (
	CodDeptoPreReq char(5),
    NumDiscPreReq int,
    CodDepto char(5),
    NumDisc int4
);


create table if not exists Disciplina (
	CodDepto char(5),
    NumDisc int,
    NomeDisc varchar(10),
	CreditoDisc int
);


create table if not exists Turma (
	AnoSem int,
	CodDepto char(5),
	NumDisc int,
	SiglaTur char(2),
	CapacTur int
);


create table if not exists Horario (
	AnoSem int,
	CodDepto char(5),
	NumDisc int,
	SiglaTur char(2),
	DiaSem int,
	HoraInicio int,
	NumSala int,
	CodPred int,
	NumHoras int
);


create table if not exists Sala (
	CodPred int,
	NumSala int,
	DescricaoSala varchar(40),
	CapacSala int
);


create table if not exists Predio (
	CodPred int,
	NomePred varchar(40)
);


create table if not exists Depto (
	CodDepto char(5),
	NomeDepto varchar(40)
);


create table if not exists Professor (
	CodProf int,
	CodDepto char(5),
	CodTit int,
	NomeProf varchar(40)
);


create table if not exists ProfTurma (
	AnoSem int,
	CodDepto char(5),
	NumDisc int,
	SiglaTur char(2),
	CodProf int
);


create table if not exists Titulacao (
	CodTit int,
	NomeTit varchar(40)
);

/*--------------------------------------------------------------------------------*/

Insert into Predio
values
(43423,'Informática - aulas'),
(43529,'Polimeros - aulas'),
(43981,'Comex - aulas');

Insert into Sala
values
(43423,101,'Sala Comum',20),
(43423,102,'Sala Comum',20),
(43423,103,'Laboratorio',30),
(43423,104,'Laboratorio',50),

(43529,10,'Sala Comum',30),
(43529,11,'Sala Comum',30),
(43529,20,'Laboratorio',60),
(43529,21,'Laboratorio',60),


(43981,1,'Sala Comum',30),
(43981,2,'Sala Comum',30),
(43981,3,'Sala Comum',30),
(43981,4,'Laboratorio',60);

Insert into Depto
value
('INF01','Informatica'),
('POL01','Polimeros'),
('COM01','COMEX');

Insert into disciplina
values
('INF01', 1 ,'Eng1',2),
('INF01', 2 ,'Eng2',2),
('INF01', 3 ,'Log1',2),
('COM01', 4 ,'Ing1',1),
('COM01', 5 ,'Ing2',1),
('COM01', 6 ,'Ing3',1),
('POL01', 7 ,'Cal1',2),
('POL01', 8 ,'Cal2',2);

Insert into prereq
values
('INF01',1,'COM01',5),
('INF01',1,'INF01',2),
('COM01',4,'COM01',5),
('COM01',5,'COM01',6),
('POL01',7,'POL01',8);

Insert into titulacao
values
(1,'Doutor'),
(2,'Mestre'),
(3,'Coordenador');


Insert into Professor
values
(1,'INF01',1,'Antunes'),
(2,'INF01',2,'Semaj'),
(3,'INF01',3,'Ricardo'),
(4,'COM01',1,'Irineu'),
(5,'COM01',2,'Jailson'),
(6,'COM01',3,'Mario'),
(7,'POL01',1,'Joao'),
(8,'POL01',2,'Marcelo'),
(9,'POL01',3,'Manoel'),
(10,'POL01',1,'Maria');

Insert into Turma
values
(20021,'INF01',1,'1D',50),
(20021,'INF01',3,'1D',50),
(20021,'COM01',4,'1A',30),
(20021,'POL01',7,'1B',30),
(20022,'INF01',2,'1D',50),
(20022,'COM01',5,'1A',30),
(20022,'POL01',8,'1B',30),
(20031,'COM01',6,'1A',30);


Insert into profturma
values
(20021,'INF01',1,'1D',1),
(20021,'INF01',3,'1D',2),
(20021,'COM01',4,'1A',4),
(20022,'COM01',5,'1A',5),
(20031,'COM01',6,'1A',6),
(20021,'POL01',7,'1B',7),
(20022,'POL01',8,'1B',9);


Insert into horario
values
(20021,'INF01',1,'1D',2,19,101,43423,4),
(20021,'INF01',3,'1D',3,19,102,43423,4),

(20021,'COM01',4,'1A',2,19,1,43981,2),
(20022,'COM01',5,'1A',4,19,2,43981,2),
(20031,'COM01',6,'1A',5,19,3,43981,2),

(20021,'POL01',7,'1B',3,19,10,43529,4),
(20022,'POL01',8,'1B',6,19,11,43529,4);


/*-----------------------------------------------------------------------------------*/

alter table Predio add primary key (CodPred);
alter table Sala add foreign key (CodPred) references Predio(CodPred);
alter table Sala add primary key (CodPred, NumSala);
alter table Depto add primary key (CodDepto);
alter table Titulacao add primary key (CodTit);
alter table Professor add primary key (CodProf);
alter table Professor add foreign key (CodDepto) references Depto(CodDepto);
alter table Professor add foreign key (CodTit) references Titulacao(CodTit);
alter table Disciplina add foreign key (CodDepto) references Depto(CodDepto);
alter table Disciplina add primary key (CodDepto, NumDisc);
alter table Turma add foreign key (CodDepto, NumDisc) references Disciplina(CodDepto, NumDisc);
alter table Turma add primary key (AnoSem, CodDepto, NumDisc, SiglaTur);

alter table PreReq add foreign key (CodDepto, NumDisc) references Disciplina (CodDepto, NumDisc);
alter table PreReq add foreign key (CodDeptoPreReq, NumDiscPreReq) references Disciplina(CodDepto, NumDisc);
alter table PreReq add primary key (CodDepto, NumDisc, CodDeptoPreReq, NumDiscPreReq);

alter table ProfTurma add foreign key (AnoSem, CodDepto, NumDisc, SiglaTur) references Turma(AnoSem, CodDepto, NumDisc, SiglaTur);
alter table ProfTurma add foreign key (CodProf) references Professor(CodProf);
alter table ProfTurma add primary key (AnoSem, CodDepto, NumDisc, SiglaTur, CodProf);

alter table Horario add foreign key (AnoSem, CodDepto, NumDisc, SiglaTur) references Turma(AnoSem, CodDepto, NumDisc, SiglaTur);
alter table Horario add foreign key (CodPred, NumSala) references Sala(CodPred, NumSala);
alter table Horario add primary key (AnoSem, CodDepto, NumDisc, SiglaTur, DiaSem, HoraInicio);

SET FOREIGN_KEY_CHECKS=1;
