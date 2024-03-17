create or replace view aggView3893660079611961878 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin3310639060707488562 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView3893660079611961878 where mi.movie_id=aggView3893660079611961878.v12 and info= 'Bulgaria';
create or replace view aggView2267177638091380822 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8072032370928833750 as select movie_id as v12 from movie_keyword as mk, aggView2267177638091380822 where mk.keyword_id=aggView2267177638091380822.v1;
create or replace view aggView448936716732200744 as select v12 from aggJoin8072032370928833750 group by v12;
create or replace view aggJoin1834457233852133140 as select v7, v24 as v24 from aggJoin3310639060707488562 join aggView448936716732200744 using(v12);
create or replace view res as select MIN(v24) as v24 from aggJoin1834457233852133140;
select sum(v24) from res;