create or replace view aggView477157550279170704 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin1848524675302234381 as (
with aggView4794886302862069685 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView4794886302862069685 where mi.info_type_id=aggView4794886302862069685.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin5757864939873592257 as (
with aggView3329596607952800051 as (select v29 from aggJoin1848524675302234381 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView3329596607952800051 where t.id=aggView3329596607952800051.v29 and production_year<=2008 and production_year>=2005);
create or replace view aggView4989334807665884250 as select v30, v29 from aggJoin5757864939873592257 group by v30,v29;
create or replace view aggJoin4266847255458792815 as (
with aggView2454459773918786129 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView2454459773918786129 where mi_idx.info_type_id=aggView2454459773918786129.v26);
create or replace view aggJoin1296935230426165524 as (
with aggView6061534185517050867 as (select v27, v29 from aggJoin4266847255458792815 group by v27,v29)
select v29, v27 from aggView6061534185517050867 where v27>'8.0');
create or replace view aggJoin2560087815652432181 as (
with aggView4891860354518832466 as (select v1, MIN(v2) as v41 from aggView477157550279170704 group by v1)
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView4891860354518832466 where mc.company_id=aggView4891860354518832466.v1);
create or replace view aggJoin4381585296189240576 as (
with aggView5868301747975000442 as (select v29, MIN(v27) as v42 from aggJoin1296935230426165524 group by v29)
select v30, v29, v42 from aggView4989334807665884250 join aggView5868301747975000442 using(v29));
create or replace view aggJoin3301736338963169692 as (
with aggView2913780606952485620 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin2560087815652432181 join aggView2913780606952485620 using(v8));
create or replace view aggJoin6865283589875066783 as (
with aggView6273031752885373670 as (select v29, MIN(v41) as v41 from aggJoin3301736338963169692 group by v29,v41)
select v30, v42 as v42, v41 from aggJoin4381585296189240576 join aggView6273031752885373670 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v30) as v43 from aggJoin6865283589875066783;
