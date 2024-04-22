create or replace view aggView8423193501604681542 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin2898613639095365305 as (
with aggView6525755069646311507 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView6525755069646311507 where cc.status_id=aggView6525755069646311507.v7);
create or replace view aggJoin4695286068644658004 as (
with aggView2115011300392973470 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin2898613639095365305 join aggView2115011300392973470 using(v5));
create or replace view aggJoin758955741228906045 as (
with aggView8767872472535398293 as (select v45 from aggJoin4695286068644658004 group by v45)
select id as v45, title as v46, kind_id as v25, production_year as v49 from title as t, aggView8767872472535398293 where t.id=aggView8767872472535398293.v45 and production_year>2000);
create or replace view aggJoin6883983218914516756 as (
with aggView2409273337799310341 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView2409273337799310341 where mi_idx.info_type_id=aggView2409273337799310341.v20 and info<'8.5');
create or replace view aggView2272661504122590425 as select v40, v45 from aggJoin6883983218914516756 group by v40,v45;
create or replace view aggJoin90061675081137932 as (
with aggView3507524019317832874 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select v45, v46, v49 from aggJoin758955741228906045 join aggView3507524019317832874 using(v25));
create or replace view aggView397138393581694537 as select v45, v46 from aggJoin90061675081137932 group by v45,v46;
create or replace view aggJoin4240630690307501111 as (
with aggView2536896496927577917 as (select v45, MIN(v40) as v58 from aggView2272661504122590425 group by v45)
select v45, v46, v58 from aggView397138393581694537 join aggView2536896496927577917 using(v45));
create or replace view aggJoin3925374268013062709 as (
with aggView2155680427411145577 as (select v45, MIN(v58) as v58, MIN(v46) as v59 from aggJoin4240630690307501111 group by v45,v58)
select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v58, v59 from movie_companies as mc, aggView2155680427411145577 where mc.movie_id=aggView2155680427411145577.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3442420432935939152 as (
with aggView6945147884032901420 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView6945147884032901420 where mk.keyword_id=aggView6945147884032901420.v22);
create or replace view aggJoin4024809569951169978 as (
with aggView8179337864156039804 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView8179337864156039804 where mi.info_type_id=aggView8179337864156039804.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin6340562757329930715 as (
with aggView6709946054110277236 as (select v45 from aggJoin4024809569951169978 group by v45)
select v45, v9, v16, v31, v58 as v58, v59 as v59 from aggJoin3925374268013062709 join aggView6709946054110277236 using(v45));
create or replace view aggJoin4865115569827318932 as (
with aggView9139287302620407501 as (select id as v16 from company_type as ct)
select v45, v9, v31, v58, v59 from aggJoin6340562757329930715 join aggView9139287302620407501 using(v16));
create or replace view aggJoin5231181904583117551 as (
with aggView1717324224022532908 as (select v45 from aggJoin3442420432935939152 group by v45)
select v9, v31, v58 as v58, v59 as v59 from aggJoin4865115569827318932 join aggView1717324224022532908 using(v45));
create or replace view aggJoin3341376219813008985 as (
with aggView9202680760803558173 as (select v9, MIN(v58) as v58, MIN(v59) as v59 from aggJoin5231181904583117551 group by v9,v58,v59)
select v10, v58, v59 from aggView8423193501604681542 join aggView9202680760803558173 using(v9));
select MIN(v10) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin3341376219813008985;
