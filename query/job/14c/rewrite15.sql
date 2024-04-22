create or replace view aggJoin5364656631066088222 as (
with aggView2134843330136964473 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView2134843330136964473 where t.kind_id=aggView2134843330136964473.v8 and production_year>2005);
create or replace view aggJoin8250145662558570292 as (
with aggView261160438569774168 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView261160438569774168 where mi_idx.info_type_id=aggView261160438569774168.v3 and info<'8.5');
create or replace view aggJoin406131691940658083 as (
with aggView6232297494376700354 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView6232297494376700354 where mk.keyword_id=aggView6232297494376700354.v5);
create or replace view aggJoin1428114176643539918 as (
with aggView6806364646057371046 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView6806364646057371046 where mi.info_type_id=aggView6806364646057371046.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin5957832030611997974 as (
with aggView5269364175309455878 as (select v23 from aggJoin1428114176643539918 group by v23)
select v23, v24, v27 from aggJoin5364656631066088222 join aggView5269364175309455878 using(v23));
create or replace view aggJoin7327727327596880501 as (
with aggView1690900828360784396 as (select v23, MIN(v24) as v36 from aggJoin5957832030611997974 group by v23)
select v23, v18, v36 from aggJoin8250145662558570292 join aggView1690900828360784396 using(v23));
create or replace view aggJoin7318130778674150834 as (
with aggView7766922055643529101 as (select v23, MIN(v36) as v36, MIN(v18) as v35 from aggJoin7327727327596880501 group by v23,v36)
select v36, v35 from aggJoin406131691940658083 join aggView7766922055643529101 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin7318130778674150834;
