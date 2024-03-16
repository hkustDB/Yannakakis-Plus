create or replace view aggView3942921753059589223 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin9218818040866090932 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView3942921753059589223 where mi.movie_id=aggView3942921753059589223.v12 and info= 'Bulgaria';
create or replace view aggView2641889202823580288 as select v12, MIN(v24) as v24 from aggJoin9218818040866090932 group by v12;
create or replace view aggJoin2234423131601128637 as select keyword_id as v1, v24 from movie_keyword as mk, aggView2641889202823580288 where mk.movie_id=aggView2641889202823580288.v12;
create or replace view aggView6032306144680815704 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8245448974795250489 as select v24 from aggJoin2234423131601128637 join aggView6032306144680815704 using(v1);
select MIN(v24) as v24 from aggJoin8245448974795250489;
