create or replace view aggView4596496373831135460 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin5946769613940666095 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView4596496373831135460 where mi.movie_id=aggView4596496373831135460.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView8531938830934530145 as select v12, MIN(v24) as v24 from aggJoin5946769613940666095 group by v12;
create or replace view aggJoin2249875261779980029 as select keyword_id as v1, v24 from movie_keyword as mk, aggView8531938830934530145 where mk.movie_id=aggView8531938830934530145.v12;
create or replace view aggView6652265068222905589 as select v1, MIN(v24) as v24 from aggJoin2249875261779980029 group by v1;
create or replace view aggJoin4992639314920546094 as select keyword as v2, v24 from keyword as k, aggView6652265068222905589 where k.id=aggView6652265068222905589.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin4992639314920546094;
