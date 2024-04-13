create or replace view aggView1444278287735934991 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2382823807106048532 as select movie_id as v12 from movie_keyword as mk, aggView1444278287735934991 where mk.keyword_id=aggView1444278287735934991.v1;
create or replace view aggView2561087636980833022 as select v12 from aggJoin2382823807106048532 group by v12;
create or replace view aggJoin5916874000822921546 as select movie_id as v12, info as v7 from movie_info as mi, aggView2561087636980833022 where mi.movie_id=aggView2561087636980833022.v12 and info= 'Bulgaria';
create or replace view aggView1933188312385776942 as select v12 from aggJoin5916874000822921546 group by v12;
create or replace view aggJoin7634077256139757625 as select title as v13, production_year as v16 from title as t, aggView1933188312385776942 where t.id=aggView1933188312385776942.v12 and production_year>2010;
create or replace view aggView6597575016432387587 as select v13 from aggJoin7634077256139757625 group by v13;
select (v13) as v24 from aggView6597575016432387587;
