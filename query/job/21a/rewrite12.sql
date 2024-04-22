create or replace view aggJoin3938319468040287216 as (
with aggView122363852469607258 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView122363852469607258 where ml.link_type_id=aggView122363852469607258.v13);
create or replace view aggJoin501541377808311143 as (
with aggView3500348255644025535 as (select id as v29, title as v46 from title as t where production_year<=2000 and production_year>=1950)
select v29, v45, v46 from aggJoin3938319468040287216 join aggView3500348255644025535 using(v29));
create or replace view aggJoin9033549649772716677 as (
with aggView1810579777671121738 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView1810579777671121738 where mc.company_id=aggView1810579777671121738.v17);
create or replace view aggJoin4875299560639349510 as (
with aggView3631483766516019320 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView3631483766516019320 where mk.keyword_id=aggView3631483766516019320.v27);
create or replace view aggJoin1351278157695342003 as (
with aggView695068089064343780 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin9033549649772716677 join aggView695068089064343780 using(v18));
create or replace view aggJoin1482975720729422159 as (
with aggView711534920037703596 as (select v29, MIN(v44) as v44 from aggJoin1351278157695342003 group by v29,v44)
select v29, v45 as v45, v46 as v46, v44 from aggJoin501541377808311143 join aggView711534920037703596 using(v29));
create or replace view aggJoin2373975460551237516 as (
with aggView991824270342774246 as (select v29, MIN(v45) as v45, MIN(v46) as v46, MIN(v44) as v44 from aggJoin1482975720729422159 group by v29,v46,v44,v45)
select movie_id as v29, info as v23, v45, v46, v44 from movie_info as mi, aggView991824270342774246 where mi.movie_id=aggView991824270342774246.v29 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view aggJoin8528153612681964262 as (
with aggView3455386551461878008 as (select v29, MIN(v45) as v45, MIN(v46) as v46, MIN(v44) as v44 from aggJoin2373975460551237516 group by v29,v46,v44,v45)
select v45, v46, v44 from aggJoin4875299560639349510 join aggView3455386551461878008 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin8528153612681964262;
