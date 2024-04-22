create or replace view aggJoin747014256000422154 as (
with aggView1304030906928691438 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView1304030906928691438 where mi_idx.info_type_id=aggView1304030906928691438.v3 and info<'8.5');
create or replace view aggJoin5131537878562904290 as (
with aggView4526207259581294413 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView4526207259581294413 where mi.info_type_id=aggView4526207259581294413.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin948706493343380292 as (
with aggView6168069727829465116 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView6168069727829465116 where mk.keyword_id=aggView6168069727829465116.v5);
create or replace view aggJoin4992257402571326038 as (
with aggView9084389258170153664 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView9084389258170153664 where t.kind_id=aggView9084389258170153664.v8 and production_year>2010);
create or replace view aggJoin6177681518516491221 as (
with aggView3202460424009925327 as (select v23, MIN(v24) as v36 from aggJoin4992257402571326038 group by v23)
select v23, v18, v36 from aggJoin747014256000422154 join aggView3202460424009925327 using(v23));
create or replace view aggJoin775077252205015717 as (
with aggView7645959127955510788 as (select v23, MIN(v36) as v36, MIN(v18) as v35 from aggJoin6177681518516491221 group by v23,v36)
select v23, v13, v36, v35 from aggJoin5131537878562904290 join aggView7645959127955510788 using(v23));
create or replace view aggJoin4649293805380154936 as (
with aggView4539977654378328039 as (select v23, MIN(v36) as v36, MIN(v35) as v35 from aggJoin775077252205015717 group by v23,v36,v35)
select v36, v35 from aggJoin948706493343380292 join aggView4539977654378328039 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin4649293805380154936;
