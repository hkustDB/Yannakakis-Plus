## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView8137247462886903178 as select l_partkey as v2, l_extendedprice * (1 - l_discount) as caseRes, SUM(l_extendedprice * (1 - l_discount)) as v29, COUNT(*) as annot from lineitem as lineitem where l_shipdate>=DATE '1995-09-01' and l_shipdate<DATE '1995-10-01' group by l_partkey,caseRes;
# 2. aggJoin
create or replace view aggJoin3577566589011594069 as select p_type as v21, caseRes, v29, annot from part as part, aggView8137247462886903178 where part.p_partkey=aggView8137247462886903178.v2;
# Final result: 
select ((100.0 * SUM( CASE WHENv21 LIKE 'PROMO%' THEN caseRes *annotELSE 0.0 END)) / SUM(v29)) as v30 from aggJoin3577566589011594069;

# drop view aggView8137247462886903178, aggJoin3577566589011594069;
