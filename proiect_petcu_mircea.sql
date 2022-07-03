--10. Crearea unei secven?e ce va fi utilizatã în inserarea înregistrãrilor în tabele (punctul 11).
create sequence sala_fitness_seq
increment by 1
start with 10;

create table LOCATIE(
locatie_id number(6) constraint pk_locatie primary key,
tara varchar2(30),
regiune varchar2(30),
oras varchar2(30));

create table ADRESA(
adresa_id number(6),
strada varchar2(30),
numar number(4),
cod_postal number(5),
locatie_id number(6),
constraint pk_adr primary key (locatie_id,adresa_id),
constraint fk_adr_loc foreign key (locatie_id) 
references LOCATIE (locatie_id) on delete cascade);
drop table adresa;
create table GAMA_SUPLIMENTE(
gama_suplimente_id number(6) constraint pk_gama_supl primary key);

create table GAMA_APARATE(
gama_aparate_id number(6) constraint pk_gama_ap primary key);

create table SUPLIMENT(
supliment_id number(6) constraint pk_supliment primary key,
denumire varchar2(30),
pret number(6,2),
cantitate number(4,2),
gama_suplimente_id number(6),
constraint fk_gam_sup foreign key (gama_suplimente_id)
references GAMA_SUPLIMENTE (gama_suplimente_id) on delete cascade);

create table APARAT_FITNESS(
aparat_fitness_id number(6) constraint pk_aparat primary key,
denumire varchar2(30),
pret number(10,2),
gama_aparate_id number(6),
constraint fk_gam_ap foreign key (gama_aparate_id)
references GAMA_APARATE (gama_aparate_id) on delete cascade);

create table DEPARTAMENT(
departament_id number(6) constraint pk_dep primary key,
nume_departament VARCHAR2(30));

create table ANGAJAT(
angajat_id number(6) constraint pk_ang primary key,
nume varchar2(30),
prenume varchar2(30),
email varchar2(30) constraint uniq_em_ang unique,
salariu number(7,2),
departament_id number(6),
constraint ck_sal check(salariu >1500),
constraint fk_ang_dep foreign key (departament_id)
references DEPARTAMENT (departament_id) on delete cascade);

create table LISTA_DEPARTAMENTE(
lista_dep_id number(6) constraint pk_list_dep primary key);

create table LISTA_CLIENTI(
lista_clienti_id number(6) constraint pk_list_clienti primary key);


create table CLIENTI(
client_id number(6) constraint pk_client primary key,
nume varchar2(30),
prenume varchar2(30),
email varchar2(30),
lista_clienti_id number(6) constraint nn_cl not null,
constraint fk_list_cli foreign key (lista_clienti_id)
references LISTA_CLIENTI (lista_clienti_id) on delete cascade);

create table ABONAMENT(
abonament_id number(6) constraint pk_abon primary key,
data_inceput date,
data_sfarsit date);

create table ABONAMENT_STANDARD(
abonament_id number(6) constraint pk_standard primary key,
data_inceput date,
data_sfarsit date,
pret_standard number(5,2),
constraint fk_standard foreign key (abonament_id)
references ABONAMENT (abonament_id) on delete cascade
);

create table ABONAMENT_PREMIUM(
abonament_id number(6) constraint pk_premium primary key,
data_inceput date,
data_sfarsit date,
pret_premium number(6,2),
constraint fk_premium foreign key (abonament_id)
references ABONAMENT (abonament_id) on delete cascade
);

create table ESTE_DETINUT(
abonament_id number(6),
client_id number(6),
constraint pk_detinut primary key (abonament_id,client_id),
constraint fk_detinut1 foreign key (abonament_id) references ABONAMENT (abonament_id),
constraint fk_detinut2 foreign key (client_id) references CLIENTI (client_id));

create table APARTINE(
lista_dep_id number(6),
departament_id number(6),
constraint pk_apartine primary key (lista_dep_id,departament_id),
constraint fk_apartine1 foreign key (lista_dep_id) references LISTA_DEPARTAMENTE (lista_dep_id),
constraint fk_apartine2 foreign key (departament_id) references DEPARTAMENT (departament_id));


