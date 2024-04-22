create or replace view aggView8471798695050444056 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin8544253623148497440 as (
with aggView5219549741674631533 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView5219549741674631533 where t.kind_id=aggView5219549741674631533.v17 and production_year>2005);
create or replace view aggView2564468752623582318 as select v38, v37 from aggJoin8544253623148497440 group by v38,v37;
create or replace view aggJoin8590098609896373026 as (
with aggView1185686311017693141 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView1185686311017693141 where mi_idx.info_type_id=aggView1185686311017693141.v12);
create or replace view aggJoin2447868362410547905 as (
with aggView5330325783382326119 as (select v37, v32 from aggJoin8590098609896373026 group by v37,v32)
select v37, v32 from aggView5330325783382326119 where v32<'8.5');
create or replace view aggJoin7935913376396899933 as (
with aggView6912106369522083696 as (select v37, MIN(v32) as v50 from aggJoin2447868362410547905 group by v37)
select v38, v37, v50 from aggView2564468752623582318 join aggView6912106369522083696 using(v37));
create or replace view aggJoin8160345417126678113 as (
with aggView51863539159093967 as (select v37, MIN(v50) as v50, MIN(v38) as v51 from aggJoin7935913376396899933 group by v37,v50)
select movie_id as v37, company_id as v1, company_type_id as v8, note as v23, v50, v51 from movie_companies as mc, aggView51863539159093967 where mc.movie_id=aggView51863539159093967.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1489419026011287921 as (
with aggView4834796088154006772 as (select id as v8 from company_type as ct)
select v37, v1, v23, v50, v51 from aggJoin8160345417126678113 join aggView4834796088154006772 using(v8));
create or replace view aggJoin4334822168918085310 as (
with aggView2066381266838222227 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView2066381266838222227 where mi.info_type_id=aggView2066381266838222227.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin6857359076608996065 as (
with aggView5032265772548222787 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView5032265772548222787 where mk.keyword_id=aggView5032265772548222787.v14);
create or replace view aggJoin5108781242703146857 as (
with aggView4384507039758592110 as (select v37 from aggJoin6857359076608996065 group by v37)
select v37, v27 from aggJoin4334822168918085310 join aggView4384507039758592110 using(v37));
create or replace view aggJoin5083538104542914430 as (
with aggView8064948925270632368 as (select v37 from aggJoin5108781242703146857 group by v37)
select v1, v23, v50 as v50, v51 as v51 from aggJoin1489419026011287921 join aggView8064948925270632368 using(v37));
create or replace view aggJoin2338508045414004721 as (
with aggView9041021388389101539 as (select v1, MIN(v50) as v50, MIN(v51) as v51 from aggJoin5083538104542914430 group by v1,v51,v50)
select v2, v50, v51 from aggView8471798695050444056 join aggView9041021388389101539 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin2338508045414004721;
