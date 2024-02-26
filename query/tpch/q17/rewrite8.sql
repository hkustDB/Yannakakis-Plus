create or replace view aggView3852887306932670422 as select v1_partkey as v17, v1_quantity_avg as v27 from q17_inner as q17_inner;
create or replace view aggJoin5740026398566548785 as select l_partkey as v17, l_extendedprice as v6 from lineitem as lineitem, aggView3852887306932670422 where lineitem.l_partkey=aggView3852887306932670422.v17 and l_quantity>v27;
create or replace view aggView7252631102129728444 as select v17, SUM(v6) as v28 from aggJoin5740026398566548785 group by v17;
create or replace view aggJoin5033425159088448499 as select v28 from part as part, aggView7252631102129728444 where part.p_partkey=aggView7252631102129728444.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
select (SUM(v28) / 7.0) as v29 from aggJoin5033425159088448499;
