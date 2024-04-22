create or replace view aggJoin5275735552448953731 as (
with aggView362009937494221219 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView362009937494221219 where mc2.company_id=aggView362009937494221219.v8);
create or replace view aggJoin1084740784566932533 as (
with aggView1222257852439097373 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView1222257852439097373 where mc1.company_id=aggView1222257852439097373.v1);
create or replace view aggJoin268221512638016162 as (
with aggView3068915505781554589 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView3068915505781554589 where ml.link_type_id=aggView3068915505781554589.v23);
create or replace view aggJoin7711867471086467104 as (
with aggView2641660182299745034 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView2641660182299745034 where t1.kind_id=aggView2641660182299745034.v19);
create or replace view aggJoin7825495561589993955 as (
with aggView6608844685930367333 as (select v49, MIN(v50) as v77 from aggJoin7711867471086467104 group by v49)
select v49, v73 as v73, v77 from aggJoin1084740784566932533 join aggView6608844685930367333 using(v49));
create or replace view aggJoin8271462460807552076 as (
with aggView3724539627579628163 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView3724539627579628163 where t2.kind_id=aggView3724539627579628163.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggJoin3595746159658853707 as (
with aggView2964095948685328663 as (select v61, MIN(v62) as v78 from aggJoin8271462460807552076 group by v61)
select v61, v74 as v74, v78 from aggJoin5275735552448953731 join aggView2964095948685328663 using(v61));
create or replace view aggJoin5082930523419665879 as (
with aggView8139865477812390130 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView8139865477812390130 where mi_idx2.info_type_id=aggView8139865477812390130.v17 and info<'3.0');
create or replace view aggJoin3620059264491326185 as (
with aggView8254058007499107174 as (select v61, MIN(v43) as v76 from aggJoin5082930523419665879 group by v61)
select v61, v74 as v74, v78 as v78, v76 from aggJoin3595746159658853707 join aggView8254058007499107174 using(v61));
create or replace view aggJoin5243341830217563200 as (
with aggView2504965132423232011 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView2504965132423232011 where mi_idx1.info_type_id=aggView2504965132423232011.v15);
create or replace view aggJoin2346760759723225054 as (
with aggView6173302246981445418 as (select v49, MIN(v38) as v75 from aggJoin5243341830217563200 group by v49)
select v49, v73 as v73, v77 as v77, v75 from aggJoin7825495561589993955 join aggView6173302246981445418 using(v49));
create or replace view aggJoin574781161810807860 as (
with aggView5369994159494183516 as (select v49, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75 from aggJoin2346760759723225054 group by v49,v75,v77,v73)
select v61, v73, v77, v75 from aggJoin268221512638016162 join aggView5369994159494183516 using(v49));
create or replace view aggJoin6183405832635101123 as (
with aggView8297591499808162657 as (select v61, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75 from aggJoin574781161810807860 group by v61,v75,v77,v73)
select v74 as v74, v78 as v78, v76 as v76, v73, v77, v75 from aggJoin3620059264491326185 join aggView8297591499808162657 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin6183405832635101123;
