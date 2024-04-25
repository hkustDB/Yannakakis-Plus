create or replace view aggView7241831579837504650 as select id as v1, name as v2 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView145671041748593874 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggJoin5607326843414363806 as (
with aggView2032196602896438566 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView2032196602896438566 where mi_idx1.info_type_id=aggView2032196602896438566.v15);
create or replace view aggView6971127932802942773 as select v49, v38 from aggJoin5607326843414363806 group by v49,v38;
create or replace view aggJoin7912916358293070707 as (
with aggView6908873864404217855 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView6908873864404217855 where t1.kind_id=aggView6908873864404217855.v19);
create or replace view aggView4423101587074966734 as select v50, v49 from aggJoin7912916358293070707 group by v50,v49;
create or replace view aggJoin4888431560821876763 as (
with aggView2123811185754319297 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView2123811185754319297 where t2.kind_id=aggView2123811185754319297.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView8231006609709027179 as select v62, v61 from aggJoin4888431560821876763 group by v62,v61;
create or replace view aggJoin8724625135373317765 as (
with aggView5039296021457255651 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView5039296021457255651 where mi_idx2.info_type_id=aggView5039296021457255651.v17);
create or replace view aggJoin332172534455800546 as (
with aggView3705421672327074193 as (select v61, v43 from aggJoin8724625135373317765 group by v61,v43)
select v61, v43 from aggView3705421672327074193 where v43<'3.5');
create or replace view aggJoin8526643478046796722 as (
with aggView1929314792529481921 as (select v8, MIN(v9) as v74 from aggView145671041748593874 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView1929314792529481921 where mc2.company_id=aggView1929314792529481921.v8);
create or replace view aggJoin6034748100174201356 as (
with aggView1491237780369736933 as (select v49, MIN(v50) as v77 from aggView4423101587074966734 group by v49)
select movie_id as v49, company_id as v1, v77 from movie_companies as mc1, aggView1491237780369736933 where mc1.movie_id=aggView1491237780369736933.v49);
create or replace view aggJoin1831516834894565345 as (
with aggView6248709773406941176 as (select v1, MIN(v2) as v73 from aggView7241831579837504650 group by v1)
select v49, v77 as v77, v73 from aggJoin6034748100174201356 join aggView6248709773406941176 using(v1));
create or replace view aggJoin2916279220352814304 as (
with aggView2779256168592748284 as (select v49, MIN(v38) as v75 from aggView6971127932802942773 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v75 from movie_link as ml, aggView2779256168592748284 where ml.movie_id=aggView2779256168592748284.v49);
create or replace view aggJoin740544884791751599 as (
with aggView4239857148855442215 as (select v49, MIN(v77) as v77, MIN(v73) as v73 from aggJoin1831516834894565345 group by v49)
select v61, v23, v75 as v75, v77, v73 from aggJoin2916279220352814304 join aggView4239857148855442215 using(v49));
create or replace view aggJoin7527651135404945485 as (
with aggView4168542735502695474 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v75, v77, v73 from aggJoin740544884791751599 join aggView4168542735502695474 using(v23));
create or replace view aggJoin6142932450677758318 as (
with aggView8953463354405680452 as (select v61, MIN(v75) as v75, MIN(v77) as v77, MIN(v73) as v73 from aggJoin7527651135404945485 group by v61)
select v61, v43, v75, v77, v73 from aggJoin332172534455800546 join aggView8953463354405680452 using(v61));
create or replace view aggJoin3496649325303963699 as (
with aggView8578321959969753262 as (select v61, MIN(v75) as v75, MIN(v77) as v77, MIN(v73) as v73, MIN(v43) as v76 from aggJoin6142932450677758318 group by v61)
select v61, v74 as v74, v75, v77, v73, v76 from aggJoin8526643478046796722 join aggView8578321959969753262 using(v61));
create or replace view aggJoin490769839866866678 as (
with aggView9175116815831455392 as (select v61, MIN(v74) as v74, MIN(v75) as v75, MIN(v77) as v77, MIN(v73) as v73, MIN(v76) as v76 from aggJoin3496649325303963699 group by v61)
select v62, v74, v75, v77, v73, v76 from aggView8231006609709027179 join aggView9175116815831455392 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v62) as v78 from aggJoin490769839866866678;
