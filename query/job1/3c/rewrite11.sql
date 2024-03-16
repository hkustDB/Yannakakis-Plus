create or replace view aggView449413704869466596 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin1713630810292912269 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView449413704869466596 where mk.movie_id=aggView449413704869466596.v12;
create or replace view aggView761748641066776348 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin4193136648880341530 as select v1, v24 as v24 from aggJoin1713630810292912269 join aggView761748641066776348 using(v12);
create or replace view aggView4615062557441501807 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin335018036272660395 as select v24 from aggJoin4193136648880341530 join aggView4615062557441501807 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin335018036272660395;
select sum(v24) from res;