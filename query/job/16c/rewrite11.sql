create or replace view aggView3798609942420853898 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin5456571094759433320 as (
with aggView8823837426782198299 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView8823837426782198299 where mk.keyword_id=aggView8823837426782198299.v33);
create or replace view aggJoin3300584497037078881 as (
with aggView6689895132532759621 as (select v11 from aggJoin5456571094759433320 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView6689895132532759621 where t.id=aggView6689895132532759621.v11 and episode_nr<100);
create or replace view aggView5724468141811561657 as select v44, v11 from aggJoin3300584497037078881 group by v44,v11;
create or replace view aggJoin6193908615494145455 as (
with aggView1888068000123772213 as (select v11, MIN(v44) as v56 from aggView5724468141811561657 group by v11)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView1888068000123772213 where ci.movie_id=aggView1888068000123772213.v11);
create or replace view aggJoin7584224707474262427 as (
with aggView2054065786141520388 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView2054065786141520388 where mc.company_id=aggView2054065786141520388.v28);
create or replace view aggJoin7822075967969724633 as (
with aggView8585164017177414362 as (select v11 from aggJoin7584224707474262427 group by v11)
select v2, v56 as v56 from aggJoin6193908615494145455 join aggView8585164017177414362 using(v11));
create or replace view aggJoin5689715074130458082 as (
with aggView3629522439323441038 as (select id as v2 from name as n)
select v2, v56 from aggJoin7822075967969724633 join aggView3629522439323441038 using(v2));
create or replace view aggJoin1409028249307704496 as (
with aggView6905749291820405876 as (select v2, MIN(v56) as v56 from aggJoin5689715074130458082 group by v2,v56)
select v3, v56 from aggView3798609942420853898 join aggView6905749291820405876 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin1409028249307704496;
