create or replace view aggJoin3471146859516401033 as (
with aggView6323611329065438765 as (select id as v26, name as v47 from name as n where name LIKE '%Bert%')
select movie_id as v3, v47 from cast_info as ci, aggView6323611329065438765 where ci.person_id=aggView6323611329065438765.v26);
create or replace view aggJoin2923811592871769791 as (
with aggView8369228541962276192 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView8369228541962276192 where mc.company_id=aggView8369228541962276192.v20);
create or replace view aggJoin703501171316256777 as (
with aggView4240940807451671550 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView4240940807451671550 where mk.keyword_id=aggView4240940807451671550.v25);
create or replace view aggJoin6701970341307467051 as (
with aggView8433652687422341141 as (select v3 from aggJoin703501171316256777 group by v3)
select id as v3 from title as t, aggView8433652687422341141 where t.id=aggView8433652687422341141.v3);
create or replace view aggJoin4000706858735407949 as (
with aggView4712529242281772509 as (select v3 from aggJoin2923811592871769791 group by v3)
select v3 from aggJoin6701970341307467051 join aggView4712529242281772509 using(v3));
create or replace view aggJoin655396334599598309 as (
with aggView2126162602109431000 as (select v3 from aggJoin4000706858735407949 group by v3)
select v47 as v47 from aggJoin3471146859516401033 join aggView2126162602109431000 using(v3));
select MIN(v47) as v47 from aggJoin655396334599598309;
