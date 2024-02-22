create or replace view aggView4357634902556271438 as select v1_partkey as v17, COUNT(*) as annot, v1_quantity_avg as v27 from view1 as view1 group by v1_partkey,v1_quantity_avg;
create or replace view aggJoin8151906681630517938 as select l_partkey as v17, l_extendedprice as v6, annot from lineitem as lineitem, aggView4357634902556271438 where lineitem.l_partkey=aggView4357634902556271438.v17 and l_quantity>v27;
create or replace view aggView4085778507635018403 as select v17, SUM(v6 * annot) as v28, SUM(annot) as annot from aggJoin8151906681630517938 group by v17;
create or replace view aggJoin2573140488191151600 as select v28, annot from part as part, aggView4085778507635018403 where part.p_partkey=aggView4085778507635018403.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
select (SUM(v28) / 7.0) as v29 from aggJoin2573140488191151600;
