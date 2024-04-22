create or replace view aggJoin2581578569020993714 as (
with aggView5977845760932916423 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView5977845760932916423 where mc2.company_id=aggView5977845760932916423.v8);
create or replace view aggJoin36065949449274563 as (
with aggView2417804619303868012 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView2417804619303868012 where mc1.company_id=aggView2417804619303868012.v1);
create or replace view aggJoin395703060408926841 as (
with aggView3534821137447002670 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView3534821137447002670 where ml.link_type_id=aggView3534821137447002670.v23);
create or replace view aggJoin1794203004068572716 as (
with aggView7134037214271888326 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView7134037214271888326 where t2.kind_id=aggView7134037214271888326.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggJoin16378246473489781 as (
with aggView2795784637531580709 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView2795784637531580709 where t1.kind_id=aggView2795784637531580709.v19);
create or replace view aggJoin6355774259905341728 as (
with aggView1276272181106002067 as (select v49, MIN(v50) as v77 from aggJoin16378246473489781 group by v49)
select movie_id as v49, info_type_id as v15, info as v38, v77 from movie_info_idx as mi_idx1, aggView1276272181106002067 where mi_idx1.movie_id=aggView1276272181106002067.v49);
create or replace view aggJoin8707624056297123567 as (
with aggView7926108981955191959 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView7926108981955191959 where mi_idx2.info_type_id=aggView7926108981955191959.v17 and info<'3.0');
create or replace view aggJoin1369514912358206287 as (
with aggView7857651980688150287 as (select id as v15 from info_type as it1 where info= 'rating')
select v49, v38, v77 from aggJoin6355774259905341728 join aggView7857651980688150287 using(v15));
create or replace view aggJoin3750097713815952712 as (
with aggView1273379286977594476 as (select v61, MIN(v74) as v74 from aggJoin2581578569020993714 group by v61,v74)
select v61, v43, v74 from aggJoin8707624056297123567 join aggView1273379286977594476 using(v61));
create or replace view aggJoin6564501117704024198 as (
with aggView3599688816157015977 as (select v61, MIN(v74) as v74, MIN(v43) as v76 from aggJoin3750097713815952712 group by v61,v74)
select v61, v62, v65, v74, v76 from aggJoin1794203004068572716 join aggView3599688816157015977 using(v61));
create or replace view aggJoin3737105990867294946 as (
with aggView645318332777911591 as (select v61, MIN(v74) as v74, MIN(v76) as v76, MIN(v62) as v78 from aggJoin6564501117704024198 group by v61,v76,v74)
select v49, v74, v76, v78 from aggJoin395703060408926841 join aggView645318332777911591 using(v61));
create or replace view aggJoin7414222835208309040 as (
with aggView2718980179521521967 as (select v49, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78 from aggJoin3737105990867294946 group by v49,v74,v76,v78)
select v49, v38, v77 as v77, v74, v76, v78 from aggJoin1369514912358206287 join aggView2718980179521521967 using(v49));
create or replace view aggJoin645095832203332027 as (
with aggView1636358154554661472 as (select v49, MIN(v77) as v77, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78, MIN(v38) as v75 from aggJoin7414222835208309040 group by v49,v77,v74,v76,v78)
select v73 as v73, v77, v74, v76, v78, v75 from aggJoin36065949449274563 join aggView1636358154554661472 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin645095832203332027;
