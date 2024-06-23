create or replace view p_new as select p_partkey, p_mfgr from part where p_size=15 and p_type LIKE '%BRASS';
create or replace view ps_new as select ps_partkey, ps_supplycost, ps_suppkey from partsupp where (ps_suppkey) in (select s_suppkey from supplier);
create or replace view bag as select p_partkey, p_mfgr, ps_suppkey from p_new, ps_new, q2_inner where p_partkey=ps_partkey and ps_supplycost=v1_supplycost_min and p_partkey = v1_partkey;
create or replace view n_new as select n_name, n_nationkey from nation where (n_regionkey) in (select r_regionkey from region where r_name= 'EUROPE');
create or replace view s_new as select s_acctbal, s_name, p_partkey, p_mfgr, s_address, s_phone, s_comment, s_nationkey from supplier, bag where s_suppkey = ps_suppkey;
create or replace view res as select distinct s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment from s_new, n_new where s_nationkey = n_nationkey;
select sum(s_acctbal), sum(s_name), sum(n_name), sum(p_partkey), sum(p_mfgr), sum(s_address), sum(s_phone), sum(s_comment) from res;