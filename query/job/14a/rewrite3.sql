create or replace view aggJoin8352603672831795274 as (
with aggView7129350242003519125 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView7129350242003519125 where mk.keyword_id=aggView7129350242003519125.v5);
create or replace view aggJoin4682999012390457749 as (
with aggView4871447771948142973 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView4871447771948142973 where mi.info_type_id=aggView4871447771948142973.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin6364896383495256424 as (
with aggView8702172420689318734 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView8702172420689318734 where mi_idx.info_type_id=aggView8702172420689318734.v3);
create or replace view aggJoin4887803944115797758 as (
with aggView5444605612075562493 as (select v23, v18 from aggJoin6364896383495256424 group by v23,v18)
select v23, v18 from aggView5444605612075562493 where v18<'8.5');
create or replace view aggJoin581061625718422909 as (
with aggView8546492037595967368 as (select v23 from aggJoin4682999012390457749 group by v23)
select v23 from aggJoin8352603672831795274 join aggView8546492037595967368 using(v23));
create or replace view aggJoin655245051116831671 as (
with aggView2116627273676151865 as (select v23 from aggJoin581061625718422909 group by v23)
select id as v23, title as v24, kind_id as v8, production_year as v27 from title as t, aggView2116627273676151865 where t.id=aggView2116627273676151865.v23 and production_year>2010);
create or replace view aggJoin211583079205619103 as (
with aggView5689733921040305196 as (select id as v8 from kind_type as kt where kind= 'movie')
select v23, v24, v27 from aggJoin655245051116831671 join aggView5689733921040305196 using(v8));
create or replace view aggView2221192639378176976 as select v23, v24 from aggJoin211583079205619103 group by v23,v24;
create or replace view aggJoin4723404332689978036 as (
with aggView5496976419244939148 as (select v23, MIN(v24) as v36 from aggView2221192639378176976 group by v23)
select v18, v36 from aggJoin4887803944115797758 join aggView5496976419244939148 using(v23));
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin4723404332689978036;
