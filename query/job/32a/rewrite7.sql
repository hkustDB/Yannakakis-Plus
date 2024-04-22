create or replace view aggJoin1850093305281254386 as (
with aggView2071206859839342056 as (select id as v11, title as v39 from title as t2)
select movie_id as v13, link_type_id as v4, v39 from movie_link as ml, aggView2071206859839342056 where ml.linked_movie_id=aggView2071206859839342056.v11);
create or replace view aggJoin5141501183004523174 as (
with aggView5551507639011951315 as (select id as v13, title as v38 from title as t1)
select v13, v4, v39, v38 from aggJoin1850093305281254386 join aggView5551507639011951315 using(v13));
create or replace view aggJoin5038794528988211382 as (
with aggView5189386408784623372 as (select id as v4, link as v37 from link_type as lt)
select v13, v39, v38, v37 from aggJoin5141501183004523174 join aggView5189386408784623372 using(v4));
create or replace view aggJoin2585298127572957667 as (
with aggView3346390957495330642 as (select v13, MIN(v39) as v39, MIN(v38) as v38, MIN(v37) as v37 from aggJoin5038794528988211382 group by v13,v39,v38,v37)
select keyword_id as v8, v39, v38, v37 from movie_keyword as mk, aggView3346390957495330642 where mk.movie_id=aggView3346390957495330642.v13);
create or replace view aggJoin8876808883773548840 as (
with aggView1794612298357925806 as (select id as v8 from keyword as k where keyword= '10,000-mile-club')
select v39, v38, v37 from aggJoin2585298127572957667 join aggView1794612298357925806 using(v8));
select MIN(v37) as v37,MIN(v38) as v38,MIN(v39) as v39 from aggJoin8876808883773548840;
