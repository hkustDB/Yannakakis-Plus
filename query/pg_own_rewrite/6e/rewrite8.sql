create or replace view aggView270588199454111746 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin6377348076251041310 as select movie_id as v23, v35 from movie_keyword as mk, aggView270588199454111746 where mk.keyword_id=aggView270588199454111746.v8;
create or replace view aggView8785563767877105755 as select v23, MIN(v35) as v35 from aggJoin6377348076251041310 group by v23,v35;
create or replace view aggJoin137345567295290182 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView8785563767877105755 where t.id=aggView8785563767877105755.v23 and production_year>2000;
create or replace view aggView6592786263484240778 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1094635466207532553 as select movie_id as v23, v36 from cast_info as ci, aggView6592786263484240778 where ci.person_id=aggView6592786263484240778.v14;
create or replace view aggView5130112150803353041 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin137345567295290182 group by v23,v35;
create or replace view aggJoin1021906205726599140 as select v36 as v36, v35, v37 from aggJoin1094635466207532553 join aggView5130112150803353041 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1021906205726599140;
