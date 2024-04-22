create or replace view aggJoin5075780031819861322 as (
with aggView5150666314205320880 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView5150666314205320880 where t.kind_id=aggView5150666314205320880.v26 and production_year>2000);
create or replace view aggJoin2365058666797259231 as (
with aggView2048551116838411422 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView2048551116838411422 where ci.person_role_id=aggView2048551116838411422.v9);
create or replace view aggJoin5259510234610504422 as (
with aggView3662099479348551770 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin2365058666797259231 join aggView3662099479348551770 using(v31));
create or replace view aggJoin3110425538657292138 as (
with aggView6243512974604476372 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView6243512974604476372 where cc.status_id=aggView6243512974604476372.v7);
create or replace view aggJoin3123270795826728158 as (
with aggView2660748471753351498 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin3110425538657292138 join aggView2660748471753351498 using(v5));
create or replace view aggJoin6610926910875131353 as (
with aggView2599037296526779388 as (select v40 from aggJoin3123270795826728158 group by v40)
select v40, v41, v44 from aggJoin5075780031819861322 join aggView2599037296526779388 using(v40));
create or replace view aggJoin5239530431561630209 as (
with aggView9035646808587336427 as (select v40, MIN(v41) as v52 from aggJoin6610926910875131353 group by v40)
select movie_id as v40, keyword_id as v23, v52 from movie_keyword as mk, aggView9035646808587336427 where mk.movie_id=aggView9035646808587336427.v40);
create or replace view aggJoin1375675326299597456 as (
with aggView5080231755355573275 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40, v52 from aggJoin5239530431561630209 join aggView5080231755355573275 using(v23));
create or replace view aggJoin7726963412680080668 as (
with aggView2237704573737992888 as (select v40, MIN(v52) as v52 from aggJoin1375675326299597456 group by v40,v52)
select v52 from aggJoin5259510234610504422 join aggView2237704573737992888 using(v40));
select MIN(v52) as v52 from aggJoin7726963412680080668;
