create or replace view aggJoin8233116530173852448 as (
with aggView4544588020428489429 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView4544588020428489429 where cc.subject_id=aggView4544588020428489429.v5);
create or replace view aggJoin8733508847472834527 as (
with aggView631388039695953677 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView631388039695953677 where ci.person_id=aggView631388039695953677.v31);
create or replace view aggJoin2509342803603073442 as (
with aggView7018412845207117866 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin8233116530173852448 join aggView7018412845207117866 using(v7));
create or replace view aggJoin2540734313632701333 as (
with aggView5260710944345182588 as (select v40 from aggJoin2509342803603073442 group by v40)
select v40, v9 from aggJoin8733508847472834527 join aggView5260710944345182588 using(v40));
create or replace view aggJoin1035467510584414540 as (
with aggView8281074959847209317 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView8281074959847209317 where t.kind_id=aggView8281074959847209317.v26 and production_year>1950);
create or replace view aggJoin5550936837465404088 as (
with aggView6397632318950139103 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin2540734313632701333 join aggView6397632318950139103 using(v9));
create or replace view aggJoin286440045445381495 as (
with aggView1762296782471331117 as (select v40 from aggJoin5550936837465404088 group by v40)
select v40, v41, v44 from aggJoin1035467510584414540 join aggView1762296782471331117 using(v40));
create or replace view aggJoin4895731971167926978 as (
with aggView8355424608568153691 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView8355424608568153691 where mk.keyword_id=aggView8355424608568153691.v23);
create or replace view aggJoin835233432217771677 as (
with aggView8014043548004862449 as (select v40 from aggJoin4895731971167926978 group by v40)
select v41, v44 from aggJoin286440045445381495 join aggView8014043548004862449 using(v40));
create or replace view aggView8090260525614542204 as select v41 from aggJoin835233432217771677 group by v41;
select MIN(v41) as v52 from aggView8090260525614542204;
