create or replace view aggJoin1660005574509738672 as (
with aggView3793836132349343306 as (select id as v29, title as v43 from title as t where production_year>=2000 and production_year<=2010)
select movie_id as v29, info_type_id as v21, info as v22, v43 from movie_info as mi, aggView3793836132349343306 where mi.movie_id=aggView3793836132349343306.v29 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin129825113535341817 as (
with aggView2788964006192367321 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView2788964006192367321 where mc.company_id=aggView2788964006192367321.v1);
create or replace view aggJoin177435919859407840 as (
with aggView2659283577277109967 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin129825113535341817 join aggView2659283577277109967 using(v8));
create or replace view aggJoin912353352188234422 as (
with aggView7161003158679062364 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView7161003158679062364 where mi_idx.info_type_id=aggView7161003158679062364.v26 and info>'7.0');
create or replace view aggJoin454089349202942553 as (
with aggView6222658593596123790 as (select v29, MIN(v27) as v42 from aggJoin912353352188234422 group by v29)
select v29, v21, v22, v43 as v43, v42 from aggJoin1660005574509738672 join aggView6222658593596123790 using(v29));
create or replace view aggJoin292331477117193685 as (
with aggView4342737881077184400 as (select id as v21 from info_type as it1 where info= 'genres')
select v29, v22, v43, v42 from aggJoin454089349202942553 join aggView4342737881077184400 using(v21));
create or replace view aggJoin4433627804338702331 as (
with aggView7828276332940235779 as (select v29, MIN(v43) as v43, MIN(v42) as v42 from aggJoin292331477117193685 group by v29,v42,v43)
select v41 as v41, v43, v42 from aggJoin177435919859407840 join aggView7828276332940235779 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin4433627804338702331;
