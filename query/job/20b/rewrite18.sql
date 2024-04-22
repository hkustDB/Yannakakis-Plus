create or replace view aggJoin1357314529399629911 as (
with aggView1684183391000246257 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView1684183391000246257 where t.kind_id=aggView1684183391000246257.v26 and production_year>2000);
create or replace view aggJoin5207825755151683350 as (
with aggView4188742416614328475 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView4188742416614328475 where ci.person_role_id=aggView4188742416614328475.v9);
create or replace view aggJoin261891427732230762 as (
with aggView3443363801871251718 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin5207825755151683350 join aggView3443363801871251718 using(v31));
create or replace view aggJoin8278648441437006128 as (
with aggView5276097388202401236 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView5276097388202401236 where cc.status_id=aggView5276097388202401236.v7);
create or replace view aggJoin6711717476390150228 as (
with aggView6409453274955337760 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin8278648441437006128 join aggView6409453274955337760 using(v5));
create or replace view aggJoin643915752849331677 as (
with aggView1729721623673183444 as (select v40 from aggJoin6711717476390150228 group by v40)
select v40, v41, v44 from aggJoin1357314529399629911 join aggView1729721623673183444 using(v40));
create or replace view aggJoin3850294199355040669 as (
with aggView7334235819048645896 as (select v40, MIN(v41) as v52 from aggJoin643915752849331677 group by v40)
select v40, v52 from aggJoin261891427732230762 join aggView7334235819048645896 using(v40));
create or replace view aggJoin5366169224547721360 as (
with aggView7920178760942363161 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView7920178760942363161 where mk.keyword_id=aggView7920178760942363161.v23);
create or replace view aggJoin26440486826406888 as (
with aggView833812251939788140 as (select v40 from aggJoin5366169224547721360 group by v40)
select v52 as v52 from aggJoin3850294199355040669 join aggView833812251939788140 using(v40));
select MIN(v52) as v52 from aggJoin26440486826406888;
