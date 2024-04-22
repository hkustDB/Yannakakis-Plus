create or replace view aggJoin7450291381183599656 as (
with aggView3590207186108769418 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView3590207186108769418 where t.kind_id=aggView3590207186108769418.v21 and production_year>2000);
create or replace view aggJoin7240191468156604884 as (
with aggView8142483878953681967 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView8142483878953681967 where mc.company_type_id=aggView8142483878953681967.v14);
create or replace view aggJoin1140137970751830338 as (
with aggView8638565127327564852 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView8638565127327564852 where mk.keyword_id=aggView8638565127327564852.v18);
create or replace view aggJoin3217258548609827274 as (
with aggView5927486550741419741 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView5927486550741419741 where mi.info_type_id=aggView5927486550741419741.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin7496184484408582214 as (
with aggView7514712101853871077 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView7514712101853871077 where cc.status_id=aggView7514712101853871077.v5);
create or replace view aggJoin2641027381131315920 as (
with aggView4754245623129771881 as (select v36 from aggJoin7496184484408582214 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin7450291381183599656 join aggView4754245623129771881 using(v36));
create or replace view aggJoin9115258673445682563 as (
with aggView1226497791574270194 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin2641027381131315920 group by v36,v48)
select v36, v7, v48, v49 from aggJoin7240191468156604884 join aggView1226497791574270194 using(v36));
create or replace view aggJoin5228819986464290201 as (
with aggView8742164671010613 as (select v36 from aggJoin3217258548609827274 group by v36)
select v36 from aggJoin1140137970751830338 join aggView8742164671010613 using(v36));
create or replace view aggJoin4277066776105210256 as (
with aggView5055524553538870299 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36, v48, v49 from aggJoin9115258673445682563 join aggView5055524553538870299 using(v7));
create or replace view aggJoin3491512749300760219 as (
with aggView5307012710253997466 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin4277066776105210256 group by v36,v49,v48)
select v48, v49 from aggJoin5228819986464290201 join aggView5307012710253997466 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin3491512749300760219;
