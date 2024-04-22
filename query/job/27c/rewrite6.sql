create or replace view aggJoin6057444633760530232 as (
with aggView1305136619973342651 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView1305136619973342651 where ml.link_type_id=aggView1305136619973342651.v21);
create or replace view aggJoin5917310012379736550 as (
with aggView1032486922800741232 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView1032486922800741232 where mc.company_id=aggView1032486922800741232.v25);
create or replace view aggJoin7033021321540432692 as (
with aggView7408568631949661033 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView7408568631949661033 where mk.keyword_id=aggView7408568631949661033.v35);
create or replace view aggJoin7038466221169462195 as (
with aggView5653584625903411473 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView5653584625903411473 where cc.subject_id=aggView5653584625903411473.v5);
create or replace view aggJoin7085550816507285865 as (
with aggView270944926517049333 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin7038466221169462195 join aggView270944926517049333 using(v7));
create or replace view aggJoin2656482069601656462 as (
with aggView1554130868941921840 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v37 from aggJoin7085550816507285865 join aggView1554130868941921840 using(v37));
create or replace view aggJoin357524692691562523 as (
with aggView5841008560051766925 as (select v37 from aggJoin2656482069601656462 group by v37)
select v37, v53 as v53 from aggJoin6057444633760530232 join aggView5841008560051766925 using(v37));
create or replace view aggJoin4523364696791071962 as (
with aggView8837251414007959638 as (select v37, MIN(v53) as v53 from aggJoin357524692691562523 group by v37,v53)
select v37, v53 from aggJoin7033021321540432692 join aggView8837251414007959638 using(v37));
create or replace view aggJoin8962937898782753517 as (
with aggView4076119138015027869 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin5917310012379736550 join aggView4076119138015027869 using(v26));
create or replace view aggJoin4863504606568142054 as (
with aggView5445515945728460134 as (select v37, MIN(v52) as v52 from aggJoin8962937898782753517 group by v37,v52)
select id as v37, title as v41, production_year as v44, v52 from title as t, aggView5445515945728460134 where t.id=aggView5445515945728460134.v37 and production_year>=1950 and production_year<=2010);
create or replace view aggJoin7812859548466960878 as (
with aggView6027429957465406958 as (select v37, MIN(v52) as v52, MIN(v41) as v54 from aggJoin4863504606568142054 group by v37,v52)
select v53 as v53, v52, v54 from aggJoin4523364696791071962 join aggView6027429957465406958 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin7812859548466960878;
