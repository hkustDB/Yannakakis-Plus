create or replace view g2_1 as select src, dst from Graph g3 where (src) in (select dst from Graph g1);
create or replace view g3_1 as select src, dst from Graph g2 where (src) in (select dst from g2_1);
create or replace view g4_1 as select src, dst from Graph g1 where (src) in (select dst from g3_1);

create or replace view g3_2 as select src, dst from g3_1 where (dst) in (select src from g1_1);
create or replace view g2_2 as select src, dst from g2_1 where (dst) in (select src from g3_2);
create or replace view g1_2 as select src, dst from Graph g1 where (dst) in (select src from g2_2);

create or replace view g2_3 as select g1_2.src as g1src, g2_2.dst as g2dst from g1_2, g2_2 where g1_2.dst=g2_2.src;
create or replace view g3_3 as select g1src, g3_2.dst as g3dst from g2_3, g3_2 where g2_3.g2dst=g3_2.src;
create or replace view res as select distinct g1src, g4_1.dst from g3_3, g4_1 where g3_3.g3dst=g4_1.src;
select sum(g1src+dst) from res;