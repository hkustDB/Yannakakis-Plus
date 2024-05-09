create or replace view aggView7164817421583500546 as select id as v12 from title as t where production_year>2005;
create or replace view aggJoin763791854515943174 as select movie_id as v12, info as v7 from movie_info as mi, aggView7164817421583500546 where mi.movie_id=aggView7164817421583500546.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2526062666773410155 as select v12, COUNT(*) as annot from aggJoin763791854515943174 group by v12;
create or replace view aggJoin6027215442523393704 as select keyword_id as v1, annot from movie_keyword as mk, aggView2526062666773410155 where mk.movie_id=aggView2526062666773410155.v12;
create or replace view aggView8866786012545537601 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6630771188688659193 as select annot from aggJoin6027215442523393704 join aggView8866786012545537601 using(v1);
select SUM(annot) as v24 from aggJoin6630771188688659193;
