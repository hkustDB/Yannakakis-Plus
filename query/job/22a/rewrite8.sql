create or replace view aggJoin2601718608596542498 as (
with aggView5374237579375858486 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView5374237579375858486 where mc.company_id=aggView5374237579375858486.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin5446597448874211273 as (
with aggView4646258778423711554 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin2601718608596542498 join aggView4646258778423711554 using(v8));
create or replace view aggJoin6208454528653966296 as (
with aggView5861269508212645150 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView5861269508212645150 where mi_idx.info_type_id=aggView5861269508212645150.v12 and info<'7.0');
create or replace view aggJoin8809091015998491311 as (
with aggView9118335053204465253 as (select v37, MIN(v32) as v50 from aggJoin6208454528653966296 group by v37)
select v37, v23, v49 as v49, v50 from aggJoin5446597448874211273 join aggView9118335053204465253 using(v37));
create or replace view aggJoin7088003877269738869 as (
with aggView8909881403313864696 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView8909881403313864696 where t.kind_id=aggView8909881403313864696.v17 and production_year>2008);
create or replace view aggJoin2172305283048836150 as (
with aggView3618366219053004596 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView3618366219053004596 where mi.info_type_id=aggView3618366219053004596.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin7044970594016674062 as (
with aggView7040861669978189083 as (select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin8809091015998491311 group by v37,v49,v50)
select v37, v27, v49, v50 from aggJoin2172305283048836150 join aggView7040861669978189083 using(v37));
create or replace view aggJoin6955763899298335315 as (
with aggView5641442408420847487 as (select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin7044970594016674062 group by v37,v49,v50)
select v37, v38, v41, v49, v50 from aggJoin7088003877269738869 join aggView5641442408420847487 using(v37));
create or replace view aggJoin7022782242569796794 as (
with aggView8113415377027813395 as (select v37, MIN(v49) as v49, MIN(v50) as v50, MIN(v38) as v51 from aggJoin6955763899298335315 group by v37,v49,v50)
select keyword_id as v14, v49, v50, v51 from movie_keyword as mk, aggView8113415377027813395 where mk.movie_id=aggView8113415377027813395.v37);
create or replace view aggJoin2593340882134083922 as (
with aggView5800775072965444841 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v49, v50, v51 from aggJoin7022782242569796794 join aggView5800775072965444841 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin2593340882134083922;
