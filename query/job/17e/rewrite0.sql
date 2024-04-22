create or replace view aggJoin4793304773937127739 as (
with aggView5801944655759437088 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView5801944655759437088 where mc.company_id=aggView5801944655759437088.v20);
create or replace view aggJoin2676785913559909385 as (
with aggView335954854150325202 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView335954854150325202 where mk.keyword_id=aggView335954854150325202.v25);
create or replace view aggJoin3789846843710580432 as (
with aggView5612732645589775187 as (select v3 from aggJoin2676785913559909385 group by v3)
select id as v3 from title as t, aggView5612732645589775187 where t.id=aggView5612732645589775187.v3);
create or replace view aggJoin200287442918652760 as (
with aggView123079656080229136 as (select v3 from aggJoin3789846843710580432 group by v3)
select v3 from aggJoin4793304773937127739 join aggView123079656080229136 using(v3));
create or replace view aggJoin6272944435608071785 as (
with aggView2848341078322183520 as (select v3 from aggJoin200287442918652760 group by v3)
select person_id as v26 from cast_info as ci, aggView2848341078322183520 where ci.movie_id=aggView2848341078322183520.v3);
create or replace view aggJoin4552087870617431302 as (
with aggView2682088566634009206 as (select v26 from aggJoin6272944435608071785 group by v26)
select name as v27 from name as n, aggView2682088566634009206 where n.id=aggView2682088566634009206.v26);
create or replace view aggView581507831048914701 as select v27 from aggJoin4552087870617431302 group by v27;
select MIN(v27) as v47 from aggView581507831048914701;
