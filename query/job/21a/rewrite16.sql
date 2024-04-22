create or replace view aggView2502599835414461781 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggView8108441419809650211 as select id as v29, title as v33 from title as t where production_year<=2000 and production_year>=1950;
create or replace view aggJoin3896504390227946399 as (
with aggView1344391657701681253 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView1344391657701681253 where ml.link_type_id=aggView1344391657701681253.v13);
create or replace view aggJoin1557809339958194998 as (
with aggView6445547442024922466 as (select v17, MIN(v2) as v44 from aggView2502599835414461781 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView6445547442024922466 where mc.company_id=aggView6445547442024922466.v17);
create or replace view aggJoin5893982856489628372 as (
with aggView7011167698287920526 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView7011167698287920526 where mk.keyword_id=aggView7011167698287920526.v27);
create or replace view aggJoin1690960074724787780 as (
with aggView3812337748090823398 as (select v29 from aggJoin5893982856489628372 group by v29)
select v29, v45 as v45 from aggJoin3896504390227946399 join aggView3812337748090823398 using(v29));
create or replace view aggJoin1469187728726647692 as (
with aggView6057118202145311156 as (select v29, MIN(v45) as v45 from aggJoin1690960074724787780 group by v29,v45)
select v29, v18, v44 as v44, v45 from aggJoin1557809339958194998 join aggView6057118202145311156 using(v29));
create or replace view aggJoin3693575905587496138 as (
with aggView8139890146545282737 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select v29, v18, v44 as v44, v45 as v45 from aggJoin1469187728726647692 join aggView8139890146545282737 using(v29));
create or replace view aggJoin5598613884940042154 as (
with aggView3451021806702619103 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44, v45 from aggJoin3693575905587496138 join aggView3451021806702619103 using(v18));
create or replace view aggJoin2153736841099976234 as (
with aggView7308695451380108492 as (select v29, MIN(v44) as v44, MIN(v45) as v45 from aggJoin5598613884940042154 group by v29,v44,v45)
select v33, v44, v45 from aggView8108441419809650211 join aggView7308695451380108492 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v33) as v46 from aggJoin2153736841099976234;
