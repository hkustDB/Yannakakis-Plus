create or replace view aggView3562107066321943128 as select id as v1, name as v2 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView467753779545607454 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggJoin2741874628007044526 as (
with aggView6094598003296062543 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView6094598003296062543 where mi_idx1.info_type_id=aggView6094598003296062543.v15);
create or replace view aggView6511214335023307980 as select v49, v38 from aggJoin2741874628007044526 group by v49,v38;
create or replace view aggJoin3593482429765414489 as (
with aggView7810763784251301985 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView7810763784251301985 where t1.kind_id=aggView7810763784251301985.v19);
create or replace view aggView825943735577264270 as select v50, v49 from aggJoin3593482429765414489 group by v50,v49;
create or replace view aggJoin4198034985092934075 as (
with aggView6215775295695900900 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView6215775295695900900 where t2.kind_id=aggView6215775295695900900.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView5762262323532530904 as select v62, v61 from aggJoin4198034985092934075 group by v62,v61;
create or replace view aggJoin6856438983120393897 as (
with aggView4187848351406552924 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView4187848351406552924 where mi_idx2.info_type_id=aggView4187848351406552924.v17);
create or replace view aggJoin4945220694799878527 as (
with aggView1167008488801271000 as (select v61, v43 from aggJoin6856438983120393897 group by v61,v43)
select v61, v43 from aggView1167008488801271000 where v43<'3.5');
create or replace view aggJoin4748530174232111463 as (
with aggView266163687709997894 as (select v8, MIN(v9) as v74 from aggView467753779545607454 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView266163687709997894 where mc2.company_id=aggView266163687709997894.v8);
create or replace view aggJoin7410324396321585359 as (
with aggView1203180821274652321 as (select v61, MIN(v43) as v76 from aggJoin4945220694799878527 group by v61)
select v62, v61, v76 from aggView5762262323532530904 join aggView1203180821274652321 using(v61));
create or replace view aggJoin7986402259669935173 as (
with aggView8406537084679572901 as (select v1, MIN(v2) as v73 from aggView3562107066321943128 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView8406537084679572901 where mc1.company_id=aggView8406537084679572901.v1);
create or replace view aggJoin7476864325083528067 as (
with aggView609093820311334201 as (select v49, MIN(v73) as v73 from aggJoin7986402259669935173 group by v49)
select v49, v38, v73 from aggView6511214335023307980 join aggView609093820311334201 using(v49));
create or replace view aggJoin1835371812766497235 as (
with aggView8275462928288436840 as (select v49, MIN(v73) as v73, MIN(v38) as v75 from aggJoin7476864325083528067 group by v49)
select v50, v49, v73, v75 from aggView825943735577264270 join aggView8275462928288436840 using(v49));
create or replace view aggJoin2773409291429542946 as (
with aggView982774513387060592 as (select v49, MIN(v73) as v73, MIN(v75) as v75, MIN(v50) as v77 from aggJoin1835371812766497235 group by v49)
select linked_movie_id as v61, link_type_id as v23, v73, v75, v77 from movie_link as ml, aggView982774513387060592 where ml.movie_id=aggView982774513387060592.v49);
create or replace view aggJoin1204563017462426790 as (
with aggView4236004047602089530 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v73, v75, v77 from aggJoin2773409291429542946 join aggView4236004047602089530 using(v23));
create or replace view aggJoin7949372705898062233 as (
with aggView856452405133762206 as (select v61, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77 from aggJoin1204563017462426790 group by v61)
select v61, v74 as v74, v73, v75, v77 from aggJoin4748530174232111463 join aggView856452405133762206 using(v61));
create or replace view aggJoin1562633234399137140 as (
with aggView5581565070404902859 as (select v61, MIN(v74) as v74, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77 from aggJoin7949372705898062233 group by v61)
select v62, v76 as v76, v74, v73, v75, v77 from aggJoin7410324396321585359 join aggView5581565070404902859 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v62) as v78 from aggJoin1562633234399137140;
