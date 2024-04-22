create or replace view aggJoin6117468215412158681 as (
with aggView1245246412042659852 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView1245246412042659852 where mc.company_id=aggView1245246412042659852.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin6634344715653727673 as (
with aggView597831312492505147 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView597831312492505147 where t.kind_id=aggView597831312492505147.v25 and production_year>2005);
create or replace view aggJoin6414970191561745909 as (
with aggView885826436066620395 as (select v45, MIN(v46) as v59 from aggJoin6634344715653727673 group by v45)
select movie_id as v45, info_type_id as v20, info as v40, v59 from movie_info_idx as mi_idx, aggView885826436066620395 where mi_idx.movie_id=aggView885826436066620395.v45 and info<'8.5');
create or replace view aggJoin2630827949485204172 as (
with aggView2752529262580253442 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView2752529262580253442 where cc.subject_id=aggView2752529262580253442.v5);
create or replace view aggJoin2994677158161007197 as (
with aggView7783879670658619288 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin6117468215412158681 join aggView7783879670658619288 using(v16));
create or replace view aggJoin6702925946854042897 as (
with aggView750980696121119022 as (select id as v20 from info_type as it2 where info= 'rating')
select v45, v40, v59 from aggJoin6414970191561745909 join aggView750980696121119022 using(v20));
create or replace view aggJoin8381282277575257062 as (
with aggView3222016527585661013 as (select v45, MIN(v59) as v59, MIN(v40) as v58 from aggJoin6702925946854042897 group by v45,v59)
select v45, v31, v57 as v57, v59, v58 from aggJoin2994677158161007197 join aggView3222016527585661013 using(v45));
create or replace view aggJoin6948689094644731777 as (
with aggView2631259163560648932 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin2630827949485204172 join aggView2631259163560648932 using(v7));
create or replace view aggJoin4849288654566095938 as (
with aggView4198511768950908193 as (select v45 from aggJoin6948689094644731777 group by v45)
select v45, v31, v57 as v57, v59 as v59, v58 as v58 from aggJoin8381282277575257062 join aggView4198511768950908193 using(v45));
create or replace view aggJoin1299411640199699564 as (
with aggView2734744245121683038 as (select v45, MIN(v57) as v57, MIN(v59) as v59, MIN(v58) as v58 from aggJoin4849288654566095938 group by v45,v57,v58,v59)
select movie_id as v45, info_type_id as v18, info as v35, v57, v59, v58 from movie_info as mi, aggView2734744245121683038 where mi.movie_id=aggView2734744245121683038.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8067019174924167047 as (
with aggView3068142222010135386 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView3068142222010135386 where mk.keyword_id=aggView3068142222010135386.v22);
create or replace view aggJoin4049505403666454908 as (
with aggView566671413140279617 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35, v57, v59, v58 from aggJoin1299411640199699564 join aggView566671413140279617 using(v18));
create or replace view aggJoin2398250911468292610 as (
with aggView8297739908290368336 as (select v45, MIN(v57) as v57, MIN(v59) as v59, MIN(v58) as v58 from aggJoin4049505403666454908 group by v45,v57,v58,v59)
select v57, v59, v58 from aggJoin8067019174924167047 join aggView8297739908290368336 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin2398250911468292610;
