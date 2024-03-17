create or replace view aggView984318477582561825 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin8511664774005812465 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView984318477582561825 where mi.movie_id=aggView984318477582561825.v12 and info= 'Bulgaria';
create or replace view aggView5899046346102595850 as select v12, MIN(v24) as v24 from aggJoin8511664774005812465 group by v12;
create or replace view aggJoin4179191546806367660 as select keyword_id as v1, v24 from movie_keyword as mk, aggView5899046346102595850 where mk.movie_id=aggView5899046346102595850.v12;
create or replace view aggView8290413106782505262 as select v1, MIN(v24) as v24 from aggJoin4179191546806367660 group by v1;
create or replace view aggJoin2438714765538048357 as select keyword as v2, v24 from keyword as k, aggView8290413106782505262 where k.id=aggView8290413106782505262.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin2438714765538048357;
select sum(v24) from res;