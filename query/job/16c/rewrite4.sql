create or replace view aggView3873219389220881206 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin7384192132782164242 as (
with aggView4158339713893710581 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView4158339713893710581 where mk.keyword_id=aggView4158339713893710581.v33);
create or replace view aggJoin7790304767018339320 as (
with aggView1383209959245434712 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView1383209959245434712 where mc.company_id=aggView1383209959245434712.v28);
create or replace view aggJoin3355825484545412296 as (
with aggView7430259201724622615 as (select v11 from aggJoin7790304767018339320 group by v11)
select v11 from aggJoin7384192132782164242 join aggView7430259201724622615 using(v11));
create or replace view aggJoin6003398100818446644 as (
with aggView5135302056660778467 as (select v11 from aggJoin3355825484545412296 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView5135302056660778467 where t.id=aggView5135302056660778467.v11 and episode_nr<100);
create or replace view aggView5478042754212339256 as select v44, v11 from aggJoin6003398100818446644 group by v44,v11;
create or replace view aggJoin8860800378912400197 as (
with aggView746684919391399168 as (select v2, MIN(v3) as v55 from aggView3873219389220881206 group by v2)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView746684919391399168 where ci.person_id=aggView746684919391399168.v2);
create or replace view aggJoin1014537381649155427 as (
with aggView6435595370773482990 as (select id as v2 from name as n)
select v11, v55 from aggJoin8860800378912400197 join aggView6435595370773482990 using(v2));
create or replace view aggJoin8952233841678185082 as (
with aggView2471779331919663438 as (select v11, MIN(v55) as v55 from aggJoin1014537381649155427 group by v11,v55)
select v44, v55 from aggView5478042754212339256 join aggView2471779331919663438 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin8952233841678185082;
