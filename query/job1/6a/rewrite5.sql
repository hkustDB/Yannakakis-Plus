create or replace view aggView7725550725125660063 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin4924853381074473085 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView7725550725125660063 where ci.movie_id=aggView7725550725125660063.v23;
create or replace view aggView750844557153376545 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2069120444585283408 as select v23, v37 from aggJoin4924853381074473085 join aggView750844557153376545 using(v14);
create or replace view aggView1140600866667613484 as select v23, MIN(v37) as v37 from aggJoin2069120444585283408 group by v23;
create or replace view aggJoin5553858148028219009 as select keyword_id as v8, v37 from movie_keyword as mk, aggView1140600866667613484 where mk.movie_id=aggView1140600866667613484.v23;
create or replace view aggView5889781661313610878 as select v8, MIN(v37) as v37 from aggJoin5553858148028219009 group by v8;
create or replace view aggJoin3891737261554567001 as select keyword as v9, v37 from keyword as k, aggView5889781661313610878 where k.id=aggView5889781661313610878.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3891737261554567001;
