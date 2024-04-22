create or replace view aggJoin8057348029895726612 as (
with aggView3808865199916661006 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView3808865199916661006 where mc.company_id=aggView3808865199916661006.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1551976969242210961 as (
with aggView7018003929730643573 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView7018003929730643573 where mi_idx.info_type_id=aggView7018003929730643573.v20 and info>'6.5');
create or replace view aggJoin6386947363663389502 as (
with aggView3941950903557113354 as (select v45, MIN(v40) as v58 from aggJoin1551976969242210961 group by v45)
select movie_id as v45, info_type_id as v18, info as v35, v58 from movie_info as mi, aggView3941950903557113354 where mi.movie_id=aggView3941950903557113354.v45 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin1004538737093758182 as (
with aggView7205285835477549751 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView7205285835477549751 where cc.status_id=aggView7205285835477549751.v7);
create or replace view aggJoin9076970598869083948 as (
with aggView3791901274428892937 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin8057348029895726612 join aggView3791901274428892937 using(v16));
create or replace view aggJoin2169964775781400608 as (
with aggView9101355036013956438 as (select v45, MIN(v57) as v57 from aggJoin9076970598869083948 group by v45,v57)
select v45, v5, v57 from aggJoin1004538737093758182 join aggView9101355036013956438 using(v45));
create or replace view aggJoin2869877499734254218 as (
with aggView1569109215641650889 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView1569109215641650889 where t.kind_id=aggView1569109215641650889.v25 and production_year>2005);
create or replace view aggJoin1725871728509401982 as (
with aggView4522598368714575876 as (select v45, MIN(v46) as v59 from aggJoin2869877499734254218 group by v45)
select v45, v5, v57 as v57, v59 from aggJoin2169964775781400608 join aggView4522598368714575876 using(v45));
create or replace view aggJoin8310022311191383927 as (
with aggView5744100737615300694 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45, v57, v59 from aggJoin1725871728509401982 join aggView5744100737615300694 using(v5));
create or replace view aggJoin4328878178746263385 as (
with aggView691678773303365197 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35, v58 from aggJoin6386947363663389502 join aggView691678773303365197 using(v18));
create or replace view aggJoin1461867442801532691 as (
with aggView1021370632515162461 as (select v45, MIN(v58) as v58 from aggJoin4328878178746263385 group by v45,v58)
select v45, v57 as v57, v59 as v59, v58 from aggJoin8310022311191383927 join aggView1021370632515162461 using(v45));
create or replace view aggJoin2276561639263874146 as (
with aggView5432843075245091468 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView5432843075245091468 where mk.keyword_id=aggView5432843075245091468.v22);
create or replace view aggJoin4003820187689843056 as (
with aggView4439456719964766245 as (select v45, MIN(v57) as v57, MIN(v59) as v59, MIN(v58) as v58 from aggJoin1461867442801532691 group by v45,v59,v58,v57)
select v57, v59, v58 from aggJoin2276561639263874146 join aggView4439456719964766245 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin4003820187689843056;
