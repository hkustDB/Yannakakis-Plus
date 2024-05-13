create or replace view aggView2116364424200266145 as select p_partkey as v6 from part as part where p_brand<> 'Brand#45' and p_type NOT LIKE 'MEDIUM POLISHED%' and p_size IN (49,14,23,45,19,3,36,9);
create or replace view aggJoin8274835917679219855 as select  from partsupp as partsupp, aggView2116364424200266145 where partsupp.ps_partkey=aggView2116364424200266145.v6;
select v9,v10,v11,COUNT(*) as v15 from aggJoin8274835917679219855 group by v9, v10, v11;
