create or replace view aggView4064497596535769241 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1249402620067749740 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView4064497596535769241 where mi_idx.info_type_id=aggView4064497596535769241.v1 and info>'5.0';
create or replace view aggView1416624334975318787 as select v14, COUNT(*) as annot from aggJoin1249402620067749740 group by v14;
create or replace view aggJoin6904370494142568203 as select id as v14, production_year as v18, annot from title as t, aggView1416624334975318787 where t.id=aggView1416624334975318787.v14 and production_year>2005;
create or replace view aggView4231468570046919366 as select v14, SUM(annot) as annot from aggJoin6904370494142568203 group by v14;
create or replace view aggJoin1331019357798783961 as select keyword_id as v3, annot from movie_keyword as mk, aggView4231468570046919366 where mk.movie_id=aggView4231468570046919366.v14;
create or replace view aggView7717657228130502011 as select v3, SUM(annot) as annot from aggJoin1331019357798783961 group by v3;
create or replace view aggJoin1877976652460117458 as select keyword as v4, annot from keyword as k, aggView7717657228130502011 where k.id=aggView7717657228130502011.v3 and keyword LIKE '%sequel%';
select SUM(annot) as v26 from aggJoin1877976652460117458;
