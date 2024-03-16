create or replace view aggView3512138796894932991 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin1656840367579184534 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView3512138796894932991 where mk.movie_id=aggView3512138796894932991.v12;
create or replace view aggView7578445140443705887 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin6511498433558954329 as select v1, v24 as v24 from aggJoin1656840367579184534 join aggView7578445140443705887 using(v12);
create or replace view aggView3960983938666120119 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4764770316527351118 as select v24 from aggJoin6511498433558954329 join aggView3960983938666120119 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin4764770316527351118;
select sum(v24) from res;