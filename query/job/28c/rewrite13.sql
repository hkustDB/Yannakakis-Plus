create or replace view aggView4645016704521108356 as select id as v9, name as v10 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin7964466928925470768 as (
with aggView3377272782393600273 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView3377272782393600273 where t.kind_id=aggView3377272782393600273.v25 and production_year>2005);
create or replace view aggJoin640332498891008619 as (
with aggView6497311244556822307 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView6497311244556822307 where mi_idx.info_type_id=aggView6497311244556822307.v20);
create or replace view aggJoin2711167386572367732 as (
with aggView3644502546096934020 as (select v40, v45 from aggJoin640332498891008619 group by v40,v45)
select v45, v40 from aggView3644502546096934020 where v40<'8.5');
create or replace view aggJoin6330619131184073260 as (
with aggView5979700041346549542 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView5979700041346549542 where mi.info_type_id=aggView5979700041346549542.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin7963348320953526128 as (
with aggView6018115347299629930 as (select v45 from aggJoin6330619131184073260 group by v45)
select v45, v46, v49 from aggJoin7964466928925470768 join aggView6018115347299629930 using(v45));
create or replace view aggView8993454005478152282 as select v46, v45 from aggJoin7963348320953526128 group by v46,v45;
create or replace view aggJoin682413253939803492 as (
with aggView4552727632272810465 as (select v9, MIN(v10) as v57 from aggView4645016704521108356 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView4552727632272810465 where mc.company_id=aggView4552727632272810465.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1581670927519910720 as (
with aggView1434044265531004673 as (select v45, MIN(v46) as v59 from aggView8993454005478152282 group by v45)
select v45, v16, v31, v57 as v57, v59 from aggJoin682413253939803492 join aggView1434044265531004673 using(v45));
create or replace view aggJoin6323382007674473800 as (
with aggView2956387470612682665 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView2956387470612682665 where cc.subject_id=aggView2956387470612682665.v5);
create or replace view aggJoin4951642184202787121 as (
with aggView8653733823177225056 as (select id as v16 from company_type as ct)
select v45, v31, v57, v59 from aggJoin1581670927519910720 join aggView8653733823177225056 using(v16));
create or replace view aggJoin5644544345550590621 as (
with aggView2780363752225873719 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin6323382007674473800 join aggView2780363752225873719 using(v7));
create or replace view aggJoin4866189960909030615 as (
with aggView8330563938323791436 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView8330563938323791436 where mk.keyword_id=aggView8330563938323791436.v22);
create or replace view aggJoin7767582380339428679 as (
with aggView8506407744406621780 as (select v45 from aggJoin5644544345550590621 group by v45)
select v45 from aggJoin4866189960909030615 join aggView8506407744406621780 using(v45));
create or replace view aggJoin7194508380303787923 as (
with aggView1428974296869634424 as (select v45 from aggJoin7767582380339428679 group by v45)
select v45, v31, v57 as v57, v59 as v59 from aggJoin4951642184202787121 join aggView1428974296869634424 using(v45));
create or replace view aggJoin1369331621071990436 as (
with aggView4209034877195002663 as (select v45, MIN(v57) as v57, MIN(v59) as v59 from aggJoin7194508380303787923 group by v45,v57,v59)
select v40, v57, v59 from aggJoin2711167386572367732 join aggView4209034877195002663 using(v45));
select MIN(v57) as v57,MIN(v40) as v58,MIN(v59) as v59 from aggJoin1369331621071990436;
