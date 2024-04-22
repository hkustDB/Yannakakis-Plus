create or replace view aggJoin7696418182963204447 as (
with aggView1268963769286410520 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView1268963769286410520 where cc.subject_id=aggView1268963769286410520.v5);
create or replace view aggJoin6427222752151443230 as (
with aggView3585506680009392890 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView3585506680009392890 where ci.person_id=aggView3585506680009392890.v31);
create or replace view aggJoin65568401085150211 as (
with aggView3628164515675273094 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin7696418182963204447 join aggView3628164515675273094 using(v7));
create or replace view aggJoin5853225297991170230 as (
with aggView1349456414018970741 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView1349456414018970741 where t.kind_id=aggView1349456414018970741.v26 and production_year>1950);
create or replace view aggJoin2289026165180333859 as (
with aggView8164312001864783776 as (select v40 from aggJoin65568401085150211 group by v40)
select movie_id as v40, keyword_id as v23 from movie_keyword as mk, aggView8164312001864783776 where mk.movie_id=aggView8164312001864783776.v40);
create or replace view aggJoin5185399275563420686 as (
with aggView5857856865850331076 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin6427222752151443230 join aggView5857856865850331076 using(v9));
create or replace view aggJoin6698250771804500537 as (
with aggView206183594747566319 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40 from aggJoin2289026165180333859 join aggView206183594747566319 using(v23));
create or replace view aggJoin8853051224514586897 as (
with aggView5877893375484642697 as (select v40 from aggJoin6698250771804500537 group by v40)
select v40, v41, v44 from aggJoin5853225297991170230 join aggView5877893375484642697 using(v40));
create or replace view aggJoin4066981846920895399 as (
with aggView6879379835178614084 as (select v40, MIN(v41) as v52 from aggJoin8853051224514586897 group by v40)
select v52 from aggJoin5185399275563420686 join aggView6879379835178614084 using(v40));
select MIN(v52) as v52 from aggJoin4066981846920895399;
