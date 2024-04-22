create or replace view aggJoin8128906958581192323 as (
with aggView9085131505963956793 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView9085131505963956793 where mc.company_id=aggView9085131505963956793.v1);
create or replace view aggJoin5733968795739335746 as (
with aggView4548371500690254029 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView4548371500690254029 where mi.info_type_id=aggView4548371500690254029.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin5203913349123973116 as (
with aggView1439359225046050344 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView1439359225046050344 where mk.keyword_id=aggView1439359225046050344.v14);
create or replace view aggJoin4661992909853500427 as (
with aggView855680853778975658 as (select v37 from aggJoin5733968795739335746 group by v37)
select v37, v8, v49 as v49 from aggJoin8128906958581192323 join aggView855680853778975658 using(v37));
create or replace view aggJoin2197923222394859861 as (
with aggView7807549004707781735 as (select id as v8 from company_type as ct)
select v37, v49 from aggJoin4661992909853500427 join aggView7807549004707781735 using(v8));
create or replace view aggJoin1253101713104400141 as (
with aggView8240707836340892285 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView8240707836340892285 where mi_idx.info_type_id=aggView8240707836340892285.v12 and info<'8.5');
create or replace view aggJoin829352083416610889 as (
with aggView1361195615358273907 as (select v37, MIN(v32) as v50 from aggJoin1253101713104400141 group by v37)
select v37, v49 as v49, v50 from aggJoin2197923222394859861 join aggView1361195615358273907 using(v37));
create or replace view aggJoin528159515059036745 as (
with aggView101397252346746813 as (select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin829352083416610889 group by v37,v50,v49)
select id as v37, title as v38, kind_id as v17, production_year as v41, v49, v50 from title as t, aggView101397252346746813 where t.id=aggView101397252346746813.v37 and production_year>2005);
create or replace view aggJoin2672025302778882710 as (
with aggView8138862804899059924 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41, v49, v50 from aggJoin528159515059036745 join aggView8138862804899059924 using(v17));
create or replace view aggJoin5381826990602185538 as (
with aggView5426390098617714037 as (select v37, MIN(v49) as v49, MIN(v50) as v50, MIN(v38) as v51 from aggJoin2672025302778882710 group by v37,v50,v49)
select v49, v50, v51 from aggJoin5203913349123973116 join aggView5426390098617714037 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin5381826990602185538;
