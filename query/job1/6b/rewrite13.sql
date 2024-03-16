create or replace view aggView8924872278008823059 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1978285600823372118 as select movie_id as v23, v35 from movie_keyword as mk, aggView8924872278008823059 where mk.keyword_id=aggView8924872278008823059.v8;
create or replace view aggView3945862168991335262 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin3906575435392975504 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView3945862168991335262 where ci.movie_id=aggView3945862168991335262.v23;
create or replace view aggView3356273237467195365 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2550662642130911272 as select v23, v37 from aggJoin3906575435392975504 join aggView3356273237467195365 using(v14);
create or replace view aggView8688246184403649304 as select v23, MIN(v35) as v35 from aggJoin1978285600823372118 group by v23;
create or replace view aggJoin589528907774354669 as select v37 as v37, v35 from aggJoin2550662642130911272 join aggView8688246184403649304 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin589528907774354669;
