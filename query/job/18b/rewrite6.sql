create or replace view aggView7095654297919842575 as select title as v32, id as v31 from title as t where production_year>=2008 and production_year<=2014;
create or replace view aggJoin3574232739710250298 as (
with aggView2671424416226970146 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView2671424416226970146 where ci.person_id=aggView2671424416226970146.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8124696990131027518 as (
with aggView6962544527810297138 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView6962544527810297138 where mi.info_type_id=aggView6962544527810297138.v8 and info IN ('Horror','Thriller'));
create or replace view aggJoin629699504433045983 as (
with aggView7722022359666791431 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView7722022359666791431 where mi_idx.info_type_id=aggView7722022359666791431.v10);
create or replace view aggJoin1843851255729444528 as (
with aggView2689956807130301673 as (select v31, v20 from aggJoin629699504433045983 group by v31,v20)
select v31, v20 from aggView2689956807130301673 where v20>'8.0');
create or replace view aggJoin5622623406315207072 as (
with aggView561359443144423499 as (select v31 from aggJoin3574232739710250298 group by v31)
select v31, v15 from aggJoin8124696990131027518 join aggView561359443144423499 using(v31));
create or replace view aggView7846327795319683606 as select v15, v31 from aggJoin5622623406315207072 group by v15,v31;
create or replace view aggJoin4951857740993474083 as (
with aggView7667361372851621160 as (select v31, MIN(v32) as v45 from aggView7095654297919842575 group by v31)
select v15, v31, v45 from aggView7846327795319683606 join aggView7667361372851621160 using(v31));
create or replace view aggJoin1872144458723185567 as (
with aggView5569234448044984731 as (select v31, MIN(v45) as v45, MIN(v15) as v43 from aggJoin4951857740993474083 group by v31,v45)
select v20, v45, v43 from aggJoin1843851255729444528 join aggView5569234448044984731 using(v31));
select MIN(v43) as v43,MIN(v20) as v44,MIN(v45) as v45 from aggJoin1872144458723185567;
