create or replace view aggView5563724407975078527 as select p_partkey as v17 from part as part where p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggJoin1236420436613519635 as select v1_partkey as v17, v1_quantity_avg as v27 from q17_inner as q17_inner, aggView5563724407975078527 where q17_inner.v1_partkey=aggView5563724407975078527.v17;
create or replace view aggView8138026789608449191 as select v17, COUNT(*) as annot, v27 from aggJoin1236420436613519635 group by v17,v27;
create or replace view aggJoin2469996320758832440 as select l_quantity as v5, l_extendedprice as v6, v27, annot from lineitem as lineitem, aggView8138026789608449191 where lineitem.l_partkey=aggView8138026789608449191.v17 and l_quantity>v27;
create or replace view aggView8270504379872389917 as select v6, SUM(annot) as annot from aggJoin2469996320758832440 group by v6;
select SUM((v6)* annot) / 7.0 as v29 from aggView8270504379872389917;
