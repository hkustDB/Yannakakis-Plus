create or replace view aggJoin2326503126870719021 as (
with aggView4993982537713835553 as (select id as v12, title as v31 from title as t)
select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView4993982537713835553 where mc.movie_id=aggView4993982537713835553.v12);
create or replace view aggJoin6708966369258794378 as (
with aggView2976237626313661149 as (select id as v1 from company_name as cn where country_code= '[nl]')
select v12, v31 from aggJoin2326503126870719021 join aggView2976237626313661149 using(v1));
create or replace view aggJoin5304836888378610052 as (
with aggView7067478562395182638 as (select v12, MIN(v31) as v31 from aggJoin6708966369258794378 group by v12,v31)
select keyword_id as v18, v31 from movie_keyword as mk, aggView7067478562395182638 where mk.movie_id=aggView7067478562395182638.v12);
create or replace view aggJoin4904107792221423689 as (
with aggView2373699111870721474 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select v31 from aggJoin5304836888378610052 join aggView2373699111870721474 using(v18));
select MIN(v31) as v31 from aggJoin4904107792221423689;
