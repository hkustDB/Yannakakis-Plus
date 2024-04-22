create or replace view aggJoin5138078538810233756 as (
with aggView5116041140198609920 as (select id as v14, title as v27 from title as t where production_year>2010)
select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView5116041140198609920 where mi_idx.movie_id=aggView5116041140198609920.v14 and info>'9.0');
create or replace view aggJoin3146658966394670499 as (
with aggView8977528019683073658 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView8977528019683073658 where mk.keyword_id=aggView8977528019683073658.v3);
create or replace view aggJoin5150554792175376609 as (
with aggView3028815393560886420 as (select id as v1 from info_type as it where info= 'rating')
select v14, v9, v27 from aggJoin5138078538810233756 join aggView3028815393560886420 using(v1));
create or replace view aggJoin2832336336626876217 as (
with aggView7971615188110094396 as (select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin5150554792175376609 group by v14,v27)
select v27, v26 from aggJoin3146658966394670499 join aggView7971615188110094396 using(v14));
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2832336336626876217;
