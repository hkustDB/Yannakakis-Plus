create or replace view aggView3429376473133190448 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin520787668273936147 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView3429376473133190448 where ci.movie_id=aggView3429376473133190448.v23;
create or replace view aggView7477457838036666008 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8521671464196501804 as select v23, v37, v36 from aggJoin520787668273936147 join aggView7477457838036666008 using(v14);
create or replace view aggView376543660431077721 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin1505864584790204038 as select movie_id as v23, v35 from movie_keyword as mk, aggView376543660431077721 where mk.keyword_id=aggView376543660431077721.v8;
create or replace view aggView1499640502256206594 as select v23, MIN(v35) as v35 from aggJoin1505864584790204038 group by v23,v35;
create or replace view aggJoin4226064652858650770 as select v37 as v37, v36 as v36, v35 from aggJoin8521671464196501804 join aggView1499640502256206594 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4226064652858650770;
