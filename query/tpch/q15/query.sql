create or replace view res as select distinct s_suppkey, s_name, s_address, s_phone, total_revenue
from supplier, revenue0, q15_inner
where s_suppkey = supplier_no
  and total_revenue = q15_inner.max_tr
order by s_suppkey;

select sum(s_suppkey), sum(s_name), sum(s_address), sum(s_phone), sum(total_revenue) from res;
