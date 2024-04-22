create or replace view aggJoin2463869065677833944 as (
with aggView4773461593159641074 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView4773461593159641074 where ml.link_type_id=aggView4773461593159641074.v21);
create or replace view aggJoin1134877275934302230 as (
with aggView3739165593260385212 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView3739165593260385212 where mc.company_id=aggView3739165593260385212.v25);
create or replace view aggJoin4418395840039920912 as (
with aggView1005221309062777440 as (select v37, MIN(v53) as v53 from aggJoin2463869065677833944 group by v37,v53)
select id as v37, title as v41, production_year as v44, v53 from title as t, aggView1005221309062777440 where t.id=aggView1005221309062777440.v37 and production_year>=1950 and production_year<=2010);
create or replace view aggJoin4732728983622043732 as (
with aggView3741406884708225852 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView3741406884708225852 where mk.keyword_id=aggView3741406884708225852.v35);
create or replace view aggJoin8875602855261387788 as (
with aggView8956047675590584726 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView8956047675590584726 where cc.subject_id=aggView8956047675590584726.v5);
create or replace view aggJoin247160659474746113 as (
with aggView843368048277729749 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin8875602855261387788 join aggView843368048277729749 using(v7));
create or replace view aggJoin1196815507072998414 as (
with aggView4105022749383256460 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v37 from aggJoin247160659474746113 join aggView4105022749383256460 using(v37));
create or replace view aggJoin1409066485896688780 as (
with aggView2780895447718886464 as (select v37 from aggJoin1196815507072998414 group by v37)
select v37 from aggJoin4732728983622043732 join aggView2780895447718886464 using(v37));
create or replace view aggJoin3810014165222319553 as (
with aggView2723634444903772716 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin1134877275934302230 join aggView2723634444903772716 using(v26));
create or replace view aggJoin2138274077696320181 as (
with aggView6898472382123967416 as (select v37, MIN(v52) as v52 from aggJoin3810014165222319553 group by v37,v52)
select v37, v41, v44, v53 as v53, v52 from aggJoin4418395840039920912 join aggView6898472382123967416 using(v37));
create or replace view aggJoin9088461591946689376 as (
with aggView7287428739035953198 as (select v37, MIN(v53) as v53, MIN(v52) as v52, MIN(v41) as v54 from aggJoin2138274077696320181 group by v37,v52,v53)
select v53, v52, v54 from aggJoin1409066485896688780 join aggView7287428739035953198 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin9088461591946689376;
