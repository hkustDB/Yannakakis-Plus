create or replace view aggView2059574457624006759 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin1414032893325862693 as (
with aggView1015476825010968033 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView1015476825010968033 where mi_idx.info_type_id=aggView1015476825010968033.v20 and info>'6.5');
create or replace view aggJoin6738843955470575461 as (
with aggView1154928654304028398 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView1154928654304028398 where cc.status_id=aggView1154928654304028398.v7);
create or replace view aggJoin3357771768484791228 as (
with aggView6790077618562858450 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView6790077618562858450 where t.kind_id=aggView6790077618562858450.v25 and production_year>2005);
create or replace view aggView309024484542382039 as select v46, v45 from aggJoin3357771768484791228 group by v46,v45;
create or replace view aggJoin8015785865495079080 as (
with aggView5499148111873096926 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin6738843955470575461 join aggView5499148111873096926 using(v5));
create or replace view aggJoin3589004269610000127 as (
with aggView8099931425710748785 as (select v45 from aggJoin8015785865495079080 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView8099931425710748785 where mi.movie_id=aggView8099931425710748785.v45 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin1102010637137797738 as (
with aggView8130818648488434942 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin3589004269610000127 join aggView8130818648488434942 using(v18));
create or replace view aggJoin6019174961878372997 as (
with aggView4533021296907364060 as (select v45 from aggJoin1102010637137797738 group by v45)
select v45, v40 from aggJoin1414032893325862693 join aggView4533021296907364060 using(v45));
create or replace view aggView402424379254075655 as select v45, v40 from aggJoin6019174961878372997 group by v45,v40;
create or replace view aggJoin7546132732098992460 as (
with aggView5699619668288870931 as (select v45, MIN(v46) as v59 from aggView309024484542382039 group by v45)
select v45, v40, v59 from aggView402424379254075655 join aggView5699619668288870931 using(v45));
create or replace view aggJoin8213862944571146180 as (
with aggView7485248221216212275 as (select v45, MIN(v59) as v59, MIN(v40) as v58 from aggJoin7546132732098992460 group by v45,v59)
select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v59, v58 from movie_companies as mc, aggView7485248221216212275 where mc.movie_id=aggView7485248221216212275.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3452230138786760323 as (
with aggView7399138757642433870 as (select id as v16 from company_type as ct)
select v45, v9, v31, v59, v58 from aggJoin8213862944571146180 join aggView7399138757642433870 using(v16));
create or replace view aggJoin8214198183165799531 as (
with aggView8947777982871625064 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView8947777982871625064 where mk.keyword_id=aggView8947777982871625064.v22);
create or replace view aggJoin8211285486792597851 as (
with aggView8365838683724131545 as (select v45 from aggJoin8214198183165799531 group by v45)
select v9, v31, v59 as v59, v58 as v58 from aggJoin3452230138786760323 join aggView8365838683724131545 using(v45));
create or replace view aggJoin974517453799282702 as (
with aggView4124739642584050058 as (select v9, MIN(v59) as v59, MIN(v58) as v58 from aggJoin8211285486792597851 group by v9,v59,v58)
select v10, v59, v58 from aggView2059574457624006759 join aggView4124739642584050058 using(v9));
select MIN(v10) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin974517453799282702;
