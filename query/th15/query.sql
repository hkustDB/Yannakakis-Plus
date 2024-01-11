select s_suppkey, s_name, s_address, s_phone, total_revenue
from supplier, revenue0, q15_inners
where s_suppkey = supplier_no
  and total_revenue = q15_inner.max_tr
order by s_suppkey;