create or replace view aggView7223352761171787261 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6289291919024830173 as select movie_id as v12 from movie_keyword as mk, aggView7223352761171787261 where mk.keyword_id=aggView7223352761171787261.v1;
create or replace view aggView5038797942228470606 as select v12 from aggJoin6289291919024830173 group by v12;
create or replace view aggJoin3345911806278316165 as select id as v12, title as v13, production_year as v16 from title as t, aggView5038797942228470606 where t.id=aggView5038797942228470606.v12 and production_year>2010;
create or replace view aggView4614034284612644146 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin7117858016706447074 as select v13, v16 from aggJoin3345911806278316165 join aggView4614034284612644146 using(v12);
create or replace view aggView6306044073291964426 as select v13 from aggJoin7117858016706447074 group by v13;
select MIN(v13) as v24 from aggView6306044073291964426;
