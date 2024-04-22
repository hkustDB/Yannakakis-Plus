create or replace view aggJoin362698203183597874 as (
with aggView3751928533727844888 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView3751928533727844888 where mc.company_id=aggView3751928533727844888.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin8445150969032421064 as (
with aggView7539496981332965285 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView7539496981332965285 where mi_idx.info_type_id=aggView7539496981332965285.v20 and info>'6.5');
create or replace view aggJoin8404089713865607494 as (
with aggView2656994610658501857 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView2656994610658501857 where cc.status_id=aggView2656994610658501857.v7);
create or replace view aggJoin6264561788853116880 as (
with aggView9132420018618352824 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin362698203183597874 join aggView9132420018618352824 using(v16));
create or replace view aggJoin3690322985825046800 as (
with aggView4063035944506545930 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView4063035944506545930 where t.kind_id=aggView4063035944506545930.v25 and production_year>2005);
create or replace view aggJoin1383425668063659575 as (
with aggView5712222866257747656 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin8404089713865607494 join aggView5712222866257747656 using(v5));
create or replace view aggJoin1677160067696505438 as (
with aggView1543796529495795906 as (select v45, MIN(v57) as v57 from aggJoin6264561788853116880 group by v45,v57)
select v45, v40, v57 from aggJoin8445150969032421064 join aggView1543796529495795906 using(v45));
create or replace view aggJoin5304436582446585462 as (
with aggView4612812626184761503 as (select v45, MIN(v57) as v57, MIN(v40) as v58 from aggJoin1677160067696505438 group by v45,v57)
select v45, v57, v58 from aggJoin1383425668063659575 join aggView4612812626184761503 using(v45));
create or replace view aggJoin1005761177716015801 as (
with aggView2213816705705856280 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView2213816705705856280 where mi.info_type_id=aggView2213816705705856280.v18 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin8641859675901356718 as (
with aggView8546254822952253084 as (select v45 from aggJoin1005761177716015801 group by v45)
select v45, v57 as v57, v58 as v58 from aggJoin5304436582446585462 join aggView8546254822952253084 using(v45));
create or replace view aggJoin4717454920326779527 as (
with aggView5847566441893049474 as (select v45, MIN(v57) as v57, MIN(v58) as v58 from aggJoin8641859675901356718 group by v45,v58,v57)
select v45, v46, v49, v57, v58 from aggJoin3690322985825046800 join aggView5847566441893049474 using(v45));
create or replace view aggJoin4623963813780110831 as (
with aggView1430143412571100459 as (select v45, MIN(v57) as v57, MIN(v58) as v58, MIN(v46) as v59 from aggJoin4717454920326779527 group by v45,v58,v57)
select keyword_id as v22, v57, v58, v59 from movie_keyword as mk, aggView1430143412571100459 where mk.movie_id=aggView1430143412571100459.v45);
create or replace view aggJoin4665204759625553267 as (
with aggView4407982032160240910 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v57, v58, v59 from aggJoin4623963813780110831 join aggView4407982032160240910 using(v22));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin4665204759625553267;
