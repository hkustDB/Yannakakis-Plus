create or replace view aggView5550818719965930126 as select title as v38, id as v37 from title as t;
create or replace view aggView6058755913233537700 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin7795046982328894794 as (
with aggView1831012967314275392 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView1831012967314275392 where mi_idx.info_type_id=aggView1831012967314275392.v10);
create or replace view aggJoin1128884616420123883 as (
with aggView2140131627766225517 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView2140131627766225517 where mk.keyword_id=aggView2140131627766225517.v12);
create or replace view aggJoin2432386901896755682 as (
with aggView599895956355157444 as (select v37 from aggJoin1128884616420123883 group by v37)
select v37, v23 from aggJoin7795046982328894794 join aggView599895956355157444 using(v37));
create or replace view aggView1485634064349386092 as select v23, v37 from aggJoin2432386901896755682 group by v23,v37;
create or replace view aggJoin4744784257358731733 as (
with aggView3342925141556184806 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView3342925141556184806 where mi.info_type_id=aggView3342925141556184806.v8);
create or replace view aggJoin5359643986327707404 as (
with aggView8009597388925728801 as (select v18, v37 from aggJoin4744784257358731733 group by v18,v37)
select v37, v18 from aggView8009597388925728801 where v18= 'Horror');
create or replace view aggJoin123903619376926964 as (
with aggView2347899253121253097 as (select v28, MIN(v29) as v51 from aggView6058755913233537700 group by v28)
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView2347899253121253097 where ci.person_id=aggView2347899253121253097.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin511912096609330100 as (
with aggView6126101583442487737 as (select v37, MIN(v23) as v50 from aggView1485634064349386092 group by v37)
select v37, v5, v51 as v51, v50 from aggJoin123903619376926964 join aggView6126101583442487737 using(v37));
create or replace view aggJoin2202774514360474633 as (
with aggView8093270816301583896 as (select v37, MIN(v38) as v52 from aggView5550818719965930126 group by v37)
select v37, v18, v52 from aggJoin5359643986327707404 join aggView8093270816301583896 using(v37));
create or replace view aggJoin2871091687909688986 as (
with aggView3483831243484021278 as (select v37, MIN(v51) as v51, MIN(v50) as v50 from aggJoin511912096609330100 group by v37,v51,v50)
select v18, v52 as v52, v51, v50 from aggJoin2202774514360474633 join aggView3483831243484021278 using(v37));
select MIN(v18) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin2871091687909688986;
