create or replace view aggJoin4723590060882771052 as (
with aggView8421287986191695218 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView8421287986191695218 where mc.company_id=aggView8421287986191695218.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1106004632624460799 as (
with aggView2594080584632002494 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView2594080584632002494 where t.kind_id=aggView2594080584632002494.v25 and production_year>2005);
create or replace view aggJoin8914582945475180379 as (
with aggView516830019945620099 as (select v45, MIN(v46) as v59 from aggJoin1106004632624460799 group by v45)
select movie_id as v45, subject_id as v5, status_id as v7, v59 from complete_cast as cc, aggView516830019945620099 where cc.movie_id=aggView516830019945620099.v45);
create or replace view aggJoin5600135280616690883 as (
with aggView5383339751133256078 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45, v7, v59 from aggJoin8914582945475180379 join aggView5383339751133256078 using(v5));
create or replace view aggJoin7098597164212533068 as (
with aggView1748843142285488327 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin4723590060882771052 join aggView1748843142285488327 using(v16));
create or replace view aggJoin7525622457486019292 as (
with aggView843823920676303169 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView843823920676303169 where mi_idx.info_type_id=aggView843823920676303169.v20 and info<'8.5');
create or replace view aggJoin7394240947677050336 as (
with aggView5991459007138525246 as (select v45, MIN(v40) as v58 from aggJoin7525622457486019292 group by v45)
select v45, v7, v59 as v59, v58 from aggJoin5600135280616690883 join aggView5991459007138525246 using(v45));
create or replace view aggJoin5481421482945653781 as (
with aggView625616177420495552 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45, v59, v58 from aggJoin7394240947677050336 join aggView625616177420495552 using(v7));
create or replace view aggJoin7984432499140803534 as (
with aggView7497432383924882705 as (select v45, MIN(v57) as v57 from aggJoin7098597164212533068 group by v45,v57)
select movie_id as v45, info_type_id as v18, info as v35, v57 from movie_info as mi, aggView7497432383924882705 where mi.movie_id=aggView7497432383924882705.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1005590471205894152 as (
with aggView3900165578839041553 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView3900165578839041553 where mk.keyword_id=aggView3900165578839041553.v22);
create or replace view aggJoin5337728180475171865 as (
with aggView6894110803510751003 as (select v45, MIN(v59) as v59, MIN(v58) as v58 from aggJoin5481421482945653781 group by v45,v58,v59)
select v45, v59, v58 from aggJoin1005590471205894152 join aggView6894110803510751003 using(v45));
create or replace view aggJoin1486323894503930131 as (
with aggView3836393468877784408 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35, v57 from aggJoin7984432499140803534 join aggView3836393468877784408 using(v18));
create or replace view aggJoin3123173237745245176 as (
with aggView6367995794903619829 as (select v45, MIN(v57) as v57 from aggJoin1486323894503930131 group by v45,v57)
select v59 as v59, v58 as v58, v57 from aggJoin5337728180475171865 join aggView6367995794903619829 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin3123173237745245176;
