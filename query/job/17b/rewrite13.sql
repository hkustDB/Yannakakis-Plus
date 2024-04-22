create or replace view aggJoin5893683004298849824 as (
with aggView2939351201631617798 as (select id as v26, name as v47 from name as n where name LIKE 'Z%')
select movie_id as v3, v47 from cast_info as ci, aggView2939351201631617798 where ci.person_id=aggView2939351201631617798.v26);
create or replace view aggJoin8511334558191410725 as (
with aggView1655457893515934522 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView1655457893515934522 where mc.company_id=aggView1655457893515934522.v20);
create or replace view aggJoin6091040294502725275 as (
with aggView2843379800424481560 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView2843379800424481560 where mk.keyword_id=aggView2843379800424481560.v25);
create or replace view aggJoin6405225977393429779 as (
with aggView6078347267533546116 as (select v3 from aggJoin8511334558191410725 group by v3)
select v3 from aggJoin6091040294502725275 join aggView6078347267533546116 using(v3));
create or replace view aggJoin6500349653833088596 as (
with aggView2534024744436922029 as (select v3 from aggJoin6405225977393429779 group by v3)
select id as v3 from title as t, aggView2534024744436922029 where t.id=aggView2534024744436922029.v3);
create or replace view aggJoin1308444470326478662 as (
with aggView5231111861519879773 as (select v3 from aggJoin6500349653833088596 group by v3)
select v47 as v47 from aggJoin5893683004298849824 join aggView5231111861519879773 using(v3));
select MIN(v47) as v47 from aggJoin1308444470326478662;
