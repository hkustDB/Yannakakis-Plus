create or replace view aggJoin1215413171256825464 as (
with aggView1889792265401667155 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView1889792265401667155 where t.kind_id=aggView1889792265401667155.v26 and production_year>2000);
create or replace view aggJoin381818873482955735 as (
with aggView2783305952681494866 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView2783305952681494866 where ci.person_role_id=aggView2783305952681494866.v9);
create or replace view aggJoin2236188942285807349 as (
with aggView178710902867943696 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin381818873482955735 join aggView178710902867943696 using(v31));
create or replace view aggJoin5953150850780327049 as (
with aggView7403999273900945110 as (select v40 from aggJoin2236188942285807349 group by v40)
select movie_id as v40, keyword_id as v23 from movie_keyword as mk, aggView7403999273900945110 where mk.movie_id=aggView7403999273900945110.v40);
create or replace view aggJoin1260077790902875519 as (
with aggView3551570929721241972 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView3551570929721241972 where cc.status_id=aggView3551570929721241972.v7);
create or replace view aggJoin7614438689845720593 as (
with aggView6145066383360521185 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin1260077790902875519 join aggView6145066383360521185 using(v5));
create or replace view aggJoin377931207841727255 as (
with aggView5534626252449460739 as (select v40 from aggJoin7614438689845720593 group by v40)
select v40, v41, v44 from aggJoin1215413171256825464 join aggView5534626252449460739 using(v40));
create or replace view aggJoin4189402382093024429 as (
with aggView5153019262072338039 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40 from aggJoin5953150850780327049 join aggView5153019262072338039 using(v23));
create or replace view aggJoin5346447503928694686 as (
with aggView4056626316850434902 as (select v40 from aggJoin4189402382093024429 group by v40)
select v41, v44 from aggJoin377931207841727255 join aggView4056626316850434902 using(v40));
create or replace view aggView2114130282059847415 as select v41 from aggJoin5346447503928694686 group by v41;
select MIN(v41) as v52 from aggView2114130282059847415;
