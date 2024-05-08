create or replace view aggView1629553995116342421 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2397983539700730970 as select movie_id as v12 from movie_keyword as mk, aggView1629553995116342421 where mk.keyword_id=aggView1629553995116342421.v1;
create or replace view aggView2476804617977999644 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin6383156366566686636 as select id as v12, title as v13, production_year as v16 from title as t, aggView2476804617977999644 where t.id=aggView2476804617977999644.v12 and production_year>2005;
create or replace view aggView5318209067462579208 as select v12 from aggJoin2397983539700730970 group by v12;
create or replace view aggJoin6535169405333990195 as select v13, v16 from aggJoin6383156366566686636 join aggView5318209067462579208 using(v12);
create or replace view aggView674949404107852824 as select v13 from aggJoin6535169405333990195;
select MIN(v13) as v24 from aggView674949404107852824;
