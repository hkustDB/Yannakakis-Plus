create or replace view aggView326555466756335534 as select name as v2, id as v1 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView2993380440690683553 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggJoin8447876388027960228 as (
with aggView3220358750789057382 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView3220358750789057382 where mi_idx2.info_type_id=aggView3220358750789057382.v17);
create or replace view aggJoin4563817141495135574 as (
with aggView8782584182322375129 as (select v61, v43 from aggJoin8447876388027960228 group by v61,v43)
select v61, v43 from aggView8782584182322375129 where v43<'3.5');
create or replace view aggJoin8784005173808242867 as (
with aggView3830853515521429160 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView3830853515521429160 where t1.kind_id=aggView3830853515521429160.v19);
create or replace view aggView1007079178178712457 as select v50, v49 from aggJoin8784005173808242867 group by v50,v49;
create or replace view aggJoin3988774204977586520 as (
with aggView1866025693118579560 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView1866025693118579560 where t2.kind_id=aggView1866025693118579560.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView6840432003272760771 as select v61, v62 from aggJoin3988774204977586520 group by v61,v62;
create or replace view aggJoin6606229959868359111 as (
with aggView8729069344818315143 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView8729069344818315143 where mi_idx1.info_type_id=aggView8729069344818315143.v15);
create or replace view aggView5858576430576252320 as select v38, v49 from aggJoin6606229959868359111 group by v38,v49;
create or replace view aggJoin6162953440833002493 as (
with aggView4081842137765864283 as (select v1, MIN(v2) as v73 from aggView326555466756335534 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView4081842137765864283 where mc1.company_id=aggView4081842137765864283.v1);
create or replace view aggJoin6655644995623282455 as (
with aggView5014428408327780461 as (select v49, MIN(v50) as v77 from aggView1007079178178712457 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v77 from movie_link as ml, aggView5014428408327780461 where ml.movie_id=aggView5014428408327780461.v49);
create or replace view aggJoin5288135465618878015 as (
with aggView4048695583538445856 as (select v61, MIN(v43) as v76 from aggJoin4563817141495135574 group by v61)
select movie_id as v61, company_id as v8, v76 from movie_companies as mc2, aggView4048695583538445856 where mc2.movie_id=aggView4048695583538445856.v61);
create or replace view aggJoin9196213959235472438 as (
with aggView4205038386659868482 as (select v49, MIN(v38) as v75 from aggView5858576430576252320 group by v49)
select v49, v73 as v73, v75 from aggJoin6162953440833002493 join aggView4205038386659868482 using(v49));
create or replace view aggJoin7438732114647705076 as (
with aggView8336389360805196310 as (select v49, MIN(v73) as v73, MIN(v75) as v75 from aggJoin9196213959235472438 group by v49,v75,v73)
select v61, v23, v77 as v77, v73, v75 from aggJoin6655644995623282455 join aggView8336389360805196310 using(v49));
create or replace view aggJoin6127989651966419149 as (
with aggView3503059059872351804 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v77, v73, v75 from aggJoin7438732114647705076 join aggView3503059059872351804 using(v23));
create or replace view aggJoin7807749959264515387 as (
with aggView7535296314983905347 as (select v61, MIN(v77) as v77, MIN(v73) as v73, MIN(v75) as v75 from aggJoin6127989651966419149 group by v61,v77,v75,v73)
select v61, v62, v77, v73, v75 from aggView6840432003272760771 join aggView7535296314983905347 using(v61));
create or replace view aggJoin1674388670416911652 as (
with aggView8399504606754126005 as (select v61, MIN(v77) as v77, MIN(v73) as v73, MIN(v75) as v75, MIN(v62) as v78 from aggJoin7807749959264515387 group by v61,v75,v77,v73)
select v8, v76 as v76, v77, v73, v75, v78 from aggJoin5288135465618878015 join aggView8399504606754126005 using(v61));
create or replace view aggJoin3756205358463173216 as (
with aggView3604051608073194656 as (select v8, MIN(v76) as v76, MIN(v77) as v77, MIN(v73) as v73, MIN(v75) as v75, MIN(v78) as v78 from aggJoin1674388670416911652 group by v8,v73,v75,v76,v77,v78)
select v9, v76, v77, v73, v75, v78 from aggView2993380440690683553 join aggView3604051608073194656 using(v8));
select MIN(v73) as v73,MIN(v9) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin3756205358463173216;
