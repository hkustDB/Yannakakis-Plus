## AggReduce Phase: 

# AggReduce14
# 1. aggView
create or replace view aggView6742675941643258843 as select l_partkey as v17, SUM(l_extendedprice) as v28, COUNT(*) as annot, l_quantity as v5 from lineitem as lineitem group by l_partkey,l_quantity;
# 2. aggJoin
create or replace view aggJoin6604747142795865051 as select p_partkey as v17, p_brand as v20, p_container as v23, v28, v5, annot from part as part, aggView6742675941643258843 where part.p_partkey=aggView6742675941643258843.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';

# AggReduce15
# 1. aggView
create or replace view aggView906440822935240680 as select v1_partkey as v17, COUNT(*) as annot, v1_quantity_avg as v27 from view1 as view1 group by v1_partkey,v1_quantity_avg;
# 2. aggJoin
create or replace view aggJoin7735678078393484090 as select v28*aggView906440822935240680.annot as v28, aggJoin6604747142795865051.annot * aggView906440822935240680.annot as annot from aggJoin6604747142795865051 join aggView906440822935240680 using(v17) where v5 > v27;
# Final result: 
select (SUM(v28) / 7.0) as v29 from aggJoin7735678078393484090;

# drop view aggView6742675941643258843, aggJoin6604747142795865051, aggView906440822935240680, aggJoin7735678078393484090;
