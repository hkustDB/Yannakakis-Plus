create or replace view aggView429061920924446705 as select l_partkey as v17, SUM(l_extendedprice) as v28, l_quantity as v5 from lineitem as lineitem group by l_partkey,l_quantity;
create or replace view aggJoin6652283243938407469 as select v1_partkey as v17, v28 from q17_inner as q17_inner, aggView429061920924446705 where q17_inner.v1_partkey=aggView429061920924446705.v17 and v5>v1_quantity_avg;
create or replace view aggView7019576003252797757 as select p_partkey as v17 from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggJoin1718644193224381337 as select v28 from aggJoin6652283243938407469 join aggView7019576003252797757 using(v17);
select (SUM(v28) / 7.0) as v29 from aggJoin1718644193224381337;
