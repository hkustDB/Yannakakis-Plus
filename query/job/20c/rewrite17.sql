create or replace view aggJoin7385222095560439354 as (
with aggView6164386168555167739 as (select id as v31, name as v52 from name as n)
select movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView6164386168555167739 where ci.person_id=aggView6164386168555167739.v31);
create or replace view aggJoin3169687704041433009 as (
with aggView5227971017760629328 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v40, v52 from aggJoin7385222095560439354 join aggView5227971017760629328 using(v9));
create or replace view aggJoin7475105234651791046 as (
with aggView4140294267496138269 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView4140294267496138269 where t.kind_id=aggView4140294267496138269.v26 and production_year>2000);
create or replace view aggJoin5099961458307886082 as (
with aggView840534509054897472 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView840534509054897472 where cc.status_id=aggView840534509054897472.v7);
create or replace view aggJoin5110478997002225743 as (
with aggView4775323618944629862 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView4775323618944629862 where mk.keyword_id=aggView4775323618944629862.v23);
create or replace view aggJoin4111102254833084762 as (
with aggView856588850051733350 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin5099961458307886082 join aggView856588850051733350 using(v5));
create or replace view aggJoin4309994338032761181 as (
with aggView2995783055478216302 as (select v40 from aggJoin4111102254833084762 group by v40)
select v40, v41, v44 from aggJoin7475105234651791046 join aggView2995783055478216302 using(v40));
create or replace view aggJoin1433568733043216700 as (
with aggView5954979453915565072 as (select v40, MIN(v41) as v53 from aggJoin4309994338032761181 group by v40)
select v40, v53 from aggJoin5110478997002225743 join aggView5954979453915565072 using(v40));
create or replace view aggJoin7613471264177090452 as (
with aggView1588866175591285648 as (select v40, MIN(v53) as v53 from aggJoin1433568733043216700 group by v40,v53)
select v52 as v52, v53 from aggJoin3169687704041433009 join aggView1588866175591285648 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin7613471264177090452;
