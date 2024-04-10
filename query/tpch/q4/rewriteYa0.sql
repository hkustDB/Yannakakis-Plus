create or replace view semiUp831777064228239155 as select o_orderkey as v10, o_orderpriority as v6 from orders AS o where (o_orderkey) in (select l_orderkey from lineitem AS l where l_commitdate<l_receiptdate) and o_orderdate>=DATE '1993-07-01' and o_orderdate<DATE '1993-10-01';
create or replace view oAux80 as select v6 from semiUp831777064228239155;
create or replace view semiDown9178030632024118932 as select v10, v6 from semiUp831777064228239155 where (v6) in (select v6 from oAux80);
create or replace view semiDown627193196217652378 as select l_orderkey as v10 from lineitem AS l where (l_orderkey) in (select v10 from semiDown9178030632024118932) and l_commitdate<l_receiptdate;
create or replace view aggView867157019264985934 as select v10, COUNT(*) as annot from semiDown627193196217652378 group by v10;
create or replace view aggJoin5714319780064003280 as select v6, annot from semiDown9178030632024118932 join aggView867157019264985934 using(v10);
create or replace view aggView5341435171096014815 as select v6, SUM(annot) as annot from aggJoin5714319780064003280 group by v6;
create or replace view res as select v6, annot as v26 from aggView5341435171096014815;
select sum(v6+v26) from res;
