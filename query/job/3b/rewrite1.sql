create or replace view aggView6486515249977972993 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1522813219944538279 as select movie_id as v12 from movie_keyword as mk, aggView6486515249977972993 where mk.keyword_id=aggView6486515249977972993.v1;
create or replace view aggView5997406000151528115 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin5379753674143524329 as select v12 from aggJoin1522813219944538279 join aggView5997406000151528115 using(v12);
create or replace view aggView3368202296798619413 as select v12 from aggJoin5379753674143524329 group by v12;
create or replace view aggJoin3084683233721191919 as select title as v13, production_year as v16 from title as t, aggView3368202296798619413 where t.id=aggView3368202296798619413.v12 and production_year>2010;
create or replace view aggView1378748413782612177 as select v13 from aggJoin3084683233721191919;
select MIN(v13) as v24 from aggView1378748413782612177;
