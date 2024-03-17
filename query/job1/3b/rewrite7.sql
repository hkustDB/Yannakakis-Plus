create or replace view aggView4069938660412676711 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin4454352042787695300 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView4069938660412676711 where mi.movie_id=aggView4069938660412676711.v12 and info= 'Bulgaria';
create or replace view aggView1788020628911893555 as select v12, MIN(v24) as v24 from aggJoin4454352042787695300 group by v12;
create or replace view aggJoin1483048980334712780 as select keyword_id as v1, v24 from movie_keyword as mk, aggView1788020628911893555 where mk.movie_id=aggView1788020628911893555.v12;
create or replace view aggView2976262988893604594 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8717224700916031272 as select v24 from aggJoin1483048980334712780 join aggView2976262988893604594 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin8717224700916031272;
select sum(v24) from res;