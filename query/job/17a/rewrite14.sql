create or replace view aggJoin5846701735851607338 as (
with aggView3976658007440960803 as (select id as v26, name as v47 from name as n where name LIKE 'B%')
select movie_id as v3, v47 from cast_info as ci, aggView3976658007440960803 where ci.person_id=aggView3976658007440960803.v26);
create or replace view aggJoin1744891215442053280 as (
with aggView2609185056889504357 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView2609185056889504357 where mc.company_id=aggView2609185056889504357.v20);
create or replace view aggJoin6125524633470518860 as (
with aggView6263444642576772091 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView6263444642576772091 where mk.keyword_id=aggView6263444642576772091.v25);
create or replace view aggJoin3990494936234293045 as (
with aggView2734962170693445880 as (select v3 from aggJoin6125524633470518860 group by v3)
select id as v3 from title as t, aggView2734962170693445880 where t.id=aggView2734962170693445880.v3);
create or replace view aggJoin9110826204857132986 as (
with aggView1361001893705801400 as (select v3 from aggJoin1744891215442053280 group by v3)
select v3 from aggJoin3990494936234293045 join aggView1361001893705801400 using(v3));
create or replace view aggJoin6183032334362474400 as (
with aggView2275847741336684643 as (select v3 from aggJoin9110826204857132986 group by v3)
select v47 as v47 from aggJoin5846701735851607338 join aggView2275847741336684643 using(v3));
select MIN(v47) as v47 from aggJoin6183032334362474400;
