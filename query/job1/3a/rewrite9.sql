create or replace view aggView3265968927392084462 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6374197414948279989 as select movie_id as v12 from movie_keyword as mk, aggView3265968927392084462 where mk.keyword_id=aggView3265968927392084462.v1;
create or replace view aggView2959013907871900612 as select v12 from aggJoin6374197414948279989 group by v12;
create or replace view aggJoin2588055761750607267 as select id as v12, title as v13 from title as t, aggView2959013907871900612 where t.id=aggView2959013907871900612.v12 and production_year>2005;
create or replace view aggView4278394720241516943 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin7754117154573755277 as select v13 from aggJoin2588055761750607267 join aggView4278394720241516943 using(v12);
select MIN(v13) as v24 from aggJoin7754117154573755277;
