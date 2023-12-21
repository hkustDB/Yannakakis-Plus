select s.suppkey, s.name, s.address, s.phone, total_revenue
from supplier s, revenue0, q15_inner
where s.suppkey = supplier_no
  and total_revenue = q15_inner.max_tr