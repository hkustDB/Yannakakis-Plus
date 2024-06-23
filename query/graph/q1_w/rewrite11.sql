
create or replace view c1 as select src, count(*) as cnt from wiki group by src; 
create or replace view f1 as select src, min(cnt) as mf1 from c1 group by src;
create or replace view f2 as select mf1, g1.* from wiki g1 join f1 using (src);
create or replace view f3 as select dst, min(mf1) as mf2 from f2 group by dst;
create or replace view f4 as select mf2, g2.* from wiki g2 join f3 on g2.src=f3.dst;
create or replace view f5 as select src, max(cnt) as mf3 from c1 c2 group by src;
create or replace view f6 as select mf3, g3.* from wiki g3 join f5 on g3.dst=f5.src;
create or replace view f7 as select src, max(mf3) as mf4 from f6 group by src;
create or replace view f8 as select mf2, f4.src as g2src, f4.dst as g2dst from f4 join f7 on f4.dst=f7.src where mf2 < mf4;
create or replace view b1 as select mf2, f8.g2src, f8.g2dst, f6.dst as g3dst from f8 join f6 on f8.g2dst=f6.src where mf2 < mf3;
create or replace view b2 as select b1.g2src, b1.g2dst, b1.g3dst, c2.cnt as c2cnt from b1 join c1 c2 on b1.g3dst=c2.src where mf2 < c2.cnt;
create or replace view b3 as select b2.g2dst, b2.g3dst, b2.c2cnt, f2.src as g1src, f2.dst as g1dst from b2 join f2 on b2.g2src=f2.dst where mf1 < c2cnt;
create or replace view b4 as select b3.g2dst, b3.g3dst, b3.c2cnt, b3.g1src, b3.g1dst, c1.cnt as c1cnt from b3 join c1 on b3.g1src=c1.src where cnt < c2cnt;
/*+QUERY_TIMEOUT=86400000*/select sum(g1src+g1dst+g2dst+g3dst+c1cnt+c2cnt) from b4;