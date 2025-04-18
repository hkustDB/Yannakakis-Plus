create or replace view aggView7657960648944899324 as select id as v15 from info_type as it1 where info= 'rating';
create or replace view aggJoin7458845569889078482 as select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView7657960648944899324 where mi_idx1.info_type_id=aggView7657960648944899324.v15;
create or replace view aggView4533936092321290125 as select v49, MIN(v38) as v75 from aggJoin7458845569889078482 group by v49;
create or replace view aggJoin3151847585504423524 as select id as v49, title as v50, kind_id as v19, v75 from title as t1, aggView4533936092321290125 where t1.id=aggView4533936092321290125.v49;
create or replace view aggView1280502476728967841 as select id as v21 from kind_type as kt2 where kind= 'tv series';
create or replace view aggJoin3078061173258979500 as select id as v61, title as v62, production_year as v65 from title as t2, aggView1280502476728967841 where t2.kind_id=aggView1280502476728967841.v21 and production_year<=2008 and production_year>=2005;
create or replace view aggView3256611544218306017 as select v49, v19, MIN(v75) as v75, MIN(v50) as v77 from aggJoin3151847585504423524 group by v49,v19;
create or replace view aggJoin7308792996386985183 as select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v19, v75, v77 from movie_link as ml, aggView3256611544218306017 where ml.movie_id=aggView3256611544218306017.v49;
create or replace view aggView5578966895200556311 as select v61, MIN(v62) as v78 from aggJoin3078061173258979500 group by v61;
create or replace view aggJoin213381112851684814 as select v49, v61, v23, v19, v75 as v75, v77 as v77, v78 from aggJoin7308792996386985183 join aggView5578966895200556311 using(v61);
create or replace view aggView107167257683325794 as select id as v17 from info_type as it2 where info= 'rating';
create or replace view aggJoin1715378577487569944 as select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView107167257683325794 where mi_idx2.info_type_id=aggView107167257683325794.v17 and info<'3.0';
create or replace view aggView1220686623083053565 as select id as v23 from link_type as lt where link IN ('sequel','follows','followed by');
create or replace view aggJoin8064630705906828957 as select v49, v61, v19, v75, v77, v78 from aggJoin213381112851684814 join aggView1220686623083053565 using(v23);
create or replace view aggView6553701231192784487 as select v61, v19, v49, MIN(v75) as v75, MIN(v77) as v77, MIN(v78) as v78 from aggJoin8064630705906828957 group by v61,v19,v49;
create or replace view aggJoin1738897326086020290 as select v61, v43, v19, v49, v75, v77, v78 from aggJoin1715378577487569944 join aggView6553701231192784487 using(v61);
create or replace view aggView8941778968054378606 as select v49, v19, v61, MIN(v75) as v75, MIN(v77) as v77, MIN(v78) as v78, MIN(v43) as v76 from aggJoin1738897326086020290 group by v49,v19,v61;
create or replace view aggJoin3512866010120619486 as select movie_id as v49, company_id as v1, v19, v61, v75, v77, v78, v76 from movie_companies as mc1, aggView8941778968054378606 where mc1.movie_id=aggView8941778968054378606.v49;
create or replace view aggView1340577177941784892 as select v1, v19, v61, MIN(v75) as v75, MIN(v77) as v77, MIN(v78) as v78, MIN(v76) as v76 from aggJoin3512866010120619486 group by v1,v19,v61;
create or replace view aggJoin8510821109590006410 as select name as v2, country_code as v3, v19, v61, v75, v77, v78, v76 from company_name as cn1, aggView1340577177941784892 where cn1.id=aggView1340577177941784892.v1 and country_code= '[us]';
create or replace view aggView6942414726459901559 as select v61, v19, MIN(v75) as v75, MIN(v77) as v77, MIN(v78) as v78, MIN(v76) as v76, MIN(v2) as v73 from aggJoin8510821109590006410 group by v61,v19;
create or replace view aggJoin1530783669601742878 as select movie_id as v61, company_id as v8, v19, v75, v77, v78, v76, v73 from movie_companies as mc2, aggView6942414726459901559 where mc2.movie_id=aggView6942414726459901559.v61;
create or replace view aggView1475664727275270717 as select v8, v19, MIN(v75) as v75, MIN(v77) as v77, MIN(v78) as v78, MIN(v76) as v76, MIN(v73) as v73 from aggJoin1530783669601742878 group by v8,v19;
create or replace view aggJoin8178087163242489758 as select name as v9, v19, v75, v77, v78, v76, v73 from company_name as cn2, aggView1475664727275270717 where cn2.id=aggView1475664727275270717.v8;
create or replace view aggView1406497598761042468 as select v19, MIN(v75) as v75, MIN(v77) as v77, MIN(v78) as v78, MIN(v76) as v76, MIN(v73) as v73, MIN(v9) as v74 from aggJoin8178087163242489758 group by v19;
create or replace view aggJoin8548734418403243745 as select id as v19, kind as v20, v75, v77, v78, v76, v73, v74 from kind_type as kt1, aggView1406497598761042468 where kt1.id=aggView1406497598761042468.v19 and kind= 'tv series';
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin8548734418403243745;
