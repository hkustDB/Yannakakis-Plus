create or replace view aggView268301693089664141 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin544309402073179827 as select movie_id as v23, v35 from movie_keyword as mk, aggView268301693089664141 where mk.keyword_id=aggView268301693089664141.v8;
create or replace view aggView2998225728661799290 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1065769131886463518 as select movie_id as v23, v36 from cast_info as ci, aggView2998225728661799290 where ci.person_id=aggView2998225728661799290.v14;
create or replace view aggView5432222362635140067 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin733847721043977367 as select v23, v36, v37 from aggJoin1065769131886463518 join aggView5432222362635140067 using(v23);
create or replace view aggView7757849633421876922 as select v23, MIN(v35) as v35 from aggJoin544309402073179827 group by v23,v35;
create or replace view aggJoin5456244706034847900 as select v36 as v36, v37 as v37, v35 from aggJoin733847721043977367 join aggView7757849633421876922 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5456244706034847900;