create table SALA_DE_FITNESS(
sala_id number(6) constraint pk_sala_pm primary key,
denumire varchar2(30),
lista_clienti_id number(6),
email varchar2(40) constraint uniq_den_sala unique,
locatie_id number(6) constraint null_locatie not null,
gama_aparate_id number(6) constraint null_aparate not null,
gama_suplimente_id number(6) constraint null_suplimente not null,
lista_dep_id number(6),
constraint fk_sala1 foreign key (lista_clienti_id) references LISTA_CLIENTI (lista_clienti_id),
constraint fk_sala2 foreign key (lista_dep_id) references LISTA_DEPARTAMENTE (lista_dep_id),
constraint fk_sala3 foreign key (gama_aparate_id) references GAMA_APARATE (gama_aparate_id) ,
constraint fk_sala4 foreign key (gama_suplimente_id) references GAMA_SUPLIMENTE (gama_suplimente_id) ,
constraint fk_sala5 foreign key (locatie_id) references LOCATIE (locatie_id)
);

insert into GAMA_APARATE (gama_aparate_id)
values (10);
insert into GAMA_APARATE (gama_aparate_id)
values (SALA_FITNESS_SEQ.nextval);

select * from gama_suplimente;

insert into aparat_fitness
values (17,'squat_rack',2000.5,12);
delete from aparat_fitness where aparat_fitness_id = 17;
insert into aparat_fitness
values (sala_fitness_seq.nextval,'presa_picioare',5000.45,13);
insert into aparat_fitness
values (sala_fitness_seq.nextval,'aparat_ramat',2440.5,14);
insert into aparat_fitness
values (sala_fitness_seq.nextval,'banca_smith',8000,15);
insert into aparat_fitness
values (sala_fitness_seq.nextval,'gantere_30kg',3000.5,16);
insert into aparat_fitness
values (sala_fitness_seq.nextval,'extensii_cvadriceps',30660.5,10);
insert into aparat_fitness
values (sala_fitness_seq.nextval,'helcometru',40660.5,16);
insert into aparat_fitness
values (sala_fitness_seq.nextval,'bara_olimpica',50660.5,12);
SELECT *
from aparat_fitness;
insert into gama_suplimente
values (sala_fitness_seq.nextval);
insert into supliment
values(sala_fitness_seq.nextval,'proteina_din_zer',250,5,28);

insert into supliment
values(sala_fitness_seq.nextval,'proteina_din_soia',200,5,27);
insert into supliment
values(sala_fitness_seq.nextval,'beta-alanina',100,1,26);
insert into supliment
values(sala_fitness_seq.nextval,'creatina',80,1,25);
insert into supliment
values(sala_fitness_seq.nextval,'citrulina',120,1,30);
insert into supliment
values(sala_fitness_seq.nextval,'taurina',110,1.2,30);
select *from supliment;

--locatie
insert into locatie
values (sala_fitness_seq.nextval,'Romania','Ilfov','Voluntari');
insert into locatie
values (sala_fitness_seq.nextval,'Romania','Bucuresti','Bucuesti');
insert into locatie
values (sala_fitness_seq.nextval,'Romania','Cluj','Cluj-Napoca');
insert into locatie
values (sala_fitness_seq.nextval,'Romania','Constanta','Constanta');
insert into locatie
values (sala_fitness_seq.nextval,'Romania','Iasi','Iasi');
select * from locatie;

--adresa
insert into adresa
values(sala_fitness_seq.nextval,'Copou',33,5582,49);
insert into adresa
values(sala_fitness_seq.nextval,'Suceava',3,5322,46);
insert into adresa
values(sala_fitness_seq.nextval,'Calea Victorie',333,4322,47);
insert into adresa
values(sala_fitness_seq.nextval,'Buna ziua',43,4542,48);
insert into adresa
values(sala_fitness_seq.nextval,'Ion Creanga',4,2542,45);
select * from adresa;

--lista_departamente
insert into lista_departamente
values (sala_fitness_seq.nextval);
insert into lista_departamente
values (sala_fitness_seq.nextval);
insert into lista_departamente
values (sala_fitness_seq.nextval);
insert into lista_departamente
values (sala_fitness_seq.nextval);
insert into lista_departamente
values (sala_fitness_seq.nextval);
select * from lista_departamente;

