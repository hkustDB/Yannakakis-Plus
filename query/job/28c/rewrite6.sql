create or replace view aggJoin3886856611445253050 as (
with aggView967023897642075038 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView967023897642075038 where mc.company_id=aggView967023897642075038.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1336500207041209140 as (
with aggView6104729211116363512 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView6104729211116363512 where t.kind_id=aggView6104729211116363512.v25 and production_year>2005);
create or replace view aggJoin7884963759430100457 as (
with aggView6047564191728124464 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView6047564191728124464 where cc.subject_id=aggView6047564191728124464.v5);
create or replace view aggJoin6021841671332917066 as (
with aggView7808465860879545428 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin3886856611445253050 join aggView7808465860879545428 using(v16));
create or replace view aggJoin8868116685095822329 as (
with aggView1638158569457221576 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView1638158569457221576 where mi_idx.info_type_id=aggView1638158569457221576.v20 and info<'8.5');
create or replace view aggJoin530741383355443381 as (
with aggView7024084547270314553 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin7884963759430100457 join aggView7024084547270314553 using(v7));
create or replace view aggJoin7878086321078564342 as (
with aggView11542851224692632 as (select v45 from aggJoin530741383355443381 group by v45)
select v45, v46, v49 from aggJoin1336500207041209140 join aggView11542851224692632 using(v45));
create or replace view aggJoin992923302810327918 as (
with aggView5662750136787629738 as (select v45, MIN(v46) as v59 from aggJoin7878086321078564342 group by v45)
select v45, v31, v57 as v57, v59 from aggJoin6021841671332917066 join aggView5662750136787629738 using(v45));
create or replace view aggJoin4179472020728142859 as (
with aggView1902633516011462634 as (select v45, MIN(v57) as v57, MIN(v59) as v59 from aggJoin992923302810327918 group by v45,v57,v59)
select v45, v40, v57, v59 from aggJoin8868116685095822329 join aggView1902633516011462634 using(v45));
create or replace view aggJoin2223167736999976676 as (
with aggView5677560796697347520 as (select v45, MIN(v57) as v57, MIN(v59) as v59, MIN(v40) as v58 from aggJoin4179472020728142859 group by v45,v57,v59)
select movie_id as v45, keyword_id as v22, v57, v59, v58 from movie_keyword as mk, aggView5677560796697347520 where mk.movie_id=aggView5677560796697347520.v45);
create or replace view aggJoin4314463504110764098 as (
with aggView3470469066611729214 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v45, v57, v59, v58 from aggJoin2223167736999976676 join aggView3470469066611729214 using(v22));
create or replace view aggJoin6513914922790458155 as (
with aggView1731427674110544777 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView1731427674110544777 where mi.info_type_id=aggView1731427674110544777.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1671102095244266731 as (
with aggView3269761675852767371 as (select v45 from aggJoin6513914922790458155 group by v45)
select v57 as v57, v59 as v59, v58 as v58 from aggJoin4314463504110764098 join aggView3269761675852767371 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin1671102095244266731;
