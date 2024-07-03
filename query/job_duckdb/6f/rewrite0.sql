create or replace view aggView6705238450198920460 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin2226055754857576152 as select movie_id as v23, v35 from movie_keyword as mk, aggView6705238450198920460 where mk.keyword_id=aggView6705238450198920460.v8;
create or replace view aggView8380534993987862494 as select v23, MIN(v35) as v35 from aggJoin2226055754857576152 group by v23;
create or replace view aggJoin8859405973353763243 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView8380534993987862494 where t.id=aggView8380534993987862494.v23 and production_year>2000;
create or replace view aggView7700709866689328101 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin8859405973353763243 group by v23;
create or replace view aggJoin6311290604439014732 as select person_id as v14, v35, v37 from cast_info as ci, aggView7700709866689328101 where ci.movie_id=aggView7700709866689328101.v23;
create or replace view aggView7986047151240289362 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin6311290604439014732 group by v14;
create or replace view aggJoin654507848019998093 as select name as v15, v35, v37 from name as n, aggView7986047151240289362 where n.id=aggView7986047151240289362.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin654507848019998093;
