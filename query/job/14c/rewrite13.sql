create or replace view aggJoin6386755506857798796 as (
with aggView2971261113190776393 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView2971261113190776393 where mi_idx.info_type_id=aggView2971261113190776393.v3 and info<'8.5');
create or replace view aggJoin4263542464069768165 as (
with aggView6405810951155571255 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView6405810951155571255 where t.kind_id=aggView6405810951155571255.v8 and production_year>2005);
create or replace view aggJoin8985711322293179326 as (
with aggView3524900088729964895 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView3524900088729964895 where mk.keyword_id=aggView3524900088729964895.v5);
create or replace view aggJoin7432686491358327667 as (
with aggView7386405345794490595 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView7386405345794490595 where mi.info_type_id=aggView7386405345794490595.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin4846914671718931667 as (
with aggView3029452783967286864 as (select v23 from aggJoin7432686491358327667 group by v23)
select v23, v18 from aggJoin6386755506857798796 join aggView3029452783967286864 using(v23));
create or replace view aggJoin1434646391825986840 as (
with aggView6384781847941520515 as (select v23, MIN(v18) as v35 from aggJoin4846914671718931667 group by v23)
select v23, v24, v27, v35 from aggJoin4263542464069768165 join aggView6384781847941520515 using(v23));
create or replace view aggJoin355277634352345587 as (
with aggView6622843250905928218 as (select v23, MIN(v35) as v35, MIN(v24) as v36 from aggJoin1434646391825986840 group by v23,v35)
select v35, v36 from aggJoin8985711322293179326 join aggView6622843250905928218 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin355277634352345587;
