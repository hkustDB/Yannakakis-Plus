create or replace view aggView5242401918118189315 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8201874487991527290 as select movie_id as v12 from movie_keyword as mk, aggView5242401918118189315 where mk.keyword_id=aggView5242401918118189315.v1;
create or replace view aggView7976128130650834351 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin604094182616533600 as select v12 from aggJoin8201874487991527290 join aggView7976128130650834351 using(v12);
create or replace view aggView7317318161744734227 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin7345033198817283516 as select v24 from aggJoin604094182616533600 join aggView7317318161744734227 using(v12);
select MIN(v24) as v24 from aggJoin7345033198817283516;
