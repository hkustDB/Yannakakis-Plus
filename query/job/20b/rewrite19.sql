create or replace view aggJoin1904734703952720586 as (
with aggView8925770746328459765 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView8925770746328459765 where t.kind_id=aggView8925770746328459765.v26 and production_year>2000);
create or replace view aggJoin7676254673050536216 as (
with aggView1594137588698167161 as (select v40, MIN(v41) as v52 from aggJoin1904734703952720586 group by v40)
select movie_id as v40, keyword_id as v23, v52 from movie_keyword as mk, aggView1594137588698167161 where mk.movie_id=aggView1594137588698167161.v40);
create or replace view aggJoin6979656386671106155 as (
with aggView3105656728807223578 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView3105656728807223578 where ci.person_role_id=aggView3105656728807223578.v9);
create or replace view aggJoin2605230554806289499 as (
with aggView5482382755396344862 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin6979656386671106155 join aggView5482382755396344862 using(v31));
create or replace view aggJoin6276132831119117085 as (
with aggView1578144236086440036 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView1578144236086440036 where cc.status_id=aggView1578144236086440036.v7);
create or replace view aggJoin3490949975217352300 as (
with aggView7722008736564232148 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin6276132831119117085 join aggView7722008736564232148 using(v5));
create or replace view aggJoin4545689427631199766 as (
with aggView249271694454769683 as (select v40 from aggJoin3490949975217352300 group by v40)
select v40 from aggJoin2605230554806289499 join aggView249271694454769683 using(v40));
create or replace view aggJoin1435198611303831178 as (
with aggView8257345260693559213 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40, v52 from aggJoin7676254673050536216 join aggView8257345260693559213 using(v23));
create or replace view aggJoin6774694519700977210 as (
with aggView4249675804711456595 as (select v40, MIN(v52) as v52 from aggJoin1435198611303831178 group by v40,v52)
select v52 from aggJoin4545689427631199766 join aggView4249675804711456595 using(v40));
select MIN(v52) as v52 from aggJoin6774694519700977210;
