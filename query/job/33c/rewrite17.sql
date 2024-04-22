create or replace view aggJoin6595009807664870883 as (
with aggView3578476111924029011 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView3578476111924029011 where mc2.company_id=aggView3578476111924029011.v8);
create or replace view aggJoin7304993971926305612 as (
with aggView6013554109306378046 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView6013554109306378046 where mc1.company_id=aggView6013554109306378046.v1);
create or replace view aggJoin6764851209971908837 as (
with aggView373194386841805907 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView373194386841805907 where mi_idx2.info_type_id=aggView373194386841805907.v17 and info<'3.5');
create or replace view aggJoin5929242019589615469 as (
with aggView4604639843937434351 as (select v61, MIN(v43) as v76 from aggJoin6764851209971908837 group by v61)
select v61, v74 as v74, v76 from aggJoin6595009807664870883 join aggView4604639843937434351 using(v61));
create or replace view aggJoin5794066982517876949 as (
with aggView761748944227092686 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView761748944227092686 where t2.kind_id=aggView761748944227092686.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin752452517950387433 as (
with aggView1408623571118766521 as (select v61, MIN(v62) as v78 from aggJoin5794066982517876949 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v78 from movie_link as ml, aggView1408623571118766521 where ml.linked_movie_id=aggView1408623571118766521.v61);
create or replace view aggJoin5758328874099000756 as (
with aggView5592710618677176320 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView5592710618677176320 where t1.kind_id=aggView5592710618677176320.v19);
create or replace view aggJoin8814259162983180861 as (
with aggView9030319319932003057 as (select v49, MIN(v50) as v77 from aggJoin5758328874099000756 group by v49)
select v49, v73 as v73, v77 from aggJoin7304993971926305612 join aggView9030319319932003057 using(v49));
create or replace view aggJoin1867252770833366163 as (
with aggView2304047268663183370 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v78 from aggJoin752452517950387433 join aggView2304047268663183370 using(v23));
create or replace view aggJoin7527676653073132883 as (
with aggView1615472827968163366 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView1615472827968163366 where mi_idx1.info_type_id=aggView1615472827968163366.v15);
create or replace view aggJoin88740677887092417 as (
with aggView1413837664333648096 as (select v49, MIN(v38) as v75 from aggJoin7527676653073132883 group by v49)
select v49, v61, v78 as v78, v75 from aggJoin1867252770833366163 join aggView1413837664333648096 using(v49));
create or replace view aggJoin6407006740151746850 as (
with aggView4800705425093805849 as (select v61, MIN(v74) as v74, MIN(v76) as v76 from aggJoin5929242019589615469 group by v61,v74,v76)
select v49, v78 as v78, v75 as v75, v74, v76 from aggJoin88740677887092417 join aggView4800705425093805849 using(v61));
create or replace view aggJoin3409468569345215867 as (
with aggView3803900577633802520 as (select v49, MIN(v78) as v78, MIN(v75) as v75, MIN(v74) as v74, MIN(v76) as v76 from aggJoin6407006740151746850 group by v49,v74,v75,v76,v78)
select v73 as v73, v77 as v77, v78, v75, v74, v76 from aggJoin8814259162983180861 join aggView3803900577633802520 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin3409468569345215867;
