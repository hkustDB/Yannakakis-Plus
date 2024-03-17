create or replace view aggView102841936699914414 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7944717740971544415 as select movie_id as v12 from movie_keyword as mk, aggView102841936699914414 where mk.keyword_id=aggView102841936699914414.v1;
create or replace view aggView6236294876166672770 as select v12 from aggJoin7944717740971544415 group by v12;
create or replace view aggJoin5592447353396230658 as select id as v12, title as v13 from title as t, aggView6236294876166672770 where t.id=aggView6236294876166672770.v12 and production_year>2005;
create or replace view aggView722471139339670169 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin5475628080871653630 as select v13 from aggJoin5592447353396230658 join aggView722471139339670169 using(v12);
create or replace view res as select MIN(v13) as v24 from aggJoin5475628080871653630;
select sum(v24) from res;