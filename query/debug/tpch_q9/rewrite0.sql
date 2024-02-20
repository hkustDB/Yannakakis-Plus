## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView194587540554087587 as select o_orderkey as v38, o_year as v39, COUNT(*) as annot from orderswithyear as orderswithyear group by o_orderkey,o_year;
# 2. aggJoin
create or replace view aggJoin3008582906055050812 as select v38, v39, annot from aggView194587540554087587;

# AggReduce1
# 1. aggView
create or replace view aggView5206237229937142296 as select n_name as v49, n_nationkey as v13, COUNT(*) as annot from nation as nation group by n_name,n_nationkey;
# 2. aggJoin
create or replace view aggJoin1780670125463013160 as select v13, v49, annot from aggView5206237229937142296;

# AggReduce2
# 1. aggView
create or replace view aggView2150352895606907610 as select ps_suppkey as v10, ps_partkey as v33, ps_supplycost as v36, COUNT(*) as annot from partsupp as partsupp group by ps_suppkey,ps_partkey;
# 2. aggJoin
create or replace view aggJoin4365387006319557900 as select l_orderkey as v38, l_partkey as v33, l_suppkey as v10, l_quantity as v21, l_extendedprice as v22, l_discount as v23, v36, annot from lineitem as lineitem, aggView2150352895606907610 where lineitem.l_suppkey=aggView2150352895606907610.v10 and lineitem.l_partkey=aggView2150352895606907610.v33;

# AggReduce3
# 1. aggView
create or replace view aggView8244107260930546220 as select p_partkey as v33, COUNT(*) as annot from part as part where p_name LIKE '%green%' group by p_partkey;
# 2. aggJoin
create or replace view aggJoin8632285117859968016 as select v38, v10, v21, v22, v23, v36, aggJoin4365387006319557900.annot * aggView8244107260930546220.annot as annot from aggJoin4365387006319557900 join aggView8244107260930546220 using(v33);

##Reduce Phase: 

# Reduce0
# +. SemiJoin
create or replace view semiJoinView8347552004977642000 as select s_suppkey as v10, s_nationkey as v13 from supplier AS supplier where (s_nationkey) in (select v13 from aggJoin1780670125463013160);

# Reduce1
# +. SemiJoin
create or replace view semiJoinView5669367909849194373 as select v38, v10, v21, v22, v23, v36, annot from aggJoin8632285117859968016 where (v10) in (select v10 from semiJoinView8347552004977642000);

# Reduce2
# +. SemiJoin
create or replace view semiJoinView900530167821079710 as select v38, v39, annot from aggJoin3008582906055050812 where (v38) in (select v38 from semiJoinView5669367909849194373);

## Enumerate Phase: 

# Enumerate0
# +. SemiEnumerate
create or replace view semiEnum7978516467259744334 as select v39, semiJoinView900530167821079710.annot * semiJoinView5669367909849194373.annot as annot, v10 from semiJoinView900530167821079710 join semiJoinView5669367909849194373 using(v38);

# Enumerate1
# +. SemiEnumerate
create or replace view semiEnum3767403097375061074 as select v39, annot, v13 from semiEnum7978516467259744334 join semiJoinView8347552004977642000 using(v10);

# Enumerate2
# +. SemiEnumerate
create or replace view semiEnum5871748362526280716 as select v49, v39 from semiEnum3767403097375061074 join aggJoin1780670125463013160 using(v13);
# Final result: 
select v49,v39,SUM(v54) as v54,SUM(v55) as v55 from semiEnum5871748362526280716 group by v49, v39;

# drop view aggView194587540554087587, aggJoin3008582906055050812, aggView5206237229937142296, aggJoin1780670125463013160, aggView2150352895606907610, aggJoin4365387006319557900, aggView8244107260930546220, aggJoin8632285117859968016, semiJoinView8347552004977642000, semiJoinView5669367909849194373, semiJoinView900530167821079710, semiEnum7978516467259744334, semiEnum3767403097375061074, semiEnum5871748362526280716;
