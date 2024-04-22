create or replace view aggJoin1684998133569620351 as (
with aggView3245497691827887679 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView3245497691827887679 where mc.company_id=aggView3245497691827887679.v17);
create or replace view aggJoin5214159995738585095 as (
with aggView271839507389310523 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select movie_id as v24, v40 from movie_link as ml, aggView271839507389310523 where ml.link_type_id=aggView271839507389310523.v13);
create or replace view aggJoin83060866697809492 as (
with aggView7658015533074811324 as (select v24, MIN(v40) as v40 from aggJoin5214159995738585095 group by v24,v40)
select movie_id as v24, keyword_id as v22, v40 from movie_keyword as mk, aggView7658015533074811324 where mk.movie_id=aggView7658015533074811324.v24);
create or replace view aggJoin6982895169825488711 as (
with aggView549037909564947646 as (select id as v22 from keyword as k where keyword= 'sequel')
select v24, v40 from aggJoin83060866697809492 join aggView549037909564947646 using(v22));
create or replace view aggJoin8838098017770457639 as (
with aggView382519894479313799 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin1684998133569620351 join aggView382519894479313799 using(v18));
create or replace view aggJoin7806726949191292332 as (
with aggView2612409764789082597 as (select v24, MIN(v39) as v39 from aggJoin8838098017770457639 group by v24,v39)
select id as v24, title as v28, production_year as v31, v39 from title as t, aggView2612409764789082597 where t.id=aggView2612409764789082597.v24 and title LIKE '%Money%' and production_year= 1998);
create or replace view aggJoin8710760262373616073 as (
with aggView8259147613116511647 as (select v24, MIN(v39) as v39, MIN(v28) as v41 from aggJoin7806726949191292332 group by v24,v39)
select v40 as v40, v39, v41 from aggJoin6982895169825488711 join aggView8259147613116511647 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin8710760262373616073;
