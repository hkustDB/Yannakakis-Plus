create or replace view aggView2121680221074798015 as select movie_id as v12, COUNT(*) as annot from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin8280412847201934593 as select id as v12, production_year as v16, annot from title as t, aggView2121680221074798015 where t.id=aggView2121680221074798015.v12 and production_year>1990;
create or replace view aggView7954539087140933260 as select v12, SUM(annot) as annot from aggJoin8280412847201934593 group by v12;
create or replace view aggJoin1116326774855845958 as select keyword_id as v1, annot from movie_keyword as mk, aggView7954539087140933260 where mk.movie_id=aggView7954539087140933260.v12;
create or replace view aggView6746358322373801129 as select v1, SUM(annot) as annot from aggJoin1116326774855845958 group by v1;
create or replace view aggJoin1332287714107865728 as select keyword as v2, annot from keyword as k, aggView6746358322373801129 where k.id=aggView6746358322373801129.v1 and keyword LIKE '%sequel%';
select SUM(annot) as v24 from aggJoin1332287714107865728;
