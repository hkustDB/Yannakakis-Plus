create or replace view aggView7969951394886357333 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin5453841347299596014 as select movie_id as v12 from movie_companies as mc, aggView7969951394886357333 where mc.company_id=aggView7969951394886357333.v1;
create or replace view aggView3271050116243905650 as select v12 from aggJoin5453841347299596014 group by v12;
create or replace view aggJoin7807532857187874567 as select id as v12, title as v20 from title as t, aggView3271050116243905650 where t.id=aggView3271050116243905650.v12;
create or replace view aggView2007714566469867980 as select v12, MIN(v20) as v31 from aggJoin7807532857187874567 group by v12;
create or replace view aggJoin1979700074930212374 as select keyword_id as v18, v31 from movie_keyword as mk, aggView2007714566469867980 where mk.movie_id=aggView2007714566469867980.v12;
create or replace view aggView9191658230176094874 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2446410493027761503 as select v31 from aggJoin1979700074930212374 join aggView9191658230176094874 using(v18);
select MIN(v31) as v31 from aggJoin2446410493027761503;
