create or replace view aggJoin7489370360156920126 as (
with aggView195851665455005788 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v12 from movie_keyword as mk, aggView195851665455005788 where mk.keyword_id=aggView195851665455005788.v18);
create or replace view aggJoin547769644551038375 as (
with aggView8018291455095252875 as (select v12 from aggJoin7489370360156920126 group by v12)
select id as v12, title as v20 from title as t, aggView8018291455095252875 where t.id=aggView8018291455095252875.v12);
create or replace view aggJoin6998403868766530703 as (
with aggView8864046948584562702 as (select id as v1 from company_name as cn where country_code= '[sm]')
select movie_id as v12 from movie_companies as mc, aggView8864046948584562702 where mc.company_id=aggView8864046948584562702.v1);
create or replace view aggJoin2319795308634822542 as (
with aggView1207056927458878358 as (select v12 from aggJoin6998403868766530703 group by v12)
select v20 from aggJoin547769644551038375 join aggView1207056927458878358 using(v12));
create or replace view aggView3445807252595533040 as select v20 from aggJoin2319795308634822542 group by v20;
select MIN(v20) as v31 from aggView3445807252595533040;