--departamente
insert into departament
values (sala_fitness_seq.nextval, 'receptie');
insert into departament
values (sala_fitness_seq.nextval, 'instructori');
insert into departament
values (sala_fitness_seq.nextval, 'curatenie');
insert into departament
values (sala_fitness_seq.nextval, 'contabilitate');
insert into departament
values (sala_fitness_seq.nextval, 'paza');
--59-63
--64-68
--apartine - am schimbat doar cifrele si am inserat de 5*5 = 25 de ori
insert into apartine
values(63,68);
select * from lista_departamente;
select * from departament;

--angajat
insert into angajat
values(sala_fitness_seq.nextval,'Maria','Andreea','ma@gmail.com',9300,68);
insert into angajat
values(sala_fitness_seq.nextval,'Petcu Mircea',	'mp@gmail.com',	5000,65);
insert into angajat
values(sala_fitness_seq.nextval,'Petcu Gabriel',	'gp@gmail.com',	6800,	64);
insert into angajat
values(sala_fitness_seq.nextval,'Ion Andrei' ,'ia@gmail.com',	8800,	67);
insert into angajat
values(sala_fitness_seq.nextval,'Iona Andreea',	'iaa@gmail.com', 9800, 66);
select * from angajat;

--lista_clienti
insert into lista_clienti
values (sala_fitness_seq.nextval);
insert into lista_clienti
values (sala_fitness_seq.nextval);
insert into lista_clienti
values (sala_fitness_seq.nextval);
insert into lista_clienti
values (sala_fitness_seq.nextval);
insert into lista_clienti
values (sala_fitness_seq.nextval);
select * from lista_clienti;
--75-78

--clienti
insert into clienti
values (sala_fitness_seq.nextval,'Alex Ion',	'ai@gmail.com',	74);
insert into clienti
values (sala_fitness_seq.nextval,'Alexa	Ionel', 'aaii@gmail.com', 76);
insert into clienti
values (sala_fitness_seq.nextval,'Andrei Ioana','aai@gmail.com', 78);
insert into clienti
values (sala_fitness_seq.nextval,'Ciot Ioana','ci@gmail.com', 77);
insert into clienti
values (sala_fitness_seq.nextval,'Ciotan','Maria','cm@gmail.com',75);
select * from clienti;

--abonament
insert into abonament
values (sala_fitness_seq.nextval,TO_DATE('17/11/2021', 'DD/MM/YYYY'),TO_DATE('17/12/2021', 'DD/MM/YYYY'));
insert into abonament
values (sala_fitness_seq.nextval,TO_DATE('17/11/2022', 'DD/MM/YYYY'),TO_DATE('17/12/2022', 'DD/MM/YYYY'));
insert into abonament
values (sala_fitness_seq.nextval,TO_DATE('17/09/2021', 'DD/MM/YYYY'),TO_DATE('17/10/2021', 'DD/MM/YYYY'));
insert into abonament
values (sala_fitness_seq.nextval,TO_DATE('17/08/2021', 'DD/MM/YYYY'),TO_DATE('17/09/2021', 'DD/MM/YYYY'));
insert into abonament
values (sala_fitness_seq.nextval,TO_DATE('17/07/2021', 'DD/MM/YYYY'),TO_DATE('17/08/2021', 'DD/MM/YYYY'));
insert into abonament
--
values (sala_fitness_seq.nextval,TO_DATE('13/07/2021', 'DD/MM/YYYY'),TO_DATE('13/08/2021', 'DD/MM/YYYY'));
insert into abonament
values (sala_fitness_seq.nextval,TO_DATE('10/07/2021', 'DD/MM/YYYY'),TO_DATE('10/08/2021', 'DD/MM/YYYY'));
insert into abonament
values (sala_fitness_seq.nextval,TO_DATE('15/07/2021', 'DD/MM/YYYY'),TO_DATE('15/08/2021', 'DD/MM/YYYY'));
insert into abonament
values (sala_fitness_seq.nextval,TO_DATE('15/07/2020', 'DD/MM/YYYY'),TO_DATE('15/08/2020', 'DD/MM/YYYY'));
insert into abonament
values (sala_fitness_seq.nextval,TO_DATE('12/07/2020', 'DD/MM/YYYY'),TO_DATE('12/08/2020', 'DD/MM/YYYY'));
insert into abonament
values (sala_fitness_seq.nextval,TO_DATE('12/07/2019', 'DD/MM/YYYY'),TO_DATE('12/08/2019', 'DD/MM/YYYY'));
insert into abonament
values (sala_fitness_seq.nextval,null,null);
insert into abonament
values (sala_fitness_seq.nextval,null,null);
select * from abonament;


