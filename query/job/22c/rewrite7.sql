create or replace view aggView716030016625528907 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin7114739725983888888 as (
with aggView3155425898764745467 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView3155425898764745467 where t.kind_id=aggView3155425898764745467.v17 and production_year>2005);
create or replace view aggView6529999647456241932 as select v38, v37 from aggJoin7114739725983888888 group by v38,v37;
create or replace view aggJoin2212632514643748470 as (
with aggView5502853897116050743 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView5502853897116050743 where mi_idx.info_type_id=aggView5502853897116050743.v12 and info<'8.5');
create or replace view aggJoin3447213928109843695 as (
with aggView4971633377673774889 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView4971633377673774889 where mi.info_type_id=aggView4971633377673774889.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin2481426495846436702 as (
with aggView8273008724604182327 as (select v37 from aggJoin3447213928109843695 group by v37)
select v37, v32 from aggJoin2212632514643748470 join aggView8273008724604182327 using(v37));
create or replace view aggJoin6785640384953735126 as (
with aggView5175695991275431525 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView5175695991275431525 where mk.keyword_id=aggView5175695991275431525.v14);
create or replace view aggJoin1863114287686149992 as (
with aggView6012338596715464678 as (select v37 from aggJoin6785640384953735126 group by v37)
select v37, v32 from aggJoin2481426495846436702 join aggView6012338596715464678 using(v37));
create or replace view aggView6138157123947087653 as select v37, v32 from aggJoin1863114287686149992 group by v37,v32;
create or replace view aggJoin3124469593310953799 as (
with aggView6073949429097989064 as (select v37, MIN(v32) as v50 from aggView6138157123947087653 group by v37)
select v38, v37, v50 from aggView6529999647456241932 join aggView6073949429097989064 using(v37));
create or replace view aggJoin461007208472176001 as (
with aggView5022586729008744392 as (select v37, MIN(v50) as v50, MIN(v38) as v51 from aggJoin3124469593310953799 group by v37,v50)
select company_id as v1, company_type_id as v8, note as v23, v50, v51 from movie_companies as mc, aggView5022586729008744392 where mc.movie_id=aggView5022586729008744392.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin8182357694654925532 as (
with aggView5652745446007976913 as (select id as v8 from company_type as ct)
select v1, v23, v50, v51 from aggJoin461007208472176001 join aggView5652745446007976913 using(v8));
create or replace view aggJoin4489839342337842808 as (
with aggView1022973145463937329 as (select v1, MIN(v50) as v50, MIN(v51) as v51 from aggJoin8182357694654925532 group by v1,v51,v50)
select v2, v50, v51 from aggView716030016625528907 join aggView1022973145463937329 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin4489839342337842808;
