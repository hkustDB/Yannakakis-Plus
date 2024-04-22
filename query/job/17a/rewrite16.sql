create or replace view aggJoin7240479147898575815 as (
with aggView51656622868491310 as (select id as v26, name as v47 from name as n where name LIKE 'B%')
select movie_id as v3, v47 from cast_info as ci, aggView51656622868491310 where ci.person_id=aggView51656622868491310.v26);
create or replace view aggJoin3843377720555767134 as (
with aggView5950799836210350046 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView5950799836210350046 where mc.company_id=aggView5950799836210350046.v20);
create or replace view aggJoin9099400204067790519 as (
with aggView4960245496017762126 as (select v3 from aggJoin3843377720555767134 group by v3)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView4960245496017762126 where mk.movie_id=aggView4960245496017762126.v3);
create or replace view aggJoin591574647977698411 as (
with aggView5877600752820492408 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin9099400204067790519 join aggView5877600752820492408 using(v25));
create or replace view aggJoin5199421613284493957 as (
with aggView6596704255398031731 as (select v3 from aggJoin591574647977698411 group by v3)
select id as v3 from title as t, aggView6596704255398031731 where t.id=aggView6596704255398031731.v3);
create or replace view aggJoin8628161043557369905 as (
with aggView1412584643178887775 as (select v3 from aggJoin5199421613284493957 group by v3)
select v47 as v47 from aggJoin7240479147898575815 join aggView1412584643178887775 using(v3));
select MIN(v47) as v47 from aggJoin8628161043557369905;
