create or replace view aggView2424693190113160264 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin5815640452084564334 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView2424693190113160264 where mi.movie_id=aggView2424693190113160264.v12 and info= 'Bulgaria';
create or replace view aggView9096871100117899612 as select v12, MIN(v24) as v24 from aggJoin5815640452084564334 group by v12;
create or replace view aggJoin6240672437752765157 as select keyword_id as v1, v24 from movie_keyword as mk, aggView9096871100117899612 where mk.movie_id=aggView9096871100117899612.v12;
create or replace view aggView8357920877275825215 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7512968252071946598 as select v24 from aggJoin6240672437752765157 join aggView8357920877275825215 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin7512968252071946598;
select sum(v24) from res;