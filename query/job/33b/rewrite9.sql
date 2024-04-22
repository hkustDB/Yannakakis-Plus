create or replace view aggJoin3882925358859585117 as (
with aggView1934696391551789077 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[nl]')
select movie_id as v49, v73 from movie_companies as mc1, aggView1934696391551789077 where mc1.company_id=aggView1934696391551789077.v1);
create or replace view aggJoin750520880481239265 as (
with aggView8001128138579750389 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView8001128138579750389 where mc2.company_id=aggView8001128138579750389.v8);
create or replace view aggJoin4350212251380717135 as (
with aggView4421784942178336429 as (select v49, MIN(v73) as v73 from aggJoin3882925358859585117 group by v49,v73)
select id as v49, title as v50, kind_id as v19, v73 from title as t1, aggView4421784942178336429 where t1.id=aggView4421784942178336429.v49);
create or replace view aggJoin1700350192705905655 as (
with aggView672949854129678571 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView672949854129678571 where mi_idx1.info_type_id=aggView672949854129678571.v15);
create or replace view aggJoin9197023374269591054 as (
with aggView9217885400244697772 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView9217885400244697772 where ml.link_type_id=aggView9217885400244697772.v23);
create or replace view aggJoin8233299345503652541 as (
with aggView2362676992709524080 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView2362676992709524080 where mi_idx2.info_type_id=aggView2362676992709524080.v17 and info<'3.0');
create or replace view aggJoin3730351085873801113 as (
with aggView4747178614545241740 as (select v61, MIN(v43) as v76 from aggJoin8233299345503652541 group by v61)
select id as v61, title as v62, kind_id as v21, production_year as v65, v76 from title as t2, aggView4747178614545241740 where t2.id=aggView4747178614545241740.v61 and production_year= 2007);
create or replace view aggJoin1788189529460744440 as (
with aggView4998090762674079502 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select v49, v50, v73 from aggJoin4350212251380717135 join aggView4998090762674079502 using(v19));
create or replace view aggJoin5210973667510110157 as (
with aggView7344018667278338775 as (select v49, MIN(v73) as v73, MIN(v50) as v77 from aggJoin1788189529460744440 group by v49,v73)
select v49, v38, v73, v77 from aggJoin1700350192705905655 join aggView7344018667278338775 using(v49));
create or replace view aggJoin8541862114784500027 as (
with aggView601871932837751536 as (select v49, MIN(v73) as v73, MIN(v77) as v77, MIN(v38) as v75 from aggJoin5210973667510110157 group by v49,v73,v77)
select v61, v73, v77, v75 from aggJoin9197023374269591054 join aggView601871932837751536 using(v49));
create or replace view aggJoin6253379307165404753 as (
with aggView7036423226386222545 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select v61, v62, v65, v76 from aggJoin3730351085873801113 join aggView7036423226386222545 using(v21));
create or replace view aggJoin6742723001092381584 as (
with aggView5631572860504773754 as (select v61, MIN(v76) as v76, MIN(v62) as v78 from aggJoin6253379307165404753 group by v61,v76)
select v61, v73 as v73, v77 as v77, v75 as v75, v76, v78 from aggJoin8541862114784500027 join aggView5631572860504773754 using(v61));
create or replace view aggJoin4033940515326120132 as (
with aggView8442637281855976986 as (select v61, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75, MIN(v76) as v76, MIN(v78) as v78 from aggJoin6742723001092381584 group by v61,v78,v75,v76,v73,v77)
select v74 as v74, v73, v77, v75, v76, v78 from aggJoin750520880481239265 join aggView8442637281855976986 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin4033940515326120132;
