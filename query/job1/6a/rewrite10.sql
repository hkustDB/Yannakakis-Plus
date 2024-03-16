create or replace view aggView4953057995892650102 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6705619244663030263 as select movie_id as v23, v36 from cast_info as ci, aggView4953057995892650102 where ci.person_id=aggView4953057995892650102.v14;
create or replace view aggView5562261185004439044 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin2102182993667897532 as select movie_id as v23, v35 from movie_keyword as mk, aggView5562261185004439044 where mk.keyword_id=aggView5562261185004439044.v8;
create or replace view aggView4812996673109901542 as select v23, MIN(v36) as v36 from aggJoin6705619244663030263 group by v23;
create or replace view aggJoin306147802259252433 as select v23, v35 as v35, v36 from aggJoin2102182993667897532 join aggView4812996673109901542 using(v23);
create or replace view aggView3308799566134918816 as select v23, MIN(v35) as v35, MIN(v36) as v36 from aggJoin306147802259252433 group by v23;
create or replace view aggJoin6731845367656190659 as select title as v24, v35, v36 from title as t, aggView3308799566134918816 where t.id=aggView3308799566134918816.v23 and production_year>2010;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin6731845367656190659;
