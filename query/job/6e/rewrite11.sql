create or replace view aggView5152695957444828107 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4457921695039345773 as select movie_id as v23, v35 from movie_keyword as mk, aggView5152695957444828107 where mk.keyword_id=aggView5152695957444828107.v8;
create or replace view aggView749007714628650919 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7328187117764386294 as select movie_id as v23, v36 from cast_info as ci, aggView749007714628650919 where ci.person_id=aggView749007714628650919.v14;
create or replace view aggView5111270940942382241 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin1666366656925084880 as select v23, v36, v37 from aggJoin7328187117764386294 join aggView5111270940942382241 using(v23);
create or replace view aggView8936913946805973323 as select v23, MIN(v35) as v35 from aggJoin4457921695039345773 group by v23;
create or replace view aggJoin4201920876629915353 as select v36 as v36, v37 as v37, v35 from aggJoin1666366656925084880 join aggView8936913946805973323 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4201920876629915353;
