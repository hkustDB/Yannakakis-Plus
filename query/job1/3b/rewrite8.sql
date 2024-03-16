create or replace view aggView1226004464940982780 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin3474836128375949264 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView1226004464940982780 where mi.movie_id=aggView1226004464940982780.v12 and info= 'Bulgaria';
create or replace view aggView3211126681768438677 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin110366856637998298 as select movie_id as v12 from movie_keyword as mk, aggView3211126681768438677 where mk.keyword_id=aggView3211126681768438677.v1;
create or replace view aggView8346908614612920223 as select v12 from aggJoin110366856637998298 group by v12;
create or replace view aggJoin4930617889127565241 as select v7, v24 as v24 from aggJoin3474836128375949264 join aggView8346908614612920223 using(v12);
create or replace view res as select MIN(v24) as v24 from aggJoin4930617889127565241;
select sum(v24) from res;