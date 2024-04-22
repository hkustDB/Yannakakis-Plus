create or replace view aggView3343147229131298408 as select name as v2, id as v1 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView6671441867633747432 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggJoin8547237252732532297 as (
with aggView4022769921176521630 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView4022769921176521630 where mi_idx2.info_type_id=aggView4022769921176521630.v17);
create or replace view aggJoin1722313868918566273 as (
with aggView6131982290043114615 as (select v61, v43 from aggJoin8547237252732532297 group by v61,v43)
select v61, v43 from aggView6131982290043114615 where v43<'3.5');
create or replace view aggJoin7167110607036915073 as (
with aggView296101435569105360 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView296101435569105360 where t2.kind_id=aggView296101435569105360.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView110021260342647516 as select v61, v62 from aggJoin7167110607036915073 group by v61,v62;
create or replace view aggJoin6303377706723227731 as (
with aggView6559244615609113026 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView6559244615609113026 where t1.kind_id=aggView6559244615609113026.v19);
create or replace view aggView9078636331196780848 as select v50, v49 from aggJoin6303377706723227731 group by v50,v49;
create or replace view aggJoin2617138950021566769 as (
with aggView3179359263292984239 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView3179359263292984239 where mi_idx1.info_type_id=aggView3179359263292984239.v15);
create or replace view aggView7088470127906894645 as select v38, v49 from aggJoin2617138950021566769 group by v38,v49;
create or replace view aggJoin941167772304847129 as (
with aggView8965524708440578938 as (select v1, MIN(v2) as v73 from aggView3343147229131298408 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView8965524708440578938 where mc1.company_id=aggView8965524708440578938.v1);
create or replace view aggJoin9187236143404009702 as (
with aggView6961840079778412604 as (select v8, MIN(v9) as v74 from aggView6671441867633747432 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView6961840079778412604 where mc2.company_id=aggView6961840079778412604.v8);
create or replace view aggJoin6519366568431029292 as (
with aggView6341278704426226246 as (select v61, MIN(v43) as v76 from aggJoin1722313868918566273 group by v61)
select v61, v62, v76 from aggView110021260342647516 join aggView6341278704426226246 using(v61));
create or replace view aggJoin2223081713907225566 as (
with aggView3795837751267819981 as (select v61, MIN(v76) as v76, MIN(v62) as v78 from aggJoin6519366568431029292 group by v61,v76)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v76, v78 from movie_link as ml, aggView3795837751267819981 where ml.linked_movie_id=aggView3795837751267819981.v61);
create or replace view aggJoin8831881132935628825 as (
with aggView9081696565840696317 as (select v49, MIN(v73) as v73 from aggJoin941167772304847129 group by v49,v73)
select v50, v49, v73 from aggView9078636331196780848 join aggView9081696565840696317 using(v49));
create or replace view aggJoin5268917002530343068 as (
with aggView7513981484952048682 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v76, v78 from aggJoin2223081713907225566 join aggView7513981484952048682 using(v23));
create or replace view aggJoin4567512858399652137 as (
with aggView4920061125367109660 as (select v61, MIN(v74) as v74 from aggJoin9187236143404009702 group by v61,v74)
select v49, v76 as v76, v78 as v78, v74 from aggJoin5268917002530343068 join aggView4920061125367109660 using(v61));
create or replace view aggJoin8419125997187278628 as (
with aggView7432899847389153234 as (select v49, MIN(v76) as v76, MIN(v78) as v78, MIN(v74) as v74 from aggJoin4567512858399652137 group by v49,v74,v76,v78)
select v50, v49, v73 as v73, v76, v78, v74 from aggJoin8831881132935628825 join aggView7432899847389153234 using(v49));
create or replace view aggJoin8041211290901905001 as (
with aggView8032864918574834102 as (select v49, MIN(v73) as v73, MIN(v76) as v76, MIN(v78) as v78, MIN(v74) as v74, MIN(v50) as v77 from aggJoin8419125997187278628 group by v49,v74,v76,v73,v78)
select v38, v73, v76, v78, v74, v77 from aggView7088470127906894645 join aggView8032864918574834102 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v38) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin8041211290901905001;
