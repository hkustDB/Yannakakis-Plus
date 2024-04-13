create or replace view aggView4696810966386220859 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin1222913340796701039 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView4696810966386220859 where mk.movie_id=aggView4696810966386220859.v14;
create or replace view aggView1648430206530120660 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1946772036768396465 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView1648430206530120660 where mi_idx.info_type_id=aggView1648430206530120660.v1 and info>'2.0';
create or replace view aggView479469629409925286 as select v14, MIN(v9) as v26 from aggJoin1946772036768396465 group by v14;
create or replace view aggJoin8536410743518045463 as select v3, v27 as v27, v26 from aggJoin1222913340796701039 join aggView479469629409925286 using(v14);
create or replace view aggView1130142400013594484 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin819928238274293351 as select v27, v26 from aggJoin8536410743518045463 join aggView1130142400013594484 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin819928238274293351;
