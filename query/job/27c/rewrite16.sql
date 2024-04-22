create or replace view aggJoin7188900692071401463 as (
with aggView4661519454169214900 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView4661519454169214900 where ml.link_type_id=aggView4661519454169214900.v21);
create or replace view aggJoin7846165492113215416 as (
with aggView3257819540604413706 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView3257819540604413706 where mc.company_id=aggView3257819540604413706.v25);
create or replace view aggJoin6680930665406341780 as (
with aggView5313566720684946971 as (select id as v37, title as v54 from title as t where production_year>=1950 and production_year<=2010)
select movie_id as v37, keyword_id as v35, v54 from movie_keyword as mk, aggView5313566720684946971 where mk.movie_id=aggView5313566720684946971.v37);
create or replace view aggJoin5359628709352913352 as (
with aggView6203862053790367699 as (select id as v35 from keyword as k where keyword= 'sequel')
select v37, v54 from aggJoin6680930665406341780 join aggView6203862053790367699 using(v35));
create or replace view aggJoin8389243250959459940 as (
with aggView352291466726092926 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView352291466726092926 where cc.subject_id=aggView352291466726092926.v5);
create or replace view aggJoin7621888854877845883 as (
with aggView5398466879598563425 as (select v37, MIN(v53) as v53 from aggJoin7188900692071401463 group by v37,v53)
select v37, v26, v52 as v52, v53 from aggJoin7846165492113215416 join aggView5398466879598563425 using(v37));
create or replace view aggJoin6417251801389700508 as (
with aggView4758789840963185009 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin8389243250959459940 join aggView4758789840963185009 using(v7));
create or replace view aggJoin5966713748112150814 as (
with aggView5275013475965058700 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v37 from aggJoin6417251801389700508 join aggView5275013475965058700 using(v37));
create or replace view aggJoin6911437020658442964 as (
with aggView3125266028582715969 as (select v37 from aggJoin5966713748112150814 group by v37)
select v37, v54 as v54 from aggJoin5359628709352913352 join aggView3125266028582715969 using(v37));
create or replace view aggJoin5650108257002048303 as (
with aggView6449284220719613131 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52, v53 from aggJoin7621888854877845883 join aggView6449284220719613131 using(v26));
create or replace view aggJoin862581686309273032 as (
with aggView8992088253615254836 as (select v37, MIN(v52) as v52, MIN(v53) as v53 from aggJoin5650108257002048303 group by v37,v52,v53)
select v54 as v54, v52, v53 from aggJoin6911437020658442964 join aggView8992088253615254836 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin862581686309273032;
