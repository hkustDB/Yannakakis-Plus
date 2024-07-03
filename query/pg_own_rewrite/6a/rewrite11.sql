create or replace view aggView8015613053295604991 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3097809811328840959 as select movie_id as v23, v35 from movie_keyword as mk, aggView8015613053295604991 where mk.keyword_id=aggView8015613053295604991.v8;
create or replace view aggView5026194953171005829 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin8375412817251737036 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView5026194953171005829 where ci.movie_id=aggView5026194953171005829.v23;
create or replace view aggView8084725511186479523 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3822526563566216495 as select v23, v37, v36 from aggJoin8375412817251737036 join aggView8084725511186479523 using(v14);
create or replace view aggView5422254870676445445 as select v23, MIN(v35) as v35 from aggJoin3097809811328840959 group by v23,v35;
create or replace view aggJoin23174234453104201 as select v37 as v37, v36 as v36, v35 from aggJoin3822526563566216495 join aggView5422254870676445445 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin23174234453104201;
