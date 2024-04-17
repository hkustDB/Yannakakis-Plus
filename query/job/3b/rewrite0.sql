create or replace view aggView307292440741658174 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7432323216317428317 as select movie_id as v12 from movie_keyword as mk, aggView307292440741658174 where mk.keyword_id=aggView307292440741658174.v1;
create or replace view aggView700506636233810812 as select v12 from aggJoin7432323216317428317 group by v12;
create or replace view aggJoin6080140595909342540 as select movie_id as v12, info as v7 from movie_info as mi, aggView700506636233810812 where mi.movie_id=aggView700506636233810812.v12 and info= 'Bulgaria';
create or replace view aggView2880303439151675409 as select v12 from aggJoin6080140595909342540 group by v12;
create or replace view aggJoin1153494837982860926 as select title as v13, production_year as v16 from title as t, aggView2880303439151675409 where t.id=aggView2880303439151675409.v12 and production_year>2010;
create or replace view aggView1685894645671652558 as select v13 from aggJoin1153494837982860926 group by v13;
select MIN(v13) as v24 from aggView1685894645671652558;
