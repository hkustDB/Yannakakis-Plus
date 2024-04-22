create or replace view aggView3781062590019070923 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView91003274192635139 as select title as v44, id as v11 from title as t where episode_nr>=5 and episode_nr<100;
create or replace view aggJoin7705833490017760715 as (
with aggView665548046449398005 as (select v11, MIN(v44) as v56 from aggView91003274192635139 group by v11)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView665548046449398005 where ci.movie_id=aggView665548046449398005.v11);
create or replace view aggJoin7347792319173527410 as (
with aggView8849160465221940832 as (select id as v2 from name as n)
select v2, v11, v56 from aggJoin7705833490017760715 join aggView8849160465221940832 using(v2));
create or replace view aggJoin8648791784823456335 as (
with aggView7603175703210461031 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView7603175703210461031 where mc.company_id=aggView7603175703210461031.v28);
create or replace view aggJoin8648477334664463701 as (
with aggView7485348508788232181 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView7485348508788232181 where mk.keyword_id=aggView7485348508788232181.v33);
create or replace view aggJoin2346329041222128530 as (
with aggView8024782032305007088 as (select v11 from aggJoin8648477334664463701 group by v11)
select v11 from aggJoin8648791784823456335 join aggView8024782032305007088 using(v11));
create or replace view aggJoin1997726931311883648 as (
with aggView113705571387467457 as (select v11 from aggJoin2346329041222128530 group by v11)
select v2, v56 as v56 from aggJoin7347792319173527410 join aggView113705571387467457 using(v11));
create or replace view aggJoin481525933510042835 as (
with aggView1262797456551442853 as (select v2, MIN(v56) as v56 from aggJoin1997726931311883648 group by v2,v56)
select v3, v56 from aggView3781062590019070923 join aggView1262797456551442853 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin481525933510042835;
