create or replace view aggView3476221644833080196 as select id as v11, title as v26 from title as t2;
create or replace view aggJoin7952292751527205258 as (
with aggView3931903805748842061 as (select id as v8 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v13 from movie_keyword as mk, aggView3931903805748842061 where mk.keyword_id=aggView3931903805748842061.v8);
create or replace view aggJoin730589078286238290 as (
with aggView2080349648436584773 as (select v13 from aggJoin7952292751527205258 group by v13)
select id as v13, title as v14 from title as t1, aggView2080349648436584773 where t1.id=aggView2080349648436584773.v13);
create or replace view aggView6885363862865296268 as select v13, v14 from aggJoin730589078286238290 group by v13,v14;
create or replace view aggJoin3666934380600816393 as (
with aggView2573960857863314788 as (select v13, MIN(v14) as v38 from aggView6885363862865296268 group by v13)
select linked_movie_id as v11, link_type_id as v4, v38 from movie_link as ml, aggView2573960857863314788 where ml.movie_id=aggView2573960857863314788.v13);
create or replace view aggJoin6421772807519509538 as (
with aggView6500839019809214254 as (select id as v4, link as v37 from link_type as lt)
select v11, v38, v37 from aggJoin3666934380600816393 join aggView6500839019809214254 using(v4));
create or replace view aggJoin3039831449784094002 as (
with aggView3644470925440227535 as (select v11, MIN(v38) as v38, MIN(v37) as v37 from aggJoin6421772807519509538 group by v11,v37,v38)
select v26, v38, v37 from aggView3476221644833080196 join aggView3644470925440227535 using(v11));
select MIN(v37) as v37,MIN(v38) as v38,MIN(v26) as v39 from aggJoin3039831449784094002;
