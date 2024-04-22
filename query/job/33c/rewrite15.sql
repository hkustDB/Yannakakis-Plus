create or replace view aggJoin7996337155911118529 as (
with aggView4132088673853206572 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView4132088673853206572 where mc2.company_id=aggView4132088673853206572.v8);
create or replace view aggJoin1611050582468786646 as (
with aggView5931024849007526579 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView5931024849007526579 where mc1.company_id=aggView5931024849007526579.v1);
create or replace view aggJoin8870714106978182378 as (
with aggView5633117336649592784 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView5633117336649592784 where mi_idx2.info_type_id=aggView5633117336649592784.v17 and info<'3.5');
create or replace view aggJoin6303771459767617760 as (
with aggView9082179250240989286 as (select v61, MIN(v43) as v76 from aggJoin8870714106978182378 group by v61)
select v61, v74 as v74, v76 from aggJoin7996337155911118529 join aggView9082179250240989286 using(v61));
create or replace view aggJoin3427492008445321438 as (
with aggView8353313372076490703 as (select v49, MIN(v73) as v73 from aggJoin1611050582468786646 group by v49,v73)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v73 from movie_link as ml, aggView8353313372076490703 where ml.movie_id=aggView8353313372076490703.v49);
create or replace view aggJoin9049983890259555648 as (
with aggView9163725769423768037 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView9163725769423768037 where t2.kind_id=aggView9163725769423768037.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin390959307769369680 as (
with aggView3375857425425039030 as (select v61, MIN(v62) as v78 from aggJoin9049983890259555648 group by v61)
select v49, v61, v23, v73 as v73, v78 from aggJoin3427492008445321438 join aggView3375857425425039030 using(v61));
create or replace view aggJoin4216542458076297920 as (
with aggView3090122437664957349 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView3090122437664957349 where t1.kind_id=aggView3090122437664957349.v19);
create or replace view aggJoin5387227333192981959 as (
with aggView6564959820289652064 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v73, v78 from aggJoin390959307769369680 join aggView6564959820289652064 using(v23));
create or replace view aggJoin5241933473793160668 as (
with aggView2493750431281083636 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView2493750431281083636 where mi_idx1.info_type_id=aggView2493750431281083636.v15);
create or replace view aggJoin6300422452613634489 as (
with aggView6771896728109574699 as (select v49, MIN(v38) as v75 from aggJoin5241933473793160668 group by v49)
select v49, v50, v75 from aggJoin4216542458076297920 join aggView6771896728109574699 using(v49));
create or replace view aggJoin9219204655031816036 as (
with aggView2441700427937509974 as (select v49, MIN(v75) as v75, MIN(v50) as v77 from aggJoin6300422452613634489 group by v49,v75)
select v61, v73 as v73, v78 as v78, v75, v77 from aggJoin5387227333192981959 join aggView2441700427937509974 using(v49));
create or replace view aggJoin3953812136165711663 as (
with aggView7339103921749148867 as (select v61, MIN(v73) as v73, MIN(v78) as v78, MIN(v75) as v75, MIN(v77) as v77 from aggJoin9219204655031816036 group by v61,v77,v75,v73,v78)
select v74 as v74, v76 as v76, v73, v78, v75, v77 from aggJoin6303771459767617760 join aggView7339103921749148867 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin3953812136165711663;
