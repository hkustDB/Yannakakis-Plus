create or replace view aggView7785870671132728590 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6257454493262352119 as select movie_id as v12 from movie_keyword as mk, aggView7785870671132728590 where mk.keyword_id=aggView7785870671132728590.v1;
create or replace view aggView695479165165142512 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin8062225230981665051 as select v12 from aggJoin6257454493262352119 join aggView695479165165142512 using(v12);
create or replace view aggView2768572093313023923 as select v12 from aggJoin8062225230981665051 group by v12;
create or replace view aggJoin1731694205426477665 as select title as v13, production_year as v16 from title as t, aggView2768572093313023923 where t.id=aggView2768572093313023923.v12 and production_year>2005;
create or replace view aggView4409683648831731052 as select v13 from aggJoin1731694205426477665;
select MIN(v13) as v24 from aggView4409683648831731052;
