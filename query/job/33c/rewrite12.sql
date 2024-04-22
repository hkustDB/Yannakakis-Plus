create or replace view aggJoin6792897246730223066 as (
with aggView6204179022604768965 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView6204179022604768965 where mc2.company_id=aggView6204179022604768965.v8);
create or replace view aggJoin5293531144383881981 as (
with aggView8128251438518396706 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView8128251438518396706 where mc1.company_id=aggView8128251438518396706.v1);
create or replace view aggJoin8566366755806786026 as (
with aggView6410247994030992396 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView6410247994030992396 where mi_idx2.info_type_id=aggView6410247994030992396.v17 and info<'3.5');
create or replace view aggJoin130682106653149218 as (
with aggView9056513350129410142 as (select v61, MIN(v43) as v76 from aggJoin8566366755806786026 group by v61)
select id as v61, title as v62, kind_id as v21, production_year as v65, v76 from title as t2, aggView9056513350129410142 where t2.id=aggView9056513350129410142.v61 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin8448611262860477206 as (
with aggView1919311335274506039 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select v61, v62, v65, v76 from aggJoin130682106653149218 join aggView1919311335274506039 using(v21));
create or replace view aggJoin7055864256305461961 as (
with aggView3176851407774561102 as (select v61, MIN(v76) as v76, MIN(v62) as v78 from aggJoin8448611262860477206 group by v61,v76)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v76, v78 from movie_link as ml, aggView3176851407774561102 where ml.linked_movie_id=aggView3176851407774561102.v61);
create or replace view aggJoin7716280402414906264 as (
with aggView6787822233975094833 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView6787822233975094833 where t1.kind_id=aggView6787822233975094833.v19);
create or replace view aggJoin1583144511337968079 as (
with aggView4697143503156039382 as (select v49, MIN(v50) as v77 from aggJoin7716280402414906264 group by v49)
select movie_id as v49, info_type_id as v15, info as v38, v77 from movie_info_idx as mi_idx1, aggView4697143503156039382 where mi_idx1.movie_id=aggView4697143503156039382.v49);
create or replace view aggJoin6495602610449519306 as (
with aggView6101232480528348268 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v76, v78 from aggJoin7055864256305461961 join aggView6101232480528348268 using(v23));
create or replace view aggJoin7819907036927662822 as (
with aggView3884298640458047691 as (select id as v15 from info_type as it1 where info= 'rating')
select v49, v38, v77 from aggJoin1583144511337968079 join aggView3884298640458047691 using(v15));
create or replace view aggJoin19089427990829009 as (
with aggView2733439580524358460 as (select v49, MIN(v77) as v77, MIN(v38) as v75 from aggJoin7819907036927662822 group by v49,v77)
select v49, v73 as v73, v77, v75 from aggJoin5293531144383881981 join aggView2733439580524358460 using(v49));
create or replace view aggJoin5382544797654599101 as (
with aggView6110489173038733479 as (select v61, MIN(v74) as v74 from aggJoin6792897246730223066 group by v61,v74)
select v49, v76 as v76, v78 as v78, v74 from aggJoin6495602610449519306 join aggView6110489173038733479 using(v61));
create or replace view aggJoin7079239348408475308 as (
with aggView4425906427030132143 as (select v49, MIN(v76) as v76, MIN(v78) as v78, MIN(v74) as v74 from aggJoin5382544797654599101 group by v49,v74,v76,v78)
select v73 as v73, v77 as v77, v75 as v75, v76, v78, v74 from aggJoin19089427990829009 join aggView4425906427030132143 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin7079239348408475308;
