create or replace view aggView7259238564711383397 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4914192732176744821 as select movie_id as v23, v35 from movie_keyword as mk, aggView7259238564711383397 where mk.keyword_id=aggView7259238564711383397.v8;
create or replace view aggView638711966176811195 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin3737185015538990973 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView638711966176811195 where ci.movie_id=aggView638711966176811195.v23;
create or replace view aggView2117582916589909153 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4031975961550527679 as select v23, v37, v36 from aggJoin3737185015538990973 join aggView2117582916589909153 using(v14);
create or replace view aggView5310827580870741267 as select v23, MIN(v35) as v35 from aggJoin4914192732176744821 group by v23,v35;
create or replace view aggJoin5254956351564882339 as select v37 as v37, v36 as v36, v35 from aggJoin4031975961550527679 join aggView5310827580870741267 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5254956351564882339;
