create or replace view aggJoin7727074616631936471 as (
with aggView3917030810874671188 as (select production_year as v19, id as v15, title as v16 from title as t)
select v15, v16, v19 from aggView3917030810874671188 where v19>2010);
create or replace view aggJoin8613871491901467401 as (
with aggView4057698428871185188 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView4057698428871185188 where mi_idx.info_type_id=aggView4057698428871185188.v3);
create or replace view aggJoin9085954216398002738 as (
with aggView5318087759578478578 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView5318087759578478578 where mc.company_type_id=aggView5318087759578478578.v1);
create or replace view aggJoin7566003747261133751 as (
with aggView4652307683479267419 as (select v15 from aggJoin8613871491901467401 group by v15)
select v15, v9 from aggJoin9085954216398002738 join aggView4652307683479267419 using(v15));
create or replace view aggJoin3209902669791340395 as (
with aggView3988869041269489291 as (select v15, v9 from aggJoin7566003747261133751 group by v15,v9)
select v15, v9 from aggView3988869041269489291 where v9 LIKE '%(co-production)%' and v9 NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggJoin5573204519692840163 as (
with aggView8417608053129143297 as (select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin7727074616631936471 group by v15)
select v9, v28, v29 from aggJoin3209902669791340395 join aggView8417608053129143297 using(v15));
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5573204519692840163;
