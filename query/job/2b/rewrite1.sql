create or replace view aggJoin9208320653209802485 as (
with aggView1090517560580354204 as (select id as v1 from company_name as cn where country_code= '[nl]')
select movie_id as v12 from movie_companies as mc, aggView1090517560580354204 where mc.company_id=aggView1090517560580354204.v1);
create or replace view aggJoin24758754256205105 as (
with aggView5376842062815418419 as (select v12 from aggJoin9208320653209802485 group by v12)
select id as v12, title as v20 from title as t, aggView5376842062815418419 where t.id=aggView5376842062815418419.v12);
create or replace view aggJoin612679225760709102 as (
with aggView2782394712930543666 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v12 from movie_keyword as mk, aggView2782394712930543666 where mk.keyword_id=aggView2782394712930543666.v18);
create or replace view aggJoin7929655038704077195 as (
with aggView4595144567877752670 as (select v12 from aggJoin612679225760709102 group by v12)
select v20 from aggJoin24758754256205105 join aggView4595144567877752670 using(v12));
create or replace view aggView8051952490141282141 as select v20 from aggJoin7929655038704077195 group by v20;
select MIN(v20) as v31 from aggView8051952490141282141;
