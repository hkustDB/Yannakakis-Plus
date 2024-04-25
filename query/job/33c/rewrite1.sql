create or replace view aggView9127641036044059295 as select id as v1, name as v2 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView550047250188675987 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggJoin7437898496464242832 as (
with aggView3804332538882590953 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView3804332538882590953 where mi_idx1.info_type_id=aggView3804332538882590953.v15);
create or replace view aggView935852497113126849 as select v49, v38 from aggJoin7437898496464242832 group by v49,v38;
create or replace view aggJoin6828663310466278441 as (
with aggView7513877236624889854 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView7513877236624889854 where t2.kind_id=aggView7513877236624889854.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView2352306815173540616 as select v62, v61 from aggJoin6828663310466278441 group by v62,v61;
create or replace view aggJoin3157682278916432709 as (
with aggView7403497162215173462 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView7403497162215173462 where t1.kind_id=aggView7403497162215173462.v19);
create or replace view aggView3512259347818127587 as select v50, v49 from aggJoin3157682278916432709 group by v50,v49;
create or replace view aggJoin6055057677899883351 as (
with aggView870863903169949049 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView870863903169949049 where mi_idx2.info_type_id=aggView870863903169949049.v17);
create or replace view aggJoin3909552315003496927 as (
with aggView3102948508018232535 as (select v61, v43 from aggJoin6055057677899883351 group by v61,v43)
select v61, v43 from aggView3102948508018232535 where v43<'3.5');
create or replace view aggJoin6180857269485633077 as (
with aggView3987877656551982632 as (select v8, MIN(v9) as v74 from aggView550047250188675987 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView3987877656551982632 where mc2.company_id=aggView3987877656551982632.v8);
create or replace view aggJoin1348274535934866380 as (
with aggView8440838557463018104 as (select v61, MIN(v43) as v76 from aggJoin3909552315003496927 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v76 from movie_link as ml, aggView8440838557463018104 where ml.linked_movie_id=aggView8440838557463018104.v61);
create or replace view aggJoin556138387658583906 as (
with aggView8700252988705338853 as (select v49, MIN(v50) as v77 from aggView3512259347818127587 group by v49)
select v49, v38, v77 from aggView935852497113126849 join aggView8700252988705338853 using(v49));
create or replace view aggJoin3704782301681579374 as (
with aggView1827350250559474892 as (select v61, MIN(v74) as v74 from aggJoin6180857269485633077 group by v61)
select v62, v61, v74 from aggView2352306815173540616 join aggView1827350250559474892 using(v61));
create or replace view aggJoin6201313164792439107 as (
with aggView2561951375917315577 as (select v61, MIN(v74) as v74, MIN(v62) as v78 from aggJoin3704782301681579374 group by v61)
select v49, v23, v76 as v76, v74, v78 from aggJoin1348274535934866380 join aggView2561951375917315577 using(v61));
create or replace view aggJoin4084115267551975237 as (
with aggView8852035676198410653 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v76, v74, v78 from aggJoin6201313164792439107 join aggView8852035676198410653 using(v23));
create or replace view aggJoin4244346334626497758 as (
with aggView2445887857814716431 as (select v49, MIN(v76) as v76, MIN(v74) as v74, MIN(v78) as v78 from aggJoin4084115267551975237 group by v49)
select v49, v38, v77 as v77, v76, v74, v78 from aggJoin556138387658583906 join aggView2445887857814716431 using(v49));
create or replace view aggJoin2745780545783977706 as (
with aggView3817909849806678501 as (select v49, MIN(v77) as v77, MIN(v76) as v76, MIN(v74) as v74, MIN(v78) as v78, MIN(v38) as v75 from aggJoin4244346334626497758 group by v49)
select company_id as v1, v77, v76, v74, v78, v75 from movie_companies as mc1, aggView3817909849806678501 where mc1.movie_id=aggView3817909849806678501.v49);
create or replace view aggJoin7060678264333787345 as (
with aggView6005146436722976896 as (select v1, MIN(v77) as v77, MIN(v76) as v76, MIN(v74) as v74, MIN(v78) as v78, MIN(v75) as v75 from aggJoin2745780545783977706 group by v1)
select v2, v77, v76, v74, v78, v75 from aggView9127641036044059295 join aggView6005146436722976896 using(v1));
select MIN(v2) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin7060678264333787345;
