create or replace view aggView2328639678646788684 as select id as v13, title as v14 from title as t1;
create or replace view aggView3660928851982992830 as select id as v11, title as v26 from title as t2;
create or replace view aggJoin5328647966636320558 as (
with aggView2492792047891126640 as (select v11, MIN(v26) as v39 from aggView3660928851982992830 group by v11)
select movie_id as v13, link_type_id as v4, v39 from movie_link as ml, aggView2492792047891126640 where ml.linked_movie_id=aggView2492792047891126640.v11);
create or replace view aggJoin3610246568648002572 as (
with aggView2522746224824412493 as (select id as v4, link as v37 from link_type as lt)
select v13, v39, v37 from aggJoin5328647966636320558 join aggView2522746224824412493 using(v4));
create or replace view aggJoin8568256856794410748 as (
with aggView6137411819521590292 as (select id as v8 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v13 from movie_keyword as mk, aggView6137411819521590292 where mk.keyword_id=aggView6137411819521590292.v8);
create or replace view aggJoin5640795574295719008 as (
with aggView8529571067510812580 as (select v13 from aggJoin8568256856794410748 group by v13)
select v13, v39 as v39, v37 as v37 from aggJoin3610246568648002572 join aggView8529571067510812580 using(v13));
create or replace view aggJoin8523721423758645415 as (
with aggView2087535918898128970 as (select v13, MIN(v39) as v39, MIN(v37) as v37 from aggJoin5640795574295719008 group by v13,v37,v39)
select v14, v39, v37 from aggView2328639678646788684 join aggView2087535918898128970 using(v13));
select MIN(v37) as v37,MIN(v14) as v38,MIN(v39) as v39 from aggJoin8523721423758645415;