--abonament_standard
insert into abonament_standard
values (89,TO_DATE('17/11/2021', 'DD/MM/YYYY'),TO_DATE('17/12/2021', 'DD/MM/YYYY'),100);
insert into abonament_standard
values (90,TO_DATE('17/11/2022', 'DD/MM/YYYY'),TO_DATE('17/12/2022', 'DD/MM/YYYY'),100);
insert into abonament_standard
values (91,TO_DATE('17/09/2021', 'DD/MM/YYYY'),TO_DATE('17/10/2021', 'DD/MM/YYYY'),100);
insert into abonament_standard
values (92,TO_DATE('17/07/2021', 'DD/MM/YYYY'),TO_DATE('17/08/2021', 'DD/MM/YYYY'),100);
insert into abonament_standard
values (93,TO_DATE('17/07/2021', 'DD/MM/YYYY'),TO_DATE('17/08/2021', 'DD/MM/YYYY'),100);

--abonament_premium
insert into abonament_premium
values (99,TO_DATE('12/07/2019', 'DD/MM/YYYY'),TO_DATE('12/08/2019', 'DD/MM/YYYY'),200);
insert into abonament_premium
values (95,TO_DATE('10/07/2021', 'DD/MM/YYYY'),TO_DATE('10/08/2021', 'DD/MM/YYYY'),200);
insert into abonament_premium
values (96,TO_DATE('15/07/2021', 'DD/MM/YYYY'),TO_DATE('15/08/2021', 'DD/MM/YYYY'),200);
insert into abonament_premium
values (97,TO_DATE('15/07/2020', 'DD/MM/YYYY'),TO_DATE('15/08/2020', 'DD/MM/YYYY'),200);
insert into abonament_premium
values (98,TO_DATE('12/07/2020', 'DD/MM/YYYY'),TO_DATE('12/08/2020', 'DD/MM/YYYY'),200);
select * from abonament_premium;

--79-83
--95-99
--89 -93
--este_detinut
insert into este_detinut
values (89,79);
insert into este_detinut
values (90,80);
insert into este_detinut
values (91,81);
insert into este_detinut
values (92,82);
insert into este_detinut
values (93,83);
insert into este_detinut
values (95,79);
insert into este_detinut
values (96,80);
insert into este_detinut
values (97,81);
insert into este_detinut
values (98,82);
insert into este_detinut
values (99,83);

select * from lista_clienti;
select * from locatie;
select * from gama_aparate;
select * from gama_suplimente;
select * from lista_departamente;
select * from adresa;
select * from supliment;
select * from aparat_fitness;
select * from clienti;
select * from abonament;
select * from abonament_standard;
select * from abonament_premium;
select * from departament;
select * from angajat;
select * from este_detinut;
select * from apartine;


--sala_de_fitness
desc sala_de_fitness;
insert into sala_de_fitness
values (sala_fitness_seq.nextval,'Spartan Gym',74,'spartan_gym@gmail.com',45,16,25,59);
insert into sala_de_fitness
values (sala_fitness_seq.nextval,'Fit Gym',75,'fit_gym@gmail.com',46,10,26,60);
insert into sala_de_fitness
values (sala_fitness_seq.nextval,'Total Gym',76,'total_gym@gmail.com',47,12,27,61);
insert into sala_de_fitness
values (sala_fitness_seq.nextval,'Power Gym',77,'power_gym@gmail.com',48,13,28,62);
insert into sala_de_fitness
values (sala_fitness_seq.nextval,'Strong Gym',78,'strong_gym@gmail.com',49,14,30,63);
--12
--1) Afisati toate salilie de fitness ce au clienti cu abonamente premium
--si numarul strazii din adresa sali este egal numarul sali cu  numarul strazii din adresa salii unde exista cel putin un angajat prenumele "Mircea
select sf.*
from sala_de_fitness sf, lista_clienti lc, clienti c, este_detinut e,abonament_premium ap
where sf.lista_clienti_id = lc.lista_clienti_id and lc.lista_clienti_id = c.lista_clienti_id and c.client_id = e.client_id and 
e.abonament_id = ap.abonament_id
order by 2;
-- am folosit join, ordonare

