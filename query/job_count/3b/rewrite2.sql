create or replace view aggView5039115509340788089 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6154392701805281665 as select movie_id as v12 from movie_keyword as mk, aggView5039115509340788089 where mk.keyword_id=aggView5039115509340788089.v1;
create or replace view aggView6452264722236502113 as select v12, COUNT(*) as annot from aggJoin6154392701805281665 group by v12;
create or replace view aggJoin8528992236117069385 as select movie_id as v12, info as v7, annot from movie_info as mi, aggView6452264722236502113 where mi.movie_id=aggView6452264722236502113.v12 and info= 'Bulgaria';
create or replace view aggView811943860442582659 as select v12, SUM(annot) as annot from aggJoin8528992236117069385 group by v12;
create or replace view aggJoin272918154185164523 as select production_year as v16, annot from title as t, aggView811943860442582659 where t.id=aggView811943860442582659.v12 and production_year>2010;
select SUM(annot) as v24 from aggJoin272918154185164523;
