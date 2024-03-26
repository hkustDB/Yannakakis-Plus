create or replace view aggView8746082388910954061 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin2179750446872034778 as select movie_id as v23, v35 from movie_keyword as mk, aggView8746082388910954061 where mk.keyword_id=aggView8746082388910954061.v8;
create or replace view aggView6353351387692546204 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1786084213720789440 as select movie_id as v23, v36 from cast_info as ci, aggView6353351387692546204 where ci.person_id=aggView6353351387692546204.v14;
create or replace view aggView8069517892102285985 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin2024095075406184438 as select v23, v36, v37 from aggJoin1786084213720789440 join aggView8069517892102285985 using(v23);
create or replace view aggView5317098690530581219 as select v23, MIN(v35) as v35 from aggJoin2179750446872034778 group by v23;
create or replace view aggJoin2653457407051206155 as select v36 as v36, v37 as v37, v35 from aggJoin2024095075406184438 join aggView5317098690530581219 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin2653457407051206155;
