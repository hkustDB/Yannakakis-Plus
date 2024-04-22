create or replace view aggJoin1509493274332381818 as (
with aggView7052401612345576618 as (select id as v26, name as v47 from name as n where name LIKE '%B%')
select movie_id as v3, v47 from cast_info as ci, aggView7052401612345576618 where ci.person_id=aggView7052401612345576618.v26);
create or replace view aggJoin6428800653682183321 as (
with aggView4927618859033359633 as (select id as v3 from title as t)
select v3, v47 from aggJoin1509493274332381818 join aggView4927618859033359633 using(v3));
create or replace view aggJoin6252986867231090716 as (
with aggView2703031667262098517 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView2703031667262098517 where mk.keyword_id=aggView2703031667262098517.v25);
create or replace view aggJoin5945710026619728560 as (
with aggView1476354935659237201 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView1476354935659237201 where mc.company_id=aggView1476354935659237201.v20);
create or replace view aggJoin8813928489852025795 as (
with aggView6520913426859570021 as (select v3 from aggJoin5945710026619728560 group by v3)
select v3 from aggJoin6252986867231090716 join aggView6520913426859570021 using(v3));
create or replace view aggJoin710961660855540525 as (
with aggView5199432699089404883 as (select v3 from aggJoin8813928489852025795 group by v3)
select v47 as v47 from aggJoin6428800653682183321 join aggView5199432699089404883 using(v3));
select MIN(v47) as v47 from aggJoin710961660855540525;
