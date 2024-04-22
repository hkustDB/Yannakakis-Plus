create or replace view aggJoin1460320490861809046 as (
with aggView4227996184506033479 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView4227996184506033479 where mc.company_type_id=aggView4227996184506033479.v14);
create or replace view aggJoin1319307004326426678 as (
with aggView8252539623996518416 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView8252539623996518416 where mk.keyword_id=aggView8252539623996518416.v18);
create or replace view aggJoin5960094777537780721 as (
with aggView3383341986615796563 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView3383341986615796563 where mi.info_type_id=aggView3383341986615796563.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin3465653084012215632 as (
with aggView956875639928901841 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView956875639928901841 where cc.status_id=aggView956875639928901841.v5);
create or replace view aggJoin3436158241698151824 as (
with aggView2851841149704884667 as (select v36 from aggJoin1319307004326426678 group by v36)
select v36, v31, v32 from aggJoin5960094777537780721 join aggView2851841149704884667 using(v36));
create or replace view aggJoin6568310810791093311 as (
with aggView4899277096706739210 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin1460320490861809046 join aggView4899277096706739210 using(v7));
create or replace view aggJoin7445618643994630510 as (
with aggView453752810797940408 as (select v36 from aggJoin6568310810791093311 group by v36)
select v36, v31, v32 from aggJoin3436158241698151824 join aggView453752810797940408 using(v36));
create or replace view aggJoin3828222563889451024 as (
with aggView2978258468235216439 as (select v36 from aggJoin7445618643994630510 group by v36)
select v36 from aggJoin3465653084012215632 join aggView2978258468235216439 using(v36));
create or replace view aggJoin7990160181885475966 as (
with aggView6241220874933930933 as (select v36 from aggJoin3828222563889451024 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView6241220874933930933 where t.id=aggView6241220874933930933.v36 and production_year>2000);
create or replace view aggView6294083381659155254 as select v21, v37 from aggJoin7990160181885475966 group by v21,v37;
create or replace view aggJoin2979262890134614747 as (
with aggView8222560023167313840 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select v37, v48 from aggView6294083381659155254 join aggView8222560023167313840 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin2979262890134614747;
