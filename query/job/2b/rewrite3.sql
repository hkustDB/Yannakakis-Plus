create or replace view aggJoin6800962971242444699 as (
with aggView9107979938285903837 as (select id as v1 from company_name as cn where country_code= '[nl]')
select movie_id as v12 from movie_companies as mc, aggView9107979938285903837 where mc.company_id=aggView9107979938285903837.v1);
create or replace view aggJoin3454818434882214440 as (
with aggView4211877158674892923 as (select v12 from aggJoin6800962971242444699 group by v12)
select id as v12, title as v20 from title as t, aggView4211877158674892923 where t.id=aggView4211877158674892923.v12);
create or replace view aggJoin1483591007469566880 as (
with aggView2994721637173813220 as (select v12, MIN(v20) as v31 from aggJoin3454818434882214440 group by v12)
select keyword_id as v18, v31 from movie_keyword as mk, aggView2994721637173813220 where mk.movie_id=aggView2994721637173813220.v12);
create or replace view aggJoin6977453295567516025 as (
with aggView5618963287843300068 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select v31 from aggJoin1483591007469566880 join aggView5618963287843300068 using(v18));
select MIN(v31) as v31 from aggJoin6977453295567516025;
