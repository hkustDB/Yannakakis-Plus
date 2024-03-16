create or replace view aggView4771360078397650913 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7151277779310497025 as select movie_id as v12 from movie_keyword as mk, aggView4771360078397650913 where mk.keyword_id=aggView4771360078397650913.v1;
create or replace view aggView7513360040233213848 as select v12 from aggJoin7151277779310497025 group by v12;
create or replace view aggJoin6620736389802784880 as select movie_id as v12, info as v7 from movie_info as mi, aggView7513360040233213848 where mi.movie_id=aggView7513360040233213848.v12 and info= 'Bulgaria';
create or replace view aggView5355140608575292420 as select v12 from aggJoin6620736389802784880 group by v12;
create or replace view aggJoin1794213413954995168 as select title as v13 from title as t, aggView5355140608575292420 where t.id=aggView5355140608575292420.v12 and production_year>2010;
create or replace view res as select MIN(v13) as v24 from aggJoin1794213413954995168;
select sum(v24) from res;