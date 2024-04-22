create or replace view aggJoin6097310700702882123 as (
with aggView4945992804236664522 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView4945992804236664522 where mi.info_type_id=aggView4945992804236664522.v21);
create or replace view aggJoin4712746251272632858 as (
with aggView8576233465640042582 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView8576233465640042582 where mc.company_id=aggView8576233465640042582.v1);
create or replace view aggJoin8848984335295514457 as (
with aggView5623228143975576947 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select movie_id as v29 from movie_info_idx as mi_idx, aggView5623228143975576947 where mi_idx.info_type_id=aggView5623228143975576947.v26);
create or replace view aggJoin7235933038781298467 as (
with aggView8330835550461589985 as (select v29 from aggJoin8848984335295514457 group by v29)
select v29, v8 from aggJoin4712746251272632858 join aggView8330835550461589985 using(v29));
create or replace view aggJoin3458697994793855532 as (
with aggView4907026173285802402 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin7235933038781298467 join aggView4907026173285802402 using(v8));
create or replace view aggJoin3413239262522435467 as (
with aggView6707800979487363092 as (select v29 from aggJoin3458697994793855532 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView6707800979487363092 where t.id=aggView6707800979487363092.v29 and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')));
create or replace view aggJoin5705324208152140345 as (
with aggView7366816045764652491 as (select v29, MIN(v30) as v42 from aggJoin3413239262522435467 group by v29)
select v22, v42 from aggJoin6097310700702882123 join aggView7366816045764652491 using(v29));
select MIN(v22) as v41,MIN(v42) as v42 from aggJoin5705324208152140345;
