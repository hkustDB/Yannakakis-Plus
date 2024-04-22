create or replace view aggJoin8344174502634324312 as (
with aggView6829694227070006805 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView6829694227070006805 where ci.person_role_id=aggView6829694227070006805.v9);
create or replace view aggJoin1933177852998314418 as (
with aggView8593727116630251778 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView8593727116630251778 where t.kind_id=aggView8593727116630251778.v28 and production_year>2005);
create or replace view aggJoin4782259095764283570 as (
with aggView1465989863161540846 as (select v47, MIN(v48) as v61 from aggJoin1933177852998314418 group by v47)
select movie_id as v47, info_type_id as v23, info as v33, v61 from movie_info_idx as mi_idx, aggView1465989863161540846 where mi_idx.movie_id=aggView1465989863161540846.v47 and info>'8.0');
create or replace view aggJoin6711069537703080290 as (
with aggView386521333492369368 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView386521333492369368 where mk.keyword_id=aggView386521333492369368.v25);
create or replace view aggJoin8321873083388109675 as (
with aggView4439918191953686462 as (select id as v23 from info_type as it2 where info= 'rating')
select v47, v33, v61 from aggJoin4782259095764283570 join aggView4439918191953686462 using(v23));
create or replace view aggJoin2596665817191346915 as (
with aggView5573977037599795590 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView5573977037599795590 where cc.status_id=aggView5573977037599795590.v7);
create or replace view aggJoin4075256587079220134 as (
with aggView8605509174997451841 as (select v47 from aggJoin6711069537703080290 group by v47)
select v47, v33, v61 as v61 from aggJoin8321873083388109675 join aggView8605509174997451841 using(v47));
create or replace view aggJoin239701628795261615 as (
with aggView8133386641139263649 as (select v47, MIN(v61) as v61, MIN(v33) as v60 from aggJoin4075256587079220134 group by v47,v61)
select v47, v5, v61, v60 from aggJoin2596665817191346915 join aggView8133386641139263649 using(v47));
create or replace view aggJoin8430146830857069288 as (
with aggView3430532412876406233 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47, v61, v60 from aggJoin239701628795261615 join aggView3430532412876406233 using(v5));
create or replace view aggJoin1036979249470907334 as (
with aggView8026529727034705795 as (select v47, MIN(v61) as v61, MIN(v60) as v60 from aggJoin8430146830857069288 group by v47,v61,v60)
select v38, v59 as v59, v61, v60 from aggJoin8344174502634324312 join aggView8026529727034705795 using(v47));
create or replace view aggJoin8931125538523809113 as (
with aggView2877240345546722022 as (select id as v38 from name as n)
select v59, v61, v60 from aggJoin1036979249470907334 join aggView2877240345546722022 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin8931125538523809113;
