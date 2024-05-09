create or replace view aggView8478599036374072882 as select id as v8 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3877857260491896695 as select movie_id as v23 from movie_keyword as mk, aggView8478599036374072882 where mk.keyword_id=aggView8478599036374072882.v8;
create or replace view aggView4570913842038602687 as select v23, COUNT(*) as annot from aggJoin3877857260491896695 group by v23;
create or replace view aggJoin3599722036876063764 as select id as v23, production_year as v27, annot from title as t, aggView4570913842038602687 where t.id=aggView4570913842038602687.v23 and production_year>2010;
create or replace view aggView4476354750866116229 as select v23, SUM(annot) as annot from aggJoin3599722036876063764 group by v23;
create or replace view aggJoin2201094734637588679 as select person_id as v14, annot from cast_info as ci, aggView4476354750866116229 where ci.movie_id=aggView4476354750866116229.v23;
create or replace view aggView7620183723030602143 as select v14, SUM(annot) as annot from aggJoin2201094734637588679 group by v14;
create or replace view aggJoin4443152798110881030 as select annot from name as n, aggView7620183723030602143 where n.id=aggView7620183723030602143.v14 and name LIKE '%Downey%Robert%';
select SUM(annot) as v35 from aggJoin4443152798110881030;
