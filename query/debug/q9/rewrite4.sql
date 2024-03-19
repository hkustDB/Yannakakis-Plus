create or replace view g3_1 as select src, dst from Graph g3 where (dst) in (select src from Graph g4);
create or replace view g2_1 as select src, dst from Graph g2 where (dst) in (select src from g3_1);
create or replace view g1_1 as select src, dst from Graph g1 where (dst) in (select src from g2_1);

create or replace view g2_2 as select src, dst from g2_1 where (src) in (select dst from g1_1);
create or replace view g3_2 as select src, dst from g3_1 where (src) in (select dst from g2_2);
create or replace view g4_2 as select src, dst from Graph g4 where (src) in (select dst from g3_2);

create or replace view g3_3 as select g3_2.src as g3src, g4_2.dst as g4dst from g3_2, g4_2 where g3_2.dst=g4_2.src;
create or replace view g2_3 as select g2_2.src as g2src, g4dst from g3_3, g2_2 where g3_3.g3src=g2_2.dst;
create or replace view res as select distinct g1_1.src, g4dst from g2_3, g1_1 where g2src=dst;
select sum(src+g4dst);