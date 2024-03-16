create or replace view aggView1037029701605848940 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin8340947052037133013 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView1037029701605848940 where mi.movie_id=aggView1037029701605848940.v12 and info= 'Bulgaria';
create or replace view aggView4922017527710760652 as select v12, MIN(v24) as v24 from aggJoin8340947052037133013 group by v12;
create or replace view aggJoin5262748945969225930 as select keyword_id as v1, v24 from movie_keyword as mk, aggView4922017527710760652 where mk.movie_id=aggView4922017527710760652.v12;
create or replace view aggView727861805848314382 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7410633914119341373 as select v24 from aggJoin5262748945969225930 join aggView727861805848314382 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin7410633914119341373;
select sum(v24) from res;