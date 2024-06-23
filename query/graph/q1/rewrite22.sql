
create or replace view c1 as select src, count(*) as cnt from Graph group by src; 
create or replace view f1 as select src, min(cnt) as mf1 from c1 group by src;
create or replace view f2 as select mf1, g1.* from Graph g1 join f1 using (src);
create or replace view f3 as select dst, min(mf1) as mf2 from f2 group by dst;
create or replace view f4 as select mf2, g2.* from Graph g2 join f3 on g2.src=f3.dst;
create or replace view f5 as select dst, min(mf2) as mf3 from f4 group by dst;
create or replace view f6 as select mf3, g3.* from Graph g3 join f5 on g3.src=f5.dst;
create or replace view f7 as select dst, min(mf3) as mf4 from f6 group by dst;
create or replace view f8 as select c2.* from c1 c2 join f7 on c2.src=f7.dst where mf4 < cnt;
create or replace view b1 as select f8.cnt as c2cnt, f6.src as g3src, f6.dst as g3dst from f8 join f6 on f8.src=f6.dst where mf3 < cnt;
create or replace view b2 as select b1.c2cnt, b1.g3dst, f4.src as g2src, f4.dst as g2dst from b1 join f4 on b1.g3src=f4.dst where mf2 < c2cnt;
create or replace view b3 as select b2.c2cnt, b2.g3dst, b2.g2dst, f2.src as g1src, f2.dst as g1dst from b2 join f2 on b2.g2src=f2.dst where mf1 < c2cnt;
create or replace view b4 as select b3.*, c1.cnt as c1cnt from b3 join c1 on b3.g1src=c1.src where c1.cnt < c2cnt;
select sum(g1src + g1dst + g2dst + g3dst + c1cnt + c2cnt) from b4;
