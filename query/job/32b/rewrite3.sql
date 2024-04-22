create or replace view aggJoin4200976904275885478 as (
with aggView2554006324436647650 as (select id as v11, title as v39 from title as t2)
select movie_id as v13, link_type_id as v4, v39 from movie_link as ml, aggView2554006324436647650 where ml.linked_movie_id=aggView2554006324436647650.v11);
create or replace view aggJoin5455314063591900567 as (
with aggView8885687002977116833 as (select id as v4, link as v37 from link_type as lt)
select v13, v39, v37 from aggJoin4200976904275885478 join aggView8885687002977116833 using(v4));
create or replace view aggJoin2816339501513922688 as (
with aggView5582193789842577170 as (select v13, MIN(v39) as v39, MIN(v37) as v37 from aggJoin5455314063591900567 group by v13,v37,v39)
select id as v13, title as v14, v39, v37 from title as t1, aggView5582193789842577170 where t1.id=aggView5582193789842577170.v13);
create or replace view aggJoin1403011948088914611 as (
with aggView4754748566014604045 as (select v13, MIN(v39) as v39, MIN(v37) as v37, MIN(v14) as v38 from aggJoin2816339501513922688 group by v13,v37,v39)
select keyword_id as v8, v39, v37, v38 from movie_keyword as mk, aggView4754748566014604045 where mk.movie_id=aggView4754748566014604045.v13);
create or replace view aggJoin6415218612383869020 as (
with aggView8316663720561697933 as (select id as v8 from keyword as k where keyword= 'character-name-in-title')
select v39, v37, v38 from aggJoin1403011948088914611 join aggView8316663720561697933 using(v8));
select MIN(v37) as v37,MIN(v38) as v38,MIN(v39) as v39 from aggJoin6415218612383869020;
