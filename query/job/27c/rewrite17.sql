create or replace view aggJoin3207978843660239306 as (
with aggView7848028205916016222 as (select id as v37, title as v54 from title as t where production_year>=1950 and production_year<=2010)
select movie_id as v37, link_type_id as v21, v54 from movie_link as ml, aggView7848028205916016222 where ml.movie_id=aggView7848028205916016222.v37);
create or replace view aggJoin4380061281402945179 as (
with aggView5853012739932471434 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select v37, v54, v53 from aggJoin3207978843660239306 join aggView5853012739932471434 using(v21));
create or replace view aggJoin125159425272761657 as (
with aggView7648148161257550420 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView7648148161257550420 where mc.company_id=aggView7648148161257550420.v25);
create or replace view aggJoin7855066005927516382 as (
with aggView1091599763511673195 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView1091599763511673195 where mk.keyword_id=aggView1091599763511673195.v35);
create or replace view aggJoin207930374903077355 as (
with aggView3288790651932383924 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView3288790651932383924 where cc.subject_id=aggView3288790651932383924.v5);
create or replace view aggJoin5190812169146770354 as (
with aggView124699715372229434 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin207930374903077355 join aggView124699715372229434 using(v7));
create or replace view aggJoin557092238909800091 as (
with aggView6948866124658238382 as (select v37 from aggJoin5190812169146770354 group by v37)
select v37, v54 as v54, v53 as v53 from aggJoin4380061281402945179 join aggView6948866124658238382 using(v37));
create or replace view aggJoin6707809014581956937 as (
with aggView8699552703593187288 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin125159425272761657 join aggView8699552703593187288 using(v26));
create or replace view aggJoin1660793535266472000 as (
with aggView2143698241363927532 as (select v37, MIN(v52) as v52 from aggJoin6707809014581956937 group by v37,v52)
select movie_id as v37, info as v31, v52 from movie_info as mi, aggView2143698241363927532 where mi.movie_id=aggView2143698241363927532.v37 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English'));
create or replace view aggJoin2040241498148921817 as (
with aggView3484420987908359247 as (select v37, MIN(v52) as v52 from aggJoin1660793535266472000 group by v37,v52)
select v37, v54 as v54, v53 as v53, v52 from aggJoin557092238909800091 join aggView3484420987908359247 using(v37));
create or replace view aggJoin7554281293349581366 as (
with aggView8059995452605626062 as (select v37, MIN(v54) as v54, MIN(v53) as v53, MIN(v52) as v52 from aggJoin2040241498148921817 group by v37,v54,v52,v53)
select v54, v53, v52 from aggJoin7855066005927516382 join aggView8059995452605626062 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin7554281293349581366;
