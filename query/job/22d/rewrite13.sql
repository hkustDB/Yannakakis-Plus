create or replace view aggJoin8994893727771621789 as (
with aggView5594169373837502862 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView5594169373837502862 where mc.company_id=aggView5594169373837502862.v1);
create or replace view aggJoin921731346357040590 as (
with aggView8444425889350201917 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView8444425889350201917 where mi.info_type_id=aggView8444425889350201917.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8598066415334706534 as (
with aggView9076464755444246664 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView9076464755444246664 where mk.keyword_id=aggView9076464755444246664.v14);
create or replace view aggJoin2206223353170398196 as (
with aggView2134403323909441674 as (select v37 from aggJoin921731346357040590 group by v37)
select id as v37, title as v38, kind_id as v17, production_year as v41 from title as t, aggView2134403323909441674 where t.id=aggView2134403323909441674.v37 and production_year>2005);
create or replace view aggJoin1586555195219092684 as (
with aggView5915447349208403784 as (select id as v8 from company_type as ct)
select v37, v49 from aggJoin8994893727771621789 join aggView5915447349208403784 using(v8));
create or replace view aggJoin2569859073072694566 as (
with aggView8813126881008286539 as (select v37, MIN(v49) as v49 from aggJoin1586555195219092684 group by v37,v49)
select v37, v38, v17, v41, v49 from aggJoin2206223353170398196 join aggView8813126881008286539 using(v37));
create or replace view aggJoin8472955636190507049 as (
with aggView8423256903490458880 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView8423256903490458880 where mi_idx.info_type_id=aggView8423256903490458880.v12 and info<'8.5');
create or replace view aggJoin6834265687983870871 as (
with aggView6614088148470447241 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41, v49 from aggJoin2569859073072694566 join aggView6614088148470447241 using(v17));
create or replace view aggJoin1483590026275343985 as (
with aggView5170387413272310715 as (select v37, MIN(v49) as v49, MIN(v38) as v51 from aggJoin6834265687983870871 group by v37,v49)
select v37, v32, v49, v51 from aggJoin8472955636190507049 join aggView5170387413272310715 using(v37));
create or replace view aggJoin2690318181920192090 as (
with aggView280996762474643894 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v32) as v50 from aggJoin1483590026275343985 group by v37,v51,v49)
select v49, v51, v50 from aggJoin8598066415334706534 join aggView280996762474643894 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin2690318181920192090;
