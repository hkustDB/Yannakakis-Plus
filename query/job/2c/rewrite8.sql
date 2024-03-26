create or replace view aggView7535082885502838551 as select id as v12, title as v31 from title as t;
create or replace view aggJoin7631424460281181723 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView7535082885502838551 where mk.movie_id=aggView7535082885502838551.v12;
create or replace view aggView3107558996316175831 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3223418241298449167 as select v12, v31 from aggJoin7631424460281181723 join aggView3107558996316175831 using(v18);
create or replace view aggView2822608856209368442 as select v12, MIN(v31) as v31 from aggJoin3223418241298449167 group by v12;
create or replace view aggJoin6939165451481149244 as select company_id as v1, v31 from movie_companies as mc, aggView2822608856209368442 where mc.movie_id=aggView2822608856209368442.v12;
create or replace view aggView2668012206388584235 as select v1, MIN(v31) as v31 from aggJoin6939165451481149244 group by v1;
create or replace view aggJoin9016294038645427543 as select country_code as v3, v31 from company_name as cn, aggView2668012206388584235 where cn.id=aggView2668012206388584235.v1 and country_code= '[sm]';
select MIN(v31) as v31 from aggJoin9016294038645427543;