--2 afisati suma salariilor angajatilor din fiecare departament,ce au cel putin 1 angjati si contin sirul "ie" in componenta numelui departamentului si
--au acelasi nume cu departamentul cu id-ul 64 si se gaseste angajut cu id-ul 72 si departamentul apartine de lista de departamente cu id-ul 59
select sum(a.salariu),d.nume_departament,count(a.angajat_id)
from   departament d,angajat a
where  a.departament_id = d.departament_id and d.nume_departament like ('%ie%') 
group by d.nume_departament
having count(a.angajat_id) >= 1;
select d.nume_departament,count(a.angajat_id)
from   departament d,angajat a
where  a.departament_id = d.departament_id
group by d.nume_departament;
select max(count(a.angajat_id))
from   departament d,angajat a
where  a.departament_id = d.departament_id
group by d.nume_departament;
-- grupãri de date, func?ii grup, filtrare la nivel de grupuri,filtrare la nivel de linii
--3 Sa se afiseze id-ul listei de clienti, orasele in care extista salile de fitness si denumirile lor ce se afla la aceasi adresa in care se afla si sala ce are id-ul adresei  84
select l.oras,sf.denumire,sf.lista_clienti_id
from sala_de_fitness sf, locatie l, adresa a
where sf.locatie_id = l.locatie_id and l.locatie_id = a.locatie_id and  a.adresa_id in (select a2.adresa_id
                                                                                        from sala_de_fitness sf2, locatie l2, adresa a2
                                                                                        where sf2.locatie_id = l2.locatie_id and l2.locatie_id = a2.locatie_id
                                                                                        and a2.adresa_id between 85 and 87);
                                                                                        
--subereri nesincronizate

--4 Afisati numele angajatului cu litere mari sau daca numele este null afisati 'nu are nume' si lungimea numelui sau 0 daca este null si id-ul departamentului
--care se gaseste in multimea departamentelor care se termina in 'ie'.
with aux as (select departament_id did
        from departament 
        where nume_departament like('_ie%'))
select  upper(nvl(a.nume,'nu are nume')),nvl(length(a.nume),0),d.departament_id,
decode(length(a.nume),5,'bun',4,'foarte bun','rau')
from angajat a, departament d,aux  ax
where a.departament_id = d.departament_id and d.departament_id in ax.did;
--with, 2 functii pentru siruri de caractere,nvl
--5
-- Afisati cand se termina abonamentul cu add_months, ultima zi din luna in care se termina, numele clientului si 'nume mic' pentru nume de 4 carcartere, 'nume mediu' pentru nume
-- de 5 caractere si 'nume mare' pentru 6 pentu clienti ce au lungimea numelei egal cu numele clientilor cu lungime de 4 si cu acelasi abonament ca acestia
select add_months(ab.data_inceput,1),last_day(ab.data_sfarsit),c.nume,
case length(c.nume)
when 4 then 'nume mic'
when 5 then 'nume mediu'
when 6 then 'nume mare'
end
from clienti c, este_detinut ed, abonament ab
where c.client_id = ed.client_id and ab.abonament_id = ed.abonament_id and c.client_id  in (select c2.client_id
                                                                                            from clienti c2, abonament ab2,este_detinut ed2
                                                                                            where c2.client_id = ed2.client_id and ab2.abonament_id = ed2.abonament_id and
                                                                                            length(c2.nume) = length(c.nume) and ab2.abonament_id = ab.abonament_id
                                                                                            and length(c2.nume) = 4);
                                                                                            
--case, 2 functii calendaristice, subcerere sincronizata
commit;
--13
update supliment
set denumire = 'BCAA'
where supliment_id in (select supliment_id
                        from supliment
                        where lower(denumire) = 'taurina');--4 randuri modificate
                        
delete from supliment
where denumire in (select a.denumire
                        from supliment a
                        where pret < 100);-- 2 randuri sterse
update aparat_fitness
set pret = 10000
where denumire in (select denumire
                    from aparat_fitness
                    where aparat_fitness_id in (20,21,22));-- 3 randuri modificate
rollback;
