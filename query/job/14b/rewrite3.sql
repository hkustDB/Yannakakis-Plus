create or replace view aggJoin4932816648774662253 as (
with aggView2598224008397262829 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView2598224008397262829 where t.kind_id=aggView2598224008397262829.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin7741251426270218114 as (
with aggView7287502143258156613 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView7287502143258156613 where mi_idx.info_type_id=aggView7287502143258156613.v3);
create or replace view aggJoin52322041948304649 as (
with aggView6116020952266144166 as (select v23, v18 from aggJoin7741251426270218114 group by v23,v18)
select v23, v18 from aggView6116020952266144166 where v18>'6.0');
create or replace view aggJoin5708560957559940252 as (
with aggView1141271072474051860 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select movie_id as v23 from movie_keyword as mk, aggView1141271072474051860 where mk.keyword_id=aggView1141271072474051860.v5);
create or replace view aggJoin1917854751705319299 as (
with aggView6880488463454188492 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView6880488463454188492 where mi.info_type_id=aggView6880488463454188492.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin2642972973892884036 as (
with aggView7447468739128124527 as (select v23 from aggJoin5708560957559940252 group by v23)
select v23, v13 from aggJoin1917854751705319299 join aggView7447468739128124527 using(v23));
create or replace view aggJoin8674901282639940498 as (
with aggView7435058438014620814 as (select v23 from aggJoin2642972973892884036 group by v23)
select v23, v24, v27 from aggJoin4932816648774662253 join aggView7435058438014620814 using(v23));
create or replace view aggView2066108315184530005 as select v23, v24 from aggJoin8674901282639940498 group by v23,v24;
create or replace view aggJoin5151673150962929056 as (
with aggView8371660832921795902 as (select v23, MIN(v18) as v35 from aggJoin52322041948304649 group by v23)
select v24, v35 from aggView2066108315184530005 join aggView8371660832921795902 using(v23));
select MIN(v35) as v35,MIN(v24) as v36 from aggJoin5151673150962929056;
