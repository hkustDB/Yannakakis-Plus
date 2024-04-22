create or replace view aggJoin4658690492699707578 as (
with aggView1329831312212351480 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView1329831312212351480 where mk.keyword_id=aggView1329831312212351480.v33);
create or replace view aggJoin4830596383244518701 as (
with aggView5868290964325842760 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView5868290964325842760 where mc.company_id=aggView5868290964325842760.v28);
create or replace view aggJoin3382393959254959194 as (
with aggView8028263933819380991 as (select v11 from aggJoin4658690492699707578 group by v11)
select v11 from aggJoin4830596383244518701 join aggView8028263933819380991 using(v11));
create or replace view aggJoin5259392361352818967 as (
with aggView7796903641969971802 as (select v11 from aggJoin3382393959254959194 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView7796903641969971802 where t.id=aggView7796903641969971802.v11 and episode_nr>=50 and episode_nr<100);
create or replace view aggView7047742168788772887 as select v11, v44 from aggJoin5259392361352818967 group by v11,v44;
create or replace view aggJoin3440811878369226435 as (
with aggView9000872180904330958 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView9000872180904330958 where an.person_id=aggView9000872180904330958.v2);
create or replace view aggView3560249078386702949 as select v2, v3 from aggJoin3440811878369226435 group by v2,v3;
create or replace view aggJoin6519343911325258172 as (
with aggView8622523515482158201 as (select v11, MIN(v44) as v56 from aggView7047742168788772887 group by v11)
select person_id as v2, v56 from cast_info as ci, aggView8622523515482158201 where ci.movie_id=aggView8622523515482158201.v11);
create or replace view aggJoin3262923060473224077 as (
with aggView6875369779439467073 as (select v2, MIN(v56) as v56 from aggJoin6519343911325258172 group by v2,v56)
select v3, v56 from aggView3560249078386702949 join aggView6875369779439467073 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin3262923060473224077;
