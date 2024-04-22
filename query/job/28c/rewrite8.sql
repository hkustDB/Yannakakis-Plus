create or replace view aggJoin3819173809650175348 as (
with aggView322565780866704973 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView322565780866704973 where mc.company_id=aggView322565780866704973.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin6905344069301876171 as (
with aggView2222589881490263375 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView2222589881490263375 where t.kind_id=aggView2222589881490263375.v25 and production_year>2005);
create or replace view aggJoin155415112475448468 as (
with aggView1120437379412878098 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView1120437379412878098 where cc.subject_id=aggView1120437379412878098.v5);
create or replace view aggJoin1678044936666598 as (
with aggView534306725968677659 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin3819173809650175348 join aggView534306725968677659 using(v16));
create or replace view aggJoin1138425602007291930 as (
with aggView1624551958987260595 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView1624551958987260595 where mi_idx.info_type_id=aggView1624551958987260595.v20 and info<'8.5');
create or replace view aggJoin2008084306350939051 as (
with aggView5744068295293177436 as (select v45, MIN(v40) as v58 from aggJoin1138425602007291930 group by v45)
select v45, v46, v49, v58 from aggJoin6905344069301876171 join aggView5744068295293177436 using(v45));
create or replace view aggJoin6308638702658553907 as (
with aggView1522256647369839291 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin155415112475448468 join aggView1522256647369839291 using(v7));
create or replace view aggJoin1008714712657968497 as (
with aggView5290738400053435308 as (select v45, MIN(v57) as v57 from aggJoin1678044936666598 group by v45,v57)
select v45, v46, v49, v58 as v58, v57 from aggJoin2008084306350939051 join aggView5290738400053435308 using(v45));
create or replace view aggJoin5932234465487191429 as (
with aggView7337117604218966965 as (select v45, MIN(v58) as v58, MIN(v57) as v57, MIN(v46) as v59 from aggJoin1008714712657968497 group by v45,v57,v58)
select v45, v58, v57, v59 from aggJoin6308638702658553907 join aggView7337117604218966965 using(v45));
create or replace view aggJoin4076868853324162894 as (
with aggView4220749470625570642 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView4220749470625570642 where mk.keyword_id=aggView4220749470625570642.v22);
create or replace view aggJoin5035333405351961258 as (
with aggView208821826041690905 as (select v45, MIN(v58) as v58, MIN(v57) as v57, MIN(v59) as v59 from aggJoin5932234465487191429 group by v45,v57,v58,v59)
select v45, v58, v57, v59 from aggJoin4076868853324162894 join aggView208821826041690905 using(v45));
create or replace view aggJoin9048824876587015790 as (
with aggView2192570223217980483 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView2192570223217980483 where mi.info_type_id=aggView2192570223217980483.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1481660658079506353 as (
with aggView1972917901398766827 as (select v45 from aggJoin9048824876587015790 group by v45)
select v58 as v58, v57 as v57, v59 as v59 from aggJoin5035333405351961258 join aggView1972917901398766827 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin1481660658079506353;
