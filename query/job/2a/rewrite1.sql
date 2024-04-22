create or replace view aggJoin7510482201997339533 as (
with aggView4356454618945940670 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v12 from movie_keyword as mk, aggView4356454618945940670 where mk.keyword_id=aggView4356454618945940670.v18);
create or replace view aggJoin7267392675176833509 as (
with aggView7503352674500740500 as (select id as v1 from company_name as cn where country_code= '[de]')
select movie_id as v12 from movie_companies as mc, aggView7503352674500740500 where mc.company_id=aggView7503352674500740500.v1);
create or replace view aggJoin1002576601214521601 as (
with aggView6922804502925808184 as (select v12 from aggJoin7510482201997339533 group by v12)
select v12 from aggJoin7267392675176833509 join aggView6922804502925808184 using(v12));
create or replace view aggJoin9139273613906048869 as (
with aggView9436574237260232 as (select v12 from aggJoin1002576601214521601 group by v12)
select title as v20 from title as t, aggView9436574237260232 where t.id=aggView9436574237260232.v12);
create or replace view aggView1112801702547554775 as select v20 from aggJoin9139273613906048869 group by v20;
select MIN(v20) as v31 from aggView1112801702547554775;
