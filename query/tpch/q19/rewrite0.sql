create or replace view aggView2068835558014286483 as select p_partkey as v17 from part as part where p_brand= 'Brand#34' and p_size>=1 and p_container IN ('LG CASE','LG BOX','LG PACK','LG PKG') and p_size<=15;
create or replace view aggJoin7972085346829225441 as select l_quantity as v5, l_extendedprice as v6, l_discount as v7, l_shipinstruct as v14, l_shipmode as v15 from lineitem as lineitem, aggView2068835558014286483 where lineitem.l_partkey=aggView2068835558014286483.v17 and l_quantity>=21 and l_shipinstruct= 'DELIVER IN PERSON' and l_quantity<=21 + 10 and l_shipmode IN ('AIR','AIR REG');
create or replace view aggView4478152556218582633 as select v7, v6, COUNT(*) as annot from aggJoin7972085346829225441;
select SUM((v6 * (1 - v7))* annot) as v27 from aggView4478152556218582633;
