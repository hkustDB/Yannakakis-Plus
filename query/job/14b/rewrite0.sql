create or replace view aggJoin8767151910453046241 as (
with aggView55412205856332537 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView55412205856332537 where t.kind_id=aggView55412205856332537.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggView3420269206402129958 as select v23, v24 from aggJoin8767151910453046241 group by v23,v24;
create or replace view aggJoin8220266108233176327 as (
with aggView3760529309566452242 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView3760529309566452242 where mi_idx.info_type_id=aggView3760529309566452242.v3);
create or replace view aggJoin5061761099582355649 as (
with aggView8074999264589874356 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView8074999264589874356 where mi.info_type_id=aggView8074999264589874356.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin2861848414562280779 as (
with aggView8928257749342925421 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select movie_id as v23 from movie_keyword as mk, aggView8928257749342925421 where mk.keyword_id=aggView8928257749342925421.v5);
create or replace view aggJoin401484742692396917 as (
with aggView7355346374159565747 as (select v23 from aggJoin5061761099582355649 group by v23)
select v23 from aggJoin2861848414562280779 join aggView7355346374159565747 using(v23));
create or replace view aggJoin5404892537368780083 as (
with aggView2123076565964902753 as (select v23 from aggJoin401484742692396917 group by v23)
select v23, v18 from aggJoin8220266108233176327 join aggView2123076565964902753 using(v23));
create or replace view aggJoin1085100915015972033 as (
with aggView5217488647932526774 as (select v23, v18 from aggJoin5404892537368780083 group by v23,v18)
select v23, v18 from aggView5217488647932526774 where v18>'6.0');
create or replace view aggJoin2504200138135618286 as (
with aggView2788564270638869864 as (select v23, MIN(v24) as v36 from aggView3420269206402129958 group by v23)
select v18, v36 from aggJoin1085100915015972033 join aggView2788564270638869864 using(v23));
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin2504200138135618286;
