create or replace view aggView9206703286498968804 as select title as v44, id as v11 from title as t;
create or replace view aggJoin2019575067592432010 as (
with aggView3718642709378427604 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView3718642709378427604 where an.person_id=aggView3718642709378427604.v2);
create or replace view aggView5928233224421755057 as select v3, v2 from aggJoin2019575067592432010 group by v3,v2;
create or replace view aggJoin3812918589874154377 as (
with aggView1722134477397727988 as (select v2, MIN(v3) as v55 from aggView5928233224421755057 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView1722134477397727988 where ci.person_id=aggView1722134477397727988.v2);
create or replace view aggJoin4549319601508304845 as (
with aggView1576038193767913255 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView1576038193767913255 where mc.company_id=aggView1576038193767913255.v28);
create or replace view aggJoin4997373403713134356 as (
with aggView6288915532086198058 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView6288915532086198058 where mk.keyword_id=aggView6288915532086198058.v33);
create or replace view aggJoin226281457593781327 as (
with aggView4265102319027535298 as (select v11 from aggJoin4549319601508304845 group by v11)
select v11 from aggJoin4997373403713134356 join aggView4265102319027535298 using(v11));
create or replace view aggJoin6075209800979891428 as (
with aggView3676211359224608939 as (select v11 from aggJoin226281457593781327 group by v11)
select v11, v55 as v55 from aggJoin3812918589874154377 join aggView3676211359224608939 using(v11));
create or replace view aggJoin2994304411853942044 as (
with aggView7759493530232087649 as (select v11, MIN(v55) as v55 from aggJoin6075209800979891428 group by v11,v55)
select v44, v55 from aggView9206703286498968804 join aggView7759493530232087649 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin2994304411853942044;
