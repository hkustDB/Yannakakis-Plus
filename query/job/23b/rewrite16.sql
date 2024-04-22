create or replace view aggJoin2543484408347822190 as (
with aggView704187640502715306 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView704187640502715306 where mk.keyword_id=aggView704187640502715306.v18);
create or replace view aggJoin7722724676678854689 as (
with aggView7505557032265517615 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView7505557032265517615 where mc.company_type_id=aggView7505557032265517615.v14);
create or replace view aggJoin644758139751778811 as (
with aggView1513118494333146433 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView1513118494333146433 where mi.info_type_id=aggView1513118494333146433.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin5249673128901769306 as (
with aggView7190533555901451482 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView7190533555901451482 where cc.status_id=aggView7190533555901451482.v5);
create or replace view aggJoin8987140024431429873 as (
with aggView5087457119826859323 as (select v36 from aggJoin2543484408347822190 group by v36)
select v36 from aggJoin5249673128901769306 join aggView5087457119826859323 using(v36));
create or replace view aggJoin7179978625256579323 as (
with aggView9058001957359602783 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin7722724676678854689 join aggView9058001957359602783 using(v7));
create or replace view aggJoin3765406751996320142 as (
with aggView4768447877342598103 as (select v36 from aggJoin644758139751778811 group by v36)
select v36 from aggJoin7179978625256579323 join aggView4768447877342598103 using(v36));
create or replace view aggJoin2511210795792603080 as (
with aggView709781687863719124 as (select v36 from aggJoin8987140024431429873 group by v36)
select v36 from aggJoin3765406751996320142 join aggView709781687863719124 using(v36));
create or replace view aggJoin7164981586100234980 as (
with aggView8259807372595200601 as (select v36 from aggJoin2511210795792603080 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView8259807372595200601 where t.id=aggView8259807372595200601.v36 and production_year>2000);
create or replace view aggView3626480360702941119 as select v37, v21 from aggJoin7164981586100234980 group by v37,v21;
create or replace view aggJoin8088496144454241521 as (
with aggView6296442494638833680 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select v37, v48 from aggView3626480360702941119 join aggView6296442494638833680 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin8088496144454241521;
