create or replace view aggView2467164479849956922 as select name as v10, id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin2363920633029593662 as (
with aggView448343012271898441 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView448343012271898441 where cc.status_id=aggView448343012271898441.v7);
create or replace view aggJoin7168316349193893403 as (
with aggView2007756318151629276 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin2363920633029593662 join aggView2007756318151629276 using(v5));
create or replace view aggJoin8225835560517956630 as (
with aggView840330547358309213 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView840330547358309213 where mi_idx.info_type_id=aggView840330547358309213.v23);
create or replace view aggJoin7597134244980241595 as (
with aggView4823996478356235344 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView4823996478356235344 where t.kind_id=aggView4823996478356235344.v28 and production_year>2000);
create or replace view aggJoin5268301977110618716 as (
with aggView5463444444750358922 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView5463444444750358922 where mk.keyword_id=aggView5463444444750358922.v25);
create or replace view aggJoin13249283118937177 as (
with aggView761270895847761271 as (select v47 from aggJoin5268301977110618716 group by v47)
select v47, v33 from aggJoin8225835560517956630 join aggView761270895847761271 using(v47));
create or replace view aggView5348862007228445107 as select v33, v47 from aggJoin13249283118937177 group by v33,v47;
create or replace view aggJoin5877896773874506210 as (
with aggView5011777418244856989 as (select v47 from aggJoin7168316349193893403 group by v47)
select v47, v48, v51 from aggJoin7597134244980241595 join aggView5011777418244856989 using(v47));
create or replace view aggView1457888937076502705 as select v48, v47 from aggJoin5877896773874506210 group by v48,v47;
create or replace view aggJoin8165131459992788536 as (
with aggView2201117442674100306 as (select v47, MIN(v33) as v60 from aggView5348862007228445107 group by v47)
select v48, v47, v60 from aggView1457888937076502705 join aggView2201117442674100306 using(v47));
create or replace view aggJoin3852469027598018478 as (
with aggView5288350977587442430 as (select v47, MIN(v60) as v60, MIN(v48) as v61 from aggJoin8165131459992788536 group by v47,v60)
select person_id as v38, person_role_id as v9, v60, v61 from cast_info as ci, aggView5288350977587442430 where ci.movie_id=aggView5288350977587442430.v47);
create or replace view aggJoin464455754086090175 as (
with aggView7949828936478133254 as (select id as v38 from name as n)
select v9, v60, v61 from aggJoin3852469027598018478 join aggView7949828936478133254 using(v38));
create or replace view aggJoin7007822693543948192 as (
with aggView6073885556506261814 as (select v9, MIN(v60) as v60, MIN(v61) as v61 from aggJoin464455754086090175 group by v9,v61,v60)
select v10, v60, v61 from aggView2467164479849956922 join aggView6073885556506261814 using(v9));
select MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin7007822693543948192;
