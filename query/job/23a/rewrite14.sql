create or replace view aggJoin6193508590317609996 as (
with aggView1322581913638372208 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView1322581913638372208 where t.kind_id=aggView1322581913638372208.v21 and production_year>2000);
create or replace view aggJoin2062998004045841122 as (
with aggView1695529413190199086 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView1695529413190199086 where mc.company_type_id=aggView1695529413190199086.v14);
create or replace view aggJoin3887822900138635278 as (
with aggView4975910757838946786 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView4975910757838946786 where mk.keyword_id=aggView4975910757838946786.v18);
create or replace view aggJoin104520225356779817 as (
with aggView2742825605149063013 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView2742825605149063013 where mi.info_type_id=aggView2742825605149063013.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin110250445604847186 as (
with aggView6490256319378018257 as (select v36 from aggJoin104520225356779817 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin6193508590317609996 join aggView6490256319378018257 using(v36));
create or replace view aggJoin6270149524752721224 as (
with aggView518024936050549284 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView518024936050549284 where cc.status_id=aggView518024936050549284.v5);
create or replace view aggJoin1934671935747739882 as (
with aggView873634781379919735 as (select v36 from aggJoin6270149524752721224 group by v36)
select v36 from aggJoin3887822900138635278 join aggView873634781379919735 using(v36));
create or replace view aggJoin7408183211865768458 as (
with aggView299147499110352933 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin2062998004045841122 join aggView299147499110352933 using(v7));
create or replace view aggJoin4602082160737778554 as (
with aggView5312686679015905216 as (select v36 from aggJoin7408183211865768458 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin110250445604847186 join aggView5312686679015905216 using(v36));
create or replace view aggJoin2393170604281808490 as (
with aggView3037605971429799819 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin4602082160737778554 group by v36,v48)
select v48, v49 from aggJoin1934671935747739882 join aggView3037605971429799819 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin2393170604281808490;
