create or replace view aggView8412408445117766077 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggView753162820189495578 as select title as v38, id as v37 from title as t;
create or replace view aggJoin3165220866671840685 as (
with aggView8056222366375041407 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView8056222366375041407 where mi_idx.info_type_id=aggView8056222366375041407.v10);
create or replace view aggView5696795960875447608 as select v23, v37 from aggJoin3165220866671840685 group by v23,v37;
create or replace view aggJoin6863489761850326824 as (
with aggView4938877322894768657 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView4938877322894768657 where mi.info_type_id=aggView4938877322894768657.v8);
create or replace view aggJoin8075040791229692795 as (
with aggView5004222233276862744 as (select v18, v37 from aggJoin6863489761850326824 group by v18,v37)
select v37, v18 from aggView5004222233276862744 where v18= 'Horror');
create or replace view aggJoin3637631749728997914 as (
with aggView8533569373186501038 as (select v37, MIN(v18) as v49 from aggJoin8075040791229692795 group by v37)
select v38, v37, v49 from aggView753162820189495578 join aggView8533569373186501038 using(v37));
create or replace view aggJoin399770473138817303 as (
with aggView1309866590609261845 as (select v37, MIN(v23) as v50 from aggView5696795960875447608 group by v37)
select v38, v37, v49 as v49, v50 from aggJoin3637631749728997914 join aggView1309866590609261845 using(v37));
create or replace view aggJoin6398990276865658098 as (
with aggView1401593128545195611 as (select v37, MIN(v49) as v49, MIN(v50) as v50, MIN(v38) as v52 from aggJoin399770473138817303 group by v37,v49,v50)
select person_id as v28, movie_id as v37, note as v5, v49, v50, v52 from cast_info as ci, aggView1401593128545195611 where ci.movie_id=aggView1401593128545195611.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin2691377280838100961 as (
with aggView2948943325862477437 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView2948943325862477437 where mk.keyword_id=aggView2948943325862477437.v12);
create or replace view aggJoin8517164011291265222 as (
with aggView2266937046826596016 as (select v37 from aggJoin2691377280838100961 group by v37)
select v28, v5, v49 as v49, v50 as v50, v52 as v52 from aggJoin6398990276865658098 join aggView2266937046826596016 using(v37));
create or replace view aggJoin3882988498256848090 as (
with aggView3007567373345344544 as (select v28, MIN(v49) as v49, MIN(v50) as v50, MIN(v52) as v52 from aggJoin8517164011291265222 group by v28,v49,v50,v52)
select v29, v49, v50, v52 from aggView8412408445117766077 join aggView3007567373345344544 using(v28));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v29) as v51,MIN(v52) as v52 from aggJoin3882988498256848090;
