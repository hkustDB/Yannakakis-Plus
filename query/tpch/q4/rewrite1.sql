create or replace view o_new as select o_orderkey, o_orderpriority from orders where o_orderdate >= DATE '1993-07-01' AND o_orderdate < DATE '1993-10-01';
create or replace view res as select o_orderpriority, COUNT(*) AS order_count from lineitem, o_new where l_orderkey = o_orderkey group by o_orderpriority;
select sum(o_orderpriority), sum(order_count) from res;