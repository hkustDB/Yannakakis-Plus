create or replace view aggView3336952000030180908 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin2868169859838235274 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView3336952000030180908 where mi.movie_id=aggView3336952000030180908.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView2594432829981504497 as select v12, MIN(v24) as v24 from aggJoin2868169859838235274 group by v12;
create or replace view aggJoin2515728513353370850 as select keyword_id as v1, v24 from movie_keyword as mk, aggView2594432829981504497 where mk.movie_id=aggView2594432829981504497.v12;
create or replace view aggView8656974941004705516 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4356614892849459385 as select v24 from aggJoin2515728513353370850 join aggView8656974941004705516 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin4356614892849459385;
select sum(v24) from res;