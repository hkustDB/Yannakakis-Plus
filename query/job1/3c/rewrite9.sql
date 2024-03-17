create or replace view aggView2776510479734210734 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin3961316314647536666 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView2776510479734210734 where mi.movie_id=aggView2776510479734210734.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView6975316833231951172 as select v12, MIN(v24) as v24 from aggJoin3961316314647536666 group by v12;
create or replace view aggJoin838658259903071209 as select keyword_id as v1, v24 from movie_keyword as mk, aggView6975316833231951172 where mk.movie_id=aggView6975316833231951172.v12;
create or replace view aggView3171877196980481250 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2268254133708658686 as select v24 from aggJoin838658259903071209 join aggView3171877196980481250 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin2268254133708658686;
select sum(v24) from res;