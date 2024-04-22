create or replace view aggJoin5509769629379787556 as (
with aggView4240089035803763797 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView4240089035803763797 where mc.company_id=aggView4240089035803763797.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin823255645239637691 as (
with aggView7315745410736175460 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView7315745410736175460 where mi_idx.info_type_id=aggView7315745410736175460.v12 and info<'7.0');
create or replace view aggJoin927658627768145997 as (
with aggView8906974640316621397 as (select v37, MIN(v32) as v50 from aggJoin823255645239637691 group by v37)
select id as v37, title as v38, kind_id as v17, production_year as v41, v50 from title as t, aggView8906974640316621397 where t.id=aggView8906974640316621397.v37 and production_year>2009);
create or replace view aggJoin7161109992327157041 as (
with aggView3945470057918681452 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin5509769629379787556 join aggView3945470057918681452 using(v8));
create or replace view aggJoin1768460570962402106 as (
with aggView7428727424845426605 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41, v50 from aggJoin927658627768145997 join aggView7428727424845426605 using(v17));
create or replace view aggJoin2579578975508051145 as (
with aggView234938649270338769 as (select v37, MIN(v49) as v49 from aggJoin7161109992327157041 group by v37,v49)
select movie_id as v37, info_type_id as v10, info as v27, v49 from movie_info as mi, aggView234938649270338769 where mi.movie_id=aggView234938649270338769.v37 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin677866026271488130 as (
with aggView8300390455193063552 as (select id as v10 from info_type as it1 where info= 'countries')
select v37, v27, v49 from aggJoin2579578975508051145 join aggView8300390455193063552 using(v10));
create or replace view aggJoin2665897353744375229 as (
with aggView6192405452981092897 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView6192405452981092897 where mk.keyword_id=aggView6192405452981092897.v14);
create or replace view aggJoin1086446655480802625 as (
with aggView1188842531215645743 as (select v37, MIN(v49) as v49 from aggJoin677866026271488130 group by v37,v49)
select v37, v38, v41, v50 as v50, v49 from aggJoin1768460570962402106 join aggView1188842531215645743 using(v37));
create or replace view aggJoin7410040879696426009 as (
with aggView7998598641368927207 as (select v37, MIN(v50) as v50, MIN(v49) as v49, MIN(v38) as v51 from aggJoin1086446655480802625 group by v37,v49,v50)
select v50, v49, v51 from aggJoin2665897353744375229 join aggView7998598641368927207 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin7410040879696426009;
