create or replace view aggView1918794973456965988 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7911332565302087284 as select movie_id as v12 from movie_keyword as mk, aggView1918794973456965988 where mk.keyword_id=aggView1918794973456965988.v1;
create or replace view aggView4444503712549928908 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin5674004958061579090 as select id as v12, title as v13, production_year as v16 from title as t, aggView4444503712549928908 where t.id=aggView4444503712549928908.v12 and production_year>2005;
create or replace view aggView7373419360282323667 as select v12 from aggJoin7911332565302087284 group by v12;
create or replace view aggJoin4006279027398761482 as select v13, v16 from aggJoin5674004958061579090 join aggView7373419360282323667 using(v12);
create or replace view aggView9157210385272249846 as select v13 from aggJoin4006279027398761482;
select MIN(v13) as v24 from aggView9157210385272249846;
