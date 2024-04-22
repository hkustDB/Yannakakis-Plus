create or replace view aggJoin8925484696460778042 as (
with aggView3778016533093718259 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView3778016533093718259 where t.kind_id=aggView3778016533093718259.v8 and production_year>2005);
create or replace view aggJoin416928925838505874 as (
with aggView2813213434974330452 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView2813213434974330452 where mi_idx.info_type_id=aggView2813213434974330452.v3 and info<'8.5');
create or replace view aggJoin1011093453816150588 as (
with aggView6905592143632929438 as (select v23, MIN(v18) as v35 from aggJoin416928925838505874 group by v23)
select v23, v24, v27, v35 from aggJoin8925484696460778042 join aggView6905592143632929438 using(v23));
create or replace view aggJoin5223386308657144211 as (
with aggView6519259399517792517 as (select v23, MIN(v35) as v35, MIN(v24) as v36 from aggJoin1011093453816150588 group by v23,v35)
select movie_id as v23, info_type_id as v1, info as v13, v35, v36 from movie_info as mi, aggView6519259399517792517 where mi.movie_id=aggView6519259399517792517.v23 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin6352500002903672383 as (
with aggView3049142277786626278 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView3049142277786626278 where mk.keyword_id=aggView3049142277786626278.v5);
create or replace view aggJoin7852041812602872971 as (
with aggView4529042657968849474 as (select id as v1 from info_type as it1 where info= 'countries')
select v23, v13, v35, v36 from aggJoin5223386308657144211 join aggView4529042657968849474 using(v1));
create or replace view aggJoin1639211185366245545 as (
with aggView8352906184792606207 as (select v23, MIN(v35) as v35, MIN(v36) as v36 from aggJoin7852041812602872971 group by v23,v36,v35)
select v35, v36 from aggJoin6352500002903672383 join aggView8352906184792606207 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin1639211185366245545;
