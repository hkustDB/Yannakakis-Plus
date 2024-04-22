create or replace view aggView7797957798859889415 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin1566793235740597394 as (
with aggView8522457725338265589 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView8522457725338265589 where t.kind_id=aggView8522457725338265589.v17 and production_year>2005);
create or replace view aggJoin1851332978815757300 as (
with aggView5820450909908410488 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView5820450909908410488 where mi_idx.info_type_id=aggView5820450909908410488.v12 and info<'8.5');
create or replace view aggView2292770150568247004 as select v37, v32 from aggJoin1851332978815757300 group by v37,v32;
create or replace view aggJoin8571842940319593249 as (
with aggView6397659389617340410 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView6397659389617340410 where mi.info_type_id=aggView6397659389617340410.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8936289591858490967 as (
with aggView8931542835906231573 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView8931542835906231573 where mk.keyword_id=aggView8931542835906231573.v14);
create or replace view aggJoin9198512670537692374 as (
with aggView7991177478957517843 as (select v37 from aggJoin8936289591858490967 group by v37)
select v37, v27 from aggJoin8571842940319593249 join aggView7991177478957517843 using(v37));
create or replace view aggJoin1623639468246304717 as (
with aggView2990564396994069454 as (select v37 from aggJoin9198512670537692374 group by v37)
select v37, v38, v41 from aggJoin1566793235740597394 join aggView2990564396994069454 using(v37));
create or replace view aggView426671297360158187 as select v38, v37 from aggJoin1623639468246304717 group by v38,v37;
create or replace view aggJoin3302825531256555975 as (
with aggView6327758165947503068 as (select v37, MIN(v38) as v51 from aggView426671297360158187 group by v37)
select movie_id as v37, company_id as v1, company_type_id as v8, note as v23, v51 from movie_companies as mc, aggView6327758165947503068 where mc.movie_id=aggView6327758165947503068.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin761674911694199638 as (
with aggView4809408724453940729 as (select v1, MIN(v2) as v49 from aggView7797957798859889415 group by v1)
select v37, v8, v23, v51 as v51, v49 from aggJoin3302825531256555975 join aggView4809408724453940729 using(v1));
create or replace view aggJoin6415708538506404467 as (
with aggView1862936428619834482 as (select id as v8 from company_type as ct)
select v37, v23, v51, v49 from aggJoin761674911694199638 join aggView1862936428619834482 using(v8));
create or replace view aggJoin8446423025052688304 as (
with aggView3320903384805880775 as (select v37, MIN(v51) as v51, MIN(v49) as v49 from aggJoin6415708538506404467 group by v37,v49,v51)
select v32, v51, v49 from aggView2292770150568247004 join aggView3320903384805880775 using(v37));
select MIN(v49) as v49,MIN(v32) as v50,MIN(v51) as v51 from aggJoin8446423025052688304;
