select s.suppkey, s.name, s.address, s.phone, total_revenue
from supplier s, revenue0
where s.suppkey = s.no
  and total_revenue = inner.max_tr