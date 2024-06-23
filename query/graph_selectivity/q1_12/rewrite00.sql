
create or replace view c1 as select src, count(*) as cnt from Graph group by src; 
create or replace view f1 as select g1.*, cnt as c1cnt from Graph g1 join c1 using(src);
create or replace view f2 as select g3.*, cnt as c2cnt from Graph g3 join c1 c2 on g3.dst=c2.src;
create or replace view f3 as select dst, min(c1cnt) as mf1 from f1 group by dst;
create or replace view f4 as select mf1, g2.* from Graph g2 join f3 on g2.src=f3.dst;
create or replace view f5 as select src, max(c2cnt) as mf2 from f2 group by src;
create or replace view f6 as select f4.* from f4 join f5 on f4.dst=f5.src where mf1 +2000< mf2;
create or replace view b1 as select f6.src as g2src, f6.dst as g2dst, f2.dst as g3dst, f2.c2cnt from f6 join f2 on f6.dst=f2.src where mf1 +2000< c2cnt;
create or replace view b2 as select f1.src as g1src, f1.dst as g1dst, f1.c1cnt, b1.g2dst, b1.g3dst, b1.c2cnt from b1 join f1 on g2src=f1.dst where c1cnt +2000<c2cnt;
select sum(g1src+g1dst+g2dst+g3dst+c1cnt+c2cnt) from b2;