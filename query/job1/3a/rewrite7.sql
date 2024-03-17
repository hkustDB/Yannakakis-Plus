create or replace view aggView1701122674919892366 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin4233578594004821597 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView1701122674919892366 where mi.movie_id=aggView1701122674919892366.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView4862222266052236689 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8627824299913768412 as select movie_id as v12 from movie_keyword as mk, aggView4862222266052236689 where mk.keyword_id=aggView4862222266052236689.v1;
create or replace view aggView2366576538463820829 as select v12 from aggJoin8627824299913768412 group by v12;
create or replace view aggJoin4011084737663489699 as select v7, v24 as v24 from aggJoin4233578594004821597 join aggView2366576538463820829 using(v12);
create or replace view res as select MIN(v24) as v24 from aggJoin4011084737663489699;
select sum(v24) from res;