create or replace view aggView9076776075957016087 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggView674287908625441562 as select id as v1, name as v2 from company_name as cn1 where country_code= '[nl]';
create or replace view aggJoin5449861805402271935 as (
with aggView9157761539686577564 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView9157761539686577564 where mi_idx1.info_type_id=aggView9157761539686577564.v15);
create or replace view aggView4570818263018770089 as select v49, v38 from aggJoin5449861805402271935 group by v49,v38;
create or replace view aggJoin6969575742200646461 as (
with aggView6003685889160404716 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView6003685889160404716 where mi_idx2.info_type_id=aggView6003685889160404716.v17 and info<'3.0');
create or replace view aggView7956138688897997464 as select v61, v43 from aggJoin6969575742200646461 group by v61,v43;
create or replace view aggJoin8328793737717197033 as (
with aggView9061779913692241732 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView9061779913692241732 where t2.kind_id=aggView9061779913692241732.v21 and production_year= 2007);
create or replace view aggView6006579207271905215 as select v62, v61 from aggJoin8328793737717197033 group by v62,v61;
create or replace view aggJoin6650255394742425871 as (
with aggView2205043506658624977 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView2205043506658624977 where t1.kind_id=aggView2205043506658624977.v19);
create or replace view aggView3116993836574130665 as select v50, v49 from aggJoin6650255394742425871 group by v50,v49;
create or replace view aggJoin2541329307042840184 as (
with aggView7684998956711570358 as (select v49, MIN(v38) as v75 from aggView4570818263018770089 group by v49)
select v50, v49, v75 from aggView3116993836574130665 join aggView7684998956711570358 using(v49));
create or replace view aggJoin8304420424558492306 as (
with aggView7240637008698561783 as (select v1, MIN(v2) as v73 from aggView674287908625441562 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView7240637008698561783 where mc1.company_id=aggView7240637008698561783.v1);
create or replace view aggJoin2257836111104810575 as (
with aggView1681163961276015983 as (select v61, MIN(v43) as v76 from aggView7956138688897997464 group by v61)
select v62, v61, v76 from aggView6006579207271905215 join aggView1681163961276015983 using(v61));
create or replace view aggJoin7790487017670970200 as (
with aggView7627023692930802768 as (select v61, MIN(v76) as v76, MIN(v62) as v78 from aggJoin2257836111104810575 group by v61,v76)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v76, v78 from movie_link as ml, aggView7627023692930802768 where ml.linked_movie_id=aggView7627023692930802768.v61);
create or replace view aggJoin8261679319710451194 as (
with aggView2258610035553514463 as (select v49, MIN(v73) as v73 from aggJoin8304420424558492306 group by v49,v73)
select v50, v49, v75 as v75, v73 from aggJoin2541329307042840184 join aggView2258610035553514463 using(v49));
create or replace view aggJoin7284150011731196103 as (
with aggView1940300275493233756 as (select v49, MIN(v75) as v75, MIN(v73) as v73, MIN(v50) as v77 from aggJoin8261679319710451194 group by v49,v73,v75)
select v61, v23, v76 as v76, v78 as v78, v75, v73, v77 from aggJoin7790487017670970200 join aggView1940300275493233756 using(v49));
create or replace view aggJoin4041989829776291551 as (
with aggView4066324645005461178 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select v61, v76, v78, v75, v73, v77 from aggJoin7284150011731196103 join aggView4066324645005461178 using(v23));
create or replace view aggJoin4680904569448204511 as (
with aggView5684004045494402441 as (select v61, MIN(v76) as v76, MIN(v78) as v78, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77 from aggJoin4041989829776291551 group by v61,v78,v75,v76,v73,v77)
select company_id as v8, v76, v78, v75, v73, v77 from movie_companies as mc2, aggView5684004045494402441 where mc2.movie_id=aggView5684004045494402441.v61);
create or replace view aggJoin4098062279597878691 as (
with aggView858458468002833121 as (select v8, MIN(v76) as v76, MIN(v78) as v78, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77 from aggJoin4680904569448204511 group by v8,v78,v75,v76,v73,v77)
select v9, v76, v78, v75, v73, v77 from aggView9076776075957016087 join aggView858458468002833121 using(v8));
select MIN(v73) as v73,MIN(v9) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin4098062279597878691;
