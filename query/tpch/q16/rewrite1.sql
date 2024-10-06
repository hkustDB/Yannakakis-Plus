create or replace view aggView5455802152684778280 as select p_partkey as v6, p_size as v11, p_brand as v9, p_type as v10 from part as part where p_brand<> 'Brand#45' and p_type NOT LIKE 'MEDIUM POLISHED%' and p_size IN (49,14,23,45,19,3,36,9);
create or replace view aggJoin2326403689263027316 as select v11, v9, v10 from partsupp as partsupp, aggView5455802152684778280 where partsupp.ps_partkey=aggView5455802152684778280.v6;
select v9, v10, v11, COUNT(*) as v15 from aggJoin2326403689263027316 group by v9, v10, v11;
