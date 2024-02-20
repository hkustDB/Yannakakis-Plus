## AggReduce Phase: 

# AggReduce6
# 1. aggView
create or replace view aggView7222736011100452916 as select r_regionkey as v43, COUNT(*) as annot from region as region where r_name= 'ASIA' group by r_regionkey;
# 2. aggJoin
create or replace view aggJoin8630849562741156674 as select n_nationkey as v4, n_name as v42, annot from nation as nation, aggView7222736011100452916 where nation.n_regionkey=aggView7222736011100452916.v43;

# AggReduce7
# 1. aggView
create or replace view aggView6503502323020851758 as select c_custkey as v1, COUNT(*) as annot from customer as customer group by c_custkey;
# 2. aggJoin
create or replace view aggJoin7936149866572597107 as select o_orderkey as v18, annot from orders as orders, aggView6503502323020851758 where orders.o_custkey=aggView6503502323020851758.v1 and o_orderdate>=DATE '1994-01-01' and o_orderdate<DATE '1995-01-01';

# AggReduce8
# 1. aggView
create or replace view aggView6082842927349963173 as select v18, SUM(annot) as annot from aggJoin7936149866572597107 group by v18;
# 2. aggJoin
create or replace view aggJoin6110696094505760481 as select l_suppkey as v20, l_extendedprice as v23, l_discount as v24, annot from lineitem as lineitem, aggView6082842927349963173 where lineitem.l_orderkey=aggView6082842927349963173.v18;

# AggReduce9
# 1. aggView
create or replace view aggView4013379991854462849 as select v20, SUM((v23 * (1 - v24)) * annot) as v49, SUM(annot) as annot from aggJoin6110696094505760481 group by v20;
# 2. aggJoin
create or replace view aggJoin3591110189720713080 as select s_nationkey as v4, v49, annot from supplier as supplier, aggView4013379991854462849 where supplier.s_suppkey=aggView4013379991854462849.v20;

# AggReduce10
# 1. aggView
create or replace view aggView4335078959491330261 as select v4, SUM(v49) as v49, SUM(annot) as annot from aggJoin3591110189720713080 group by v4;
# 2. aggJoin
create or replace view aggJoin4446034983137085434 as select v42, aggJoin8630849562741156674.annot * aggView4335078959491330261.annot as annot, v49 * aggJoin8630849562741156674.annot as v49 from aggJoin8630849562741156674 join aggView4335078959491330261 using(v4);

# AggReduce11
# 1. aggView
create or replace view aggView306264869195598006 as select v42, SUM(v49) as v49 from aggJoin4446034983137085434 group by v42;
# 2. aggJoin
create or replace view aggJoin2453632660920262647 as select v42, v49 from aggView306264869195598006;
# Final result: 
select v42,v49 from aggJoin2453632660920262647;

# drop view aggView7222736011100452916, aggJoin8630849562741156674, aggView6503502323020851758, aggJoin7936149866572597107, aggView6082842927349963173, aggJoin6110696094505760481, aggView4013379991854462849, aggJoin3591110189720713080, aggView4335078959491330261, aggJoin4446034983137085434, aggView306264869195598006, aggJoin2453632660920262647;
