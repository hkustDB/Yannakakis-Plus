create or replace view aggView8302129718432298244 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin2048172228609557158 as (
with aggView8330783389140891579 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView8330783389140891579 where mi.info_type_id=aggView8330783389140891579.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin7002797624844966912 as (
with aggView105395254346278864 as (select v45 from aggJoin2048172228609557158 group by v45)
select movie_id as v45, subject_id as v5, status_id as v7 from complete_cast as cc, aggView105395254346278864 where cc.movie_id=aggView105395254346278864.v45);
create or replace view aggJoin8763109773480863317 as (
with aggView2461419819957838860 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select v45, v5 from aggJoin7002797624844966912 join aggView2461419819957838860 using(v7));
create or replace view aggJoin7954980604067491482 as (
with aggView6171359017790109096 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin8763109773480863317 join aggView6171359017790109096 using(v5));
create or replace view aggJoin4963868685163809213 as (
with aggView5705440221894816948 as (select v45 from aggJoin7954980604067491482 group by v45)
select movie_id as v45, info_type_id as v20, info as v40 from movie_info_idx as mi_idx, aggView5705440221894816948 where mi_idx.movie_id=aggView5705440221894816948.v45 and info<'8.5');
create or replace view aggJoin1135982698055002090 as (
with aggView1238461677151006757 as (select id as v20 from info_type as it2 where info= 'rating')
select v45, v40 from aggJoin4963868685163809213 join aggView1238461677151006757 using(v20));
create or replace view aggView3658263046578466954 as select v40, v45 from aggJoin1135982698055002090 group by v40,v45;
create or replace view aggJoin1651503292323145082 as (
with aggView7460099799396629900 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView7460099799396629900 where t.kind_id=aggView7460099799396629900.v25 and production_year>2000);
create or replace view aggView7495474305337754832 as select v45, v46 from aggJoin1651503292323145082 group by v45,v46;
create or replace view aggJoin1175303013618582948 as (
with aggView1862235021991074264 as (select v9, MIN(v10) as v57 from aggView8302129718432298244 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView1862235021991074264 where mc.company_id=aggView1862235021991074264.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1322772292610242841 as (
with aggView3915916676175138005 as (select v45, MIN(v40) as v58 from aggView3658263046578466954 group by v45)
select v45, v16, v31, v57 as v57, v58 from aggJoin1175303013618582948 join aggView3915916676175138005 using(v45));
create or replace view aggJoin2238920089579896409 as (
with aggView6167102539754909929 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView6167102539754909929 where mk.keyword_id=aggView6167102539754909929.v22);
create or replace view aggJoin320709991924763957 as (
with aggView3052700602582363664 as (select id as v16 from company_type as ct)
select v45, v31, v57, v58 from aggJoin1322772292610242841 join aggView3052700602582363664 using(v16));
create or replace view aggJoin2625253040593078402 as (
with aggView1729983355043806207 as (select v45 from aggJoin2238920089579896409 group by v45)
select v45, v31, v57 as v57, v58 as v58 from aggJoin320709991924763957 join aggView1729983355043806207 using(v45));
create or replace view aggJoin5847856997187640010 as (
with aggView5223589095022441922 as (select v45, MIN(v57) as v57, MIN(v58) as v58 from aggJoin2625253040593078402 group by v45,v58,v57)
select v46, v57, v58 from aggView7495474305337754832 join aggView5223589095022441922 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin5847856997187640010;
