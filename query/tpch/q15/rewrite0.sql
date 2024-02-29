create or replace view s_new as select s_suppkey, s_name, s_address, s_phone from supplier;
create or replace view rev_new as select total_revenue, supplier_no from revenue0 where total_revenue in (select max_tr from q15_inner);
select distinct s_suppkey, s_name, s_address, s_phone, total_revenue from s_new, rev_new where s_suppkey = supplier_no;