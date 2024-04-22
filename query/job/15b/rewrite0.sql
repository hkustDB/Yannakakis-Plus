create or replace view aggJoin8350708605094357987 as (
with aggView6744372209802491392 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select id as v40, title as v41, production_year as v44 from title as t, aggView6744372209802491392 where t.id=aggView6744372209802491392.v40 and production_year<=2010 and production_year>=2005);
create or replace view aggJoin874903732025040859 as (
with aggView5961816434902089894 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView5961816434902089894 where mi.info_type_id=aggView5961816434902089894.v22 and note LIKE '%internet%');
create or replace view aggJoin8444705479541116258 as (
with aggView3933883608568078173 as (select v40, v35 from aggJoin874903732025040859 group by v40,v35)
select v40, v35 from aggView3933883608568078173 where v35 LIKE 'USA:% 200%');
create or replace view aggJoin8115340745564896016 as (
with aggView1071587123428522652 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView1071587123428522652 where mc.company_id=aggView1071587123428522652.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin7660163596566385053 as (
with aggView8361030187843241640 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin8115340745564896016 join aggView8361030187843241640 using(v20));
create or replace view aggJoin492926480566971985 as (
with aggView3952930743794407130 as (select v40 from aggJoin7660163596566385053 group by v40)
select movie_id as v40, keyword_id as v24 from movie_keyword as mk, aggView3952930743794407130 where mk.movie_id=aggView3952930743794407130.v40);
create or replace view aggJoin5330311467385706086 as (
with aggView2577740442715579434 as (select id as v24 from keyword as k)
select v40 from aggJoin492926480566971985 join aggView2577740442715579434 using(v24));
create or replace view aggJoin4327397440542788696 as (
with aggView3194172707298503184 as (select v40 from aggJoin5330311467385706086 group by v40)
select v40, v41, v44 from aggJoin8350708605094357987 join aggView3194172707298503184 using(v40));
create or replace view aggView4431635201573934364 as select v40, v41 from aggJoin4327397440542788696 group by v40,v41;
create or replace view aggJoin3605371317839996710 as (
with aggView5838512459528162452 as (select v40, MIN(v41) as v53 from aggView4431635201573934364 group by v40)
select v35, v53 from aggJoin8444705479541116258 join aggView5838512459528162452 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin3605371317839996710;
