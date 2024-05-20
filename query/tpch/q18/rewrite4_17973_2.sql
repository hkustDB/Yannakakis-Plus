SET max_parallel_workers_per_gather=72;
SET max_parallel_workers=72;
create extension if not exists pg_prewarm;
select pg_prewarm('partsupp');
select pg_prewarm('part');
select pg_prewarm('supplier');
select pg_prewarm('nation');
COPY (
select c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, sum(l_sum) from bag1, q_new where o_orderkey = v1_orderkey group by c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice) TO '/dev/null' DELIMITER ',' CSV;
