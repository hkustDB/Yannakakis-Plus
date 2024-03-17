create or replace view aggView4736751223588661321 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin6023637739580753174 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView4736751223588661321 where mi.movie_id=aggView4736751223588661321.v12 and info= 'Bulgaria';
create or replace view aggView1626123419679714322 as select v12, MIN(v24) as v24 from aggJoin6023637739580753174 group by v12;
create or replace view aggJoin1524618517151337041 as select keyword_id as v1, v24 from movie_keyword as mk, aggView1626123419679714322 where mk.movie_id=aggView1626123419679714322.v12;
create or replace view aggView4351985687771927875 as select v1, MIN(v24) as v24 from aggJoin1524618517151337041 group by v1;
create or replace view aggJoin3422130105581710577 as select keyword as v2, v24 from keyword as k, aggView4351985687771927875 where k.id=aggView4351985687771927875.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin3422130105581710577;
select sum(v24) from res;