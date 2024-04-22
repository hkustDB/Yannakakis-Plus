create or replace view aggJoin5777235044868973756 as (
with aggView4392991050811012753 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v12 from movie_keyword as mk, aggView4392991050811012753 where mk.keyword_id=aggView4392991050811012753.v18);
create or replace view aggJoin1370768728362808280 as (
with aggView2978315041524706108 as (select v12 from aggJoin5777235044868973756 group by v12)
select id as v12, title as v20 from title as t, aggView2978315041524706108 where t.id=aggView2978315041524706108.v12);
create or replace view aggJoin900090373325027727 as (
with aggView4627408353846375416 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v12 from movie_companies as mc, aggView4627408353846375416 where mc.company_id=aggView4627408353846375416.v1);
create or replace view aggJoin3313533780218164064 as (
with aggView6357095792891711666 as (select v12 from aggJoin900090373325027727 group by v12)
select v20 from aggJoin1370768728362808280 join aggView6357095792891711666 using(v12));
create or replace view aggView757618755748613223 as select v20 from aggJoin3313533780218164064 group by v20;
select MIN(v20) as v31 from aggView757618755748613223;
