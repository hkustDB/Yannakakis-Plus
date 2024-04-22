create or replace view aggJoin3909734168055288642 as (
with aggView5176515133545714890 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView5176515133545714890 where mi_idx.info_type_id=aggView5176515133545714890.v3 and info<'8.5');
create or replace view aggJoin1182260901250361483 as (
with aggView5882893439651722034 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView5882893439651722034 where mi.info_type_id=aggView5882893439651722034.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin1628840780168490534 as (
with aggView781435696018139705 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView781435696018139705 where mk.keyword_id=aggView781435696018139705.v5);
create or replace view aggJoin276855628461375211 as (
with aggView7874923784075281912 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView7874923784075281912 where t.kind_id=aggView7874923784075281912.v8 and production_year>2010);
create or replace view aggJoin8804894408385431345 as (
with aggView5106001199462237200 as (select v23, MIN(v24) as v36 from aggJoin276855628461375211 group by v23)
select v23, v13, v36 from aggJoin1182260901250361483 join aggView5106001199462237200 using(v23));
create or replace view aggJoin3241514509949210078 as (
with aggView8701813155223922254 as (select v23, MIN(v36) as v36 from aggJoin8804894408385431345 group by v23,v36)
select v23, v18, v36 from aggJoin3909734168055288642 join aggView8701813155223922254 using(v23));
create or replace view aggJoin2049226996500015647 as (
with aggView7387083557256302839 as (select v23, MIN(v36) as v36, MIN(v18) as v35 from aggJoin3241514509949210078 group by v23,v36)
select v36, v35 from aggJoin1628840780168490534 join aggView7387083557256302839 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin2049226996500015647;
