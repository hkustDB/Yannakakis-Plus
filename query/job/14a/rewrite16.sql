create or replace view aggJoin3434174615282460216 as (
with aggView8814410390595650644 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView8814410390595650644 where mi_idx.info_type_id=aggView8814410390595650644.v3 and info<'8.5');
create or replace view aggJoin7800804790807706551 as (
with aggView2265188056154883999 as (select v23, MIN(v18) as v35 from aggJoin3434174615282460216 group by v23)
select movie_id as v23, keyword_id as v5, v35 from movie_keyword as mk, aggView2265188056154883999 where mk.movie_id=aggView2265188056154883999.v23);
create or replace view aggJoin8657218014684737371 as (
with aggView4424077745358800151 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v23, v35 from aggJoin7800804790807706551 join aggView4424077745358800151 using(v5));
create or replace view aggJoin7577608208807832019 as (
with aggView4599646076941003078 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView4599646076941003078 where mi.info_type_id=aggView4599646076941003078.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin6672165089181038085 as (
with aggView486138228904558276 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView486138228904558276 where t.kind_id=aggView486138228904558276.v8 and production_year>2010);
create or replace view aggJoin7977797474663097365 as (
with aggView1142782610402700699 as (select v23 from aggJoin7577608208807832019 group by v23)
select v23, v24, v27 from aggJoin6672165089181038085 join aggView1142782610402700699 using(v23));
create or replace view aggJoin6512680865427179416 as (
with aggView3705187733890007447 as (select v23, MIN(v24) as v36 from aggJoin7977797474663097365 group by v23)
select v35 as v35, v36 from aggJoin8657218014684737371 join aggView3705187733890007447 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin6512680865427179416;
