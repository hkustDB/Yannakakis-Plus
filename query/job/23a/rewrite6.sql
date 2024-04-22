create or replace view aggJoin4686257407976112486 as (
with aggView1541525487476603655 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView1541525487476603655 where mc.company_type_id=aggView1541525487476603655.v14);
create or replace view aggJoin2962654700360758546 as (
with aggView478102918583332491 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView478102918583332491 where mk.keyword_id=aggView478102918583332491.v18);
create or replace view aggJoin3114656224032508244 as (
with aggView9002491313168997830 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView9002491313168997830 where mi.info_type_id=aggView9002491313168997830.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin2692229939987314272 as (
with aggView7334558245054476381 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView7334558245054476381 where cc.status_id=aggView7334558245054476381.v5);
create or replace view aggJoin445375566135945137 as (
with aggView5809308855143345793 as (select v36 from aggJoin3114656224032508244 group by v36)
select v36 from aggJoin2962654700360758546 join aggView5809308855143345793 using(v36));
create or replace view aggJoin1243001709408150120 as (
with aggView8775525337018639484 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin4686257407976112486 join aggView8775525337018639484 using(v7));
create or replace view aggJoin86409123087110704 as (
with aggView4905053329312673012 as (select v36 from aggJoin1243001709408150120 group by v36)
select v36 from aggJoin2692229939987314272 join aggView4905053329312673012 using(v36));
create or replace view aggJoin6153161806746557827 as (
with aggView3931961727215343450 as (select v36 from aggJoin86409123087110704 group by v36)
select v36 from aggJoin445375566135945137 join aggView3931961727215343450 using(v36));
create or replace view aggJoin4462784649541605334 as (
with aggView956428038008160505 as (select v36 from aggJoin6153161806746557827 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView956428038008160505 where t.id=aggView956428038008160505.v36 and production_year>2000);
create or replace view aggView1120129869761899551 as select v21, v37 from aggJoin4462784649541605334 group by v21,v37;
create or replace view aggJoin1709945686083278509 as (
with aggView5917795160699363017 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select v37, v48 from aggView1120129869761899551 join aggView5917795160699363017 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin1709945686083278509;
