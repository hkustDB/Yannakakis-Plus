create or replace view aggView4235489014947296235 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin2886529009322933777 as select movie_id as v23, v35 from movie_keyword as mk, aggView4235489014947296235 where mk.keyword_id=aggView4235489014947296235.v8;
create or replace view aggView6936382693943677046 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1113858703880284101 as select movie_id as v23, v36 from cast_info as ci, aggView6936382693943677046 where ci.person_id=aggView6936382693943677046.v14;
create or replace view aggView6443154694676530200 as select v23, MIN(v35) as v35 from aggJoin2886529009322933777 group by v23;
create or replace view aggJoin5479446311889703367 as select id as v23, title as v24, v35 from title as t, aggView6443154694676530200 where t.id=aggView6443154694676530200.v23 and production_year>2000;
create or replace view aggView9005870830782305105 as select v23, MIN(v36) as v36 from aggJoin1113858703880284101 group by v23;
create or replace view aggJoin8750862764373495703 as select v24, v35 as v35, v36 from aggJoin5479446311889703367 join aggView9005870830782305105 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin8750862764373495703;
