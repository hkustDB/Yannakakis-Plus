create or replace view aggView4009420946101102089 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin4163290507755490327 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView4009420946101102089 where mi.movie_id=aggView4009420946101102089.v12 and info= 'Bulgaria';
create or replace view aggView3560329793229023568 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5588180238475822010 as select movie_id as v12 from movie_keyword as mk, aggView3560329793229023568 where mk.keyword_id=aggView3560329793229023568.v1;
create or replace view aggView3086608134809647256 as select v12, MIN(v24) as v24 from aggJoin4163290507755490327 group by v12;
create or replace view aggJoin2122091438757004585 as select v24 from aggJoin5588180238475822010 join aggView3086608134809647256 using(v12);
select MIN(v24) as v24 from aggJoin2122091438757004585;
