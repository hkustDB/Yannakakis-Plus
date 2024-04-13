create or replace view aggView4436001677562679104 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3163905178148669755 as select movie_id as v12 from movie_keyword as mk, aggView4436001677562679104 where mk.keyword_id=aggView4436001677562679104.v1;
create or replace view aggView633187464835651335 as select v12 from aggJoin3163905178148669755 group by v12;
create or replace view aggJoin2723013444674560181 as select movie_id as v12, info as v7 from movie_info as mi, aggView633187464835651335 where mi.movie_id=aggView633187464835651335.v12 and info= 'Bulgaria';
create or replace view aggView4479528626004981554 as select v12 from aggJoin2723013444674560181 group by v12;
create or replace view aggJoin638662479572925563 as select title as v13, production_year as v16 from title as t, aggView4479528626004981554 where t.id=aggView4479528626004981554.v12 and production_year>2010;
create or replace view aggView878491151002041345 as select v13 from aggJoin638662479572925563 group by v13;
select MIN(v13) as v24 from aggView878491151002041345;
