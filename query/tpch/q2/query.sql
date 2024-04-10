create or replace view res as SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment
FROM part, supplier, partsupp, nation, region, q2_inner
WHERE p_partkey = ps_partkey
  AND s_suppkey = ps_suppkey
  AND p_size = 15
  AND p_type LIKE '%BRASS'
  AND s_nationkey = n_nationkey
  AND n_regionkey = r_regionkey
  AND r_name = 'EUROPE'
  AND p_partkey = v1_partkey
  AND ps_supplycost = v1_supplycost_min;
select sum(s_acctbal), sum(s_acctbal), sum(s_name), sum(n_name), sum(p_partkey), sum(p_mfgr), sum(s_address), sum(s_phone), sum(s_comment) from res;