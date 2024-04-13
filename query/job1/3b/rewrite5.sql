create or replace view aggView4897766948036171875 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin5108759826223479416 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView4897766948036171875 where mk.movie_id=aggView4897766948036171875.v12;
create or replace view aggView4075952579893484393 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5359509583252911642 as select v12, v24 from aggJoin5108759826223479416 join aggView4075952579893484393 using(v1);
create or replace view aggView291496411834825312 as select v12, MIN(v24) as v24 from aggJoin5359509583252911642 group by v12,v24;
create or replace view aggJoin8272126672378121664 as select v24 from movie_info as mi, aggView291496411834825312 where mi.movie_id=aggView291496411834825312.v12 and info= 'Bulgaria';
select MIN(v24) as v24 from aggJoin8272126672378121664;
