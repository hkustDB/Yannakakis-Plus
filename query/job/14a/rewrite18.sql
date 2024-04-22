create or replace view aggJoin8732177409788414975 as (
with aggView4881517734832146743 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView4881517734832146743 where mi_idx.info_type_id=aggView4881517734832146743.v3 and info<'8.5');
create or replace view aggJoin4134510503853601438 as (
with aggView3068448447928512173 as (select v23, MIN(v18) as v35 from aggJoin8732177409788414975 group by v23)
select movie_id as v23, keyword_id as v5, v35 from movie_keyword as mk, aggView3068448447928512173 where mk.movie_id=aggView3068448447928512173.v23);
create or replace view aggJoin2004658814246106816 as (
with aggView8715462568636857846 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v23, v35 from aggJoin4134510503853601438 join aggView8715462568636857846 using(v5));
create or replace view aggJoin1499800904180686800 as (
with aggView375175364107765549 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView375175364107765549 where mi.info_type_id=aggView375175364107765549.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin2450484592765594100 as (
with aggView7352915764391060902 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView7352915764391060902 where t.kind_id=aggView7352915764391060902.v8 and production_year>2010);
create or replace view aggJoin578930441538924117 as (
with aggView414754840019387939 as (select v23, MIN(v24) as v36 from aggJoin2450484592765594100 group by v23)
select v23, v13, v36 from aggJoin1499800904180686800 join aggView414754840019387939 using(v23));
create or replace view aggJoin1821454031273943995 as (
with aggView2078397710234472633 as (select v23, MIN(v36) as v36 from aggJoin578930441538924117 group by v23,v36)
select v35 as v35, v36 from aggJoin2004658814246106816 join aggView2078397710234472633 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin1821454031273943995;
