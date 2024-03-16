create or replace view aggView3724261339622742889 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin3660072218570725700 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView3724261339622742889 where mk.movie_id=aggView3724261339622742889.v12;
create or replace view aggView8825433180848113922 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8005022430856690651 as select v12 from aggJoin3660072218570725700 join aggView8825433180848113922 using(v1);
create or replace view aggView6000912282750486089 as select v12 from aggJoin8005022430856690651 group by v12;
create or replace view aggJoin7316556969880368501 as select title as v13 from title as t, aggView6000912282750486089 where t.id=aggView6000912282750486089.v12 and production_year>1990;
select MIN(v13) as v24 from aggJoin7316556969880368501;
