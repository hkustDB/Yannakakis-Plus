create or replace view aggJoin6693741803543276798 as (
with aggView1891995188279200759 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView1891995188279200759 where mi.info_type_id=aggView1891995188279200759.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin8244472438776670034 as (
with aggView5711840052105357824 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView5711840052105357824 where mc.company_type_id=aggView5711840052105357824.v14);
create or replace view aggJoin2283749191605770066 as (
with aggView7871477800376993374 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView7871477800376993374 where mk.keyword_id=aggView7871477800376993374.v18);
create or replace view aggJoin8395486945890705240 as (
with aggView8974387998237464339 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin8244472438776670034 join aggView8974387998237464339 using(v7));
create or replace view aggJoin2147313629847893703 as (
with aggView687368956945951339 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView687368956945951339 where cc.status_id=aggView687368956945951339.v5);
create or replace view aggJoin5701770301064101345 as (
with aggView6796289807324147411 as (select v36 from aggJoin8395486945890705240 group by v36)
select v36, v31, v32 from aggJoin6693741803543276798 join aggView6796289807324147411 using(v36));
create or replace view aggJoin160823138890059563 as (
with aggView2219478848435772667 as (select v36 from aggJoin5701770301064101345 group by v36)
select v36 from aggJoin2283749191605770066 join aggView2219478848435772667 using(v36));
create or replace view aggJoin72508783677958025 as (
with aggView1143720699935136633 as (select v36 from aggJoin160823138890059563 group by v36)
select id as v36, title as v37, kind_id as v21, production_year as v40 from title as t, aggView1143720699935136633 where t.id=aggView1143720699935136633.v36 and production_year>1990);
create or replace view aggJoin7774557475120685178 as (
with aggView6780008938647262548 as (select v36 from aggJoin2147313629847893703 group by v36)
select v37, v21, v40 from aggJoin72508783677958025 join aggView6780008938647262548 using(v36));
create or replace view aggView3162493901644656550 as select v37, v21 from aggJoin7774557475120685178 group by v37,v21;
create or replace view aggJoin9098755135086414517 as (
with aggView270712601904478096 as (select v21, MIN(v37) as v49 from aggView3162493901644656550 group by v21)
select kind as v22, v49 from kind_type as kt, aggView270712601904478096 where kt.id=aggView270712601904478096.v21 and kind IN ('movie','tv movie','video movie','video game'));
select MIN(v22) as v48,MIN(v49) as v49 from aggJoin9098755135086414517;
