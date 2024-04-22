create or replace view aggJoin6289110332720131436 as (
with aggView9129230626610068687 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView9129230626610068687 where cc.subject_id=aggView9129230626610068687.v5);
create or replace view aggJoin8765661788674406966 as (
with aggView3189107412385135797 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView3189107412385135797 where ci.person_id=aggView3189107412385135797.v31);
create or replace view aggJoin4325657039561105716 as (
with aggView36250490223080511 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin6289110332720131436 join aggView36250490223080511 using(v7));
create or replace view aggJoin5307721720113127041 as (
with aggView2170030144692722402 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView2170030144692722402 where t.kind_id=aggView2170030144692722402.v26 and production_year>1950);
create or replace view aggJoin4303723114123858953 as (
with aggView8546068608367868278 as (select v40 from aggJoin4325657039561105716 group by v40)
select movie_id as v40, keyword_id as v23 from movie_keyword as mk, aggView8546068608367868278 where mk.movie_id=aggView8546068608367868278.v40);
create or replace view aggJoin5075840063704288586 as (
with aggView1950569694948328029 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin8765661788674406966 join aggView1950569694948328029 using(v9));
create or replace view aggJoin9205791497157673480 as (
with aggView8918571366595826782 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40 from aggJoin4303723114123858953 join aggView8918571366595826782 using(v23));
create or replace view aggJoin6451758856226221142 as (
with aggView3529994136191505039 as (select v40 from aggJoin9205791497157673480 group by v40)
select v40 from aggJoin5075840063704288586 join aggView3529994136191505039 using(v40));
create or replace view aggJoin7585068001888985506 as (
with aggView5357873976899363681 as (select v40 from aggJoin6451758856226221142 group by v40)
select v41, v44 from aggJoin5307721720113127041 join aggView5357873976899363681 using(v40));
create or replace view aggView4393990586727562867 as select v41 from aggJoin7585068001888985506 group by v41;
select MIN(v41) as v52 from aggView4393990586727562867;
