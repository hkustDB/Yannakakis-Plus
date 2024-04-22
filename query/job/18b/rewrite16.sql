create or replace view aggJoin7924833851319870260 as (
with aggView3726308367316358429 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView3726308367316358429 where ci.person_id=aggView3726308367316358429.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin2618635974159537716 as (
with aggView8452636512787732707 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView8452636512787732707 where mi.info_type_id=aggView8452636512787732707.v8 and info IN ('Horror','Thriller'));
create or replace view aggView2195460135338669619 as select v15, v31 from aggJoin2618635974159537716 group by v15,v31;
create or replace view aggJoin2398034033896177202 as (
with aggView3890756217718937690 as (select v31 from aggJoin7924833851319870260 group by v31)
select id as v31, title as v32, production_year as v35 from title as t, aggView3890756217718937690 where t.id=aggView3890756217718937690.v31 and production_year>=2008 and production_year<=2014);
create or replace view aggView3231257323251796067 as select v32, v31 from aggJoin2398034033896177202 group by v32,v31;
create or replace view aggJoin7793603304756844404 as (
with aggView8046644976930050979 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView8046644976930050979 where mi_idx.info_type_id=aggView8046644976930050979.v10 and info>'8.0');
create or replace view aggView195179101132535844 as select v31, v20 from aggJoin7793603304756844404 group by v31,v20;
create or replace view aggJoin381859906339756597 as (
with aggView8698015691122144370 as (select v31, MIN(v15) as v43 from aggView2195460135338669619 group by v31)
select v31, v20, v43 from aggView195179101132535844 join aggView8698015691122144370 using(v31));
create or replace view aggJoin7472170735496727256 as (
with aggView3811679454333848092 as (select v31, MIN(v32) as v45 from aggView3231257323251796067 group by v31)
select v20, v43 as v43, v45 from aggJoin381859906339756597 join aggView3811679454333848092 using(v31));
select MIN(v43) as v43,MIN(v20) as v44,MIN(v45) as v45 from aggJoin7472170735496727256;
