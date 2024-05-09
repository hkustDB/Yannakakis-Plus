create or replace view aggView5136385056393838505 as select movie_id as v12, COUNT(*) as annot from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin202332757640412178 as select id as v12, production_year as v16, annot from title as t, aggView5136385056393838505 where t.id=aggView5136385056393838505.v12 and production_year>2005;
create or replace view aggView7010844983720259164 as select v12, SUM(annot) as annot from aggJoin202332757640412178 group by v12;
create or replace view aggJoin3998226338244598645 as select keyword_id as v1, annot from movie_keyword as mk, aggView7010844983720259164 where mk.movie_id=aggView7010844983720259164.v12;
create or replace view aggView8676827576900965869 as select v1, SUM(annot) as annot from aggJoin3998226338244598645 group by v1;
create or replace view aggJoin3048175925734363589 as select keyword as v2, annot from keyword as k, aggView8676827576900965869 where k.id=aggView8676827576900965869.v1 and keyword LIKE '%sequel%';
select SUM(annot) as v24 from aggJoin3048175925734363589;
