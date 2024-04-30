create or replace view aggView2024214639417772172 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin1906732666218425845 as select movie_id as v23, v35 from movie_keyword as mk, aggView2024214639417772172 where mk.keyword_id=aggView2024214639417772172.v8;
create or replace view aggView5926391293111628897 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2281384241885487975 as select movie_id as v23, v36 from cast_info as ci, aggView5926391293111628897 where ci.person_id=aggView5926391293111628897.v14;
create or replace view aggView2678752852351426868 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin8919472676988879500 as select v23, v36, v37 from aggJoin2281384241885487975 join aggView2678752852351426868 using(v23);
create or replace view aggView395098288079561192 as select v23, MIN(v35) as v35 from aggJoin1906732666218425845 group by v23;
create or replace view aggJoin7835806786310865617 as select v36 as v36, v37 as v37, v35 from aggJoin8919472676988879500 join aggView395098288079561192 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7835806786310865617;
