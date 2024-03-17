create or replace view aggView2784131713897502434 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin507539539389351051 as select movie_id as v12 from movie_keyword as mk, aggView2784131713897502434 where mk.keyword_id=aggView2784131713897502434.v1;
create or replace view aggView255480347283178047 as select v12 from aggJoin507539539389351051 group by v12;
create or replace view aggJoin8282082067710141156 as select movie_id as v12, info as v7 from movie_info as mi, aggView255480347283178047 where mi.movie_id=aggView255480347283178047.v12 and info= 'Bulgaria';
create or replace view aggView9135866646985663811 as select v12 from aggJoin8282082067710141156 group by v12;
create or replace view aggJoin3051779328748781716 as select title as v13 from title as t, aggView9135866646985663811 where t.id=aggView9135866646985663811.v12 and production_year>2010;
create or replace view res as select MIN(v13) as v24 from aggJoin3051779328748781716;
select sum(v24) from res;