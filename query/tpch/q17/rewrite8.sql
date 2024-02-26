create or replace view aggView3852887306932670422 as select v1_partkey as v17, COUNT(*) as annot, v1_quantity_avg as v27 from q17_inner as q17_inner group by v1_partkey,v1_quantity_avg;
create or replace view aggJoin5740026398566548785 as select l_partkey as v17, l_extendedprice as v6, annot from lineitem as lineitem, aggView3852887306932670422 where lineitem.l_partkey=aggView3852887306932670422.v17 and l_quantity>v27;
create or replace view aggView7252631102129728444 as select v17, SUM(v6 * annot) as v28, SUM(annot) as annot from aggJoin5740026398566548785 group by v17;
create or replace view aggJoin5033425159088448499 as select v28, annot from part as part, aggView7252631102129728444 where part.p_partkey=aggView7252631102129728444.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
select (SUM(v28) / 7.0) as v29 from aggJoin5033425159088448499;
