create or replace view aggJoin6852823970682917017 as (
with aggView4234868870879267483 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView4234868870879267483 where t.kind_id=aggView4234868870879267483.v8 and production_year>2005);
create or replace view aggJoin2016196789578152162 as (
with aggView428222073574098826 as (select v23, MIN(v24) as v36 from aggJoin6852823970682917017 group by v23)
select movie_id as v23, info_type_id as v3, info as v18, v36 from movie_info_idx as mi_idx, aggView428222073574098826 where mi_idx.movie_id=aggView428222073574098826.v23 and info<'8.5');
create or replace view aggJoin4417807802205330297 as (
with aggView6560866893582952248 as (select id as v3 from info_type as it2 where info= 'rating')
select v23, v18, v36 from aggJoin2016196789578152162 join aggView6560866893582952248 using(v3));
create or replace view aggJoin4464182350467026474 as (
with aggView264050449808934190 as (select v23, MIN(v36) as v36, MIN(v18) as v35 from aggJoin4417807802205330297 group by v23,v36)
select movie_id as v23, keyword_id as v5, v36, v35 from movie_keyword as mk, aggView264050449808934190 where mk.movie_id=aggView264050449808934190.v23);
create or replace view aggJoin9010729657259880721 as (
with aggView4375795068335336995 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v23, v36, v35 from aggJoin4464182350467026474 join aggView4375795068335336995 using(v5));
create or replace view aggJoin3511165489644272701 as (
with aggView3308749821307580287 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView3308749821307580287 where mi.info_type_id=aggView3308749821307580287.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8442123471050731422 as (
with aggView8563812209443140335 as (select v23 from aggJoin3511165489644272701 group by v23)
select v36 as v36, v35 as v35 from aggJoin9010729657259880721 join aggView8563812209443140335 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin8442123471050731422;
