create or replace view aggJoin6165039259429938337 as (
with aggView1514484295070035691 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView1514484295070035691 where mc2.company_id=aggView1514484295070035691.v8);
create or replace view aggJoin340287240880648167 as (
with aggView2610262294473375193 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView2610262294473375193 where mc1.company_id=aggView2610262294473375193.v1);
create or replace view aggJoin1871713078084269786 as (
with aggView6739570243687814221 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView6739570243687814221 where mi_idx2.info_type_id=aggView6739570243687814221.v17 and info<'3.5');
create or replace view aggJoin7015691211638289247 as (
with aggView5418800207234848212 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView5418800207234848212 where t2.kind_id=aggView5418800207234848212.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin3276438836968892086 as (
with aggView7688859482319736069 as (select v61, MIN(v62) as v78 from aggJoin7015691211638289247 group by v61)
select v61, v43, v78 from aggJoin1871713078084269786 join aggView7688859482319736069 using(v61));
create or replace view aggJoin2088439237110566360 as (
with aggView961087896281922624 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView961087896281922624 where t1.kind_id=aggView961087896281922624.v19);
create or replace view aggJoin5352898201068601544 as (
with aggView39079570309986925 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView39079570309986925 where ml.link_type_id=aggView39079570309986925.v23);
create or replace view aggJoin6483469438439018372 as (
with aggView6056135301495903340 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView6056135301495903340 where mi_idx1.info_type_id=aggView6056135301495903340.v15);
create or replace view aggJoin2326984178770193152 as (
with aggView3816626637751771544 as (select v49, MIN(v38) as v75 from aggJoin6483469438439018372 group by v49)
select v49, v61, v75 from aggJoin5352898201068601544 join aggView3816626637751771544 using(v49));
create or replace view aggJoin5491966388628466149 as (
with aggView2477096819780436261 as (select v49, MIN(v73) as v73 from aggJoin340287240880648167 group by v49,v73)
select v49, v50, v73 from aggJoin2088439237110566360 join aggView2477096819780436261 using(v49));
create or replace view aggJoin5238997716573644646 as (
with aggView5676000041292507614 as (select v49, MIN(v73) as v73, MIN(v50) as v77 from aggJoin5491966388628466149 group by v49,v73)
select v61, v75 as v75, v73, v77 from aggJoin2326984178770193152 join aggView5676000041292507614 using(v49));
create or replace view aggJoin8399734908520641581 as (
with aggView3131128071517604730 as (select v61, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77 from aggJoin5238997716573644646 group by v61,v77,v75,v73)
select v61, v43, v78 as v78, v75, v73, v77 from aggJoin3276438836968892086 join aggView3131128071517604730 using(v61));
create or replace view aggJoin498576514049160243 as (
with aggView4475710069418932168 as (select v61, MIN(v78) as v78, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77, MIN(v43) as v76 from aggJoin8399734908520641581 group by v61,v77,v75,v73,v78)
select v74 as v74, v78, v75, v73, v77, v76 from aggJoin6165039259429938337 join aggView4475710069418932168 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin498576514049160243;
