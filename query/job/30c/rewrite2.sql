create or replace view aggView5485155697997713740 as select id as v36, name as v37 from name as n where gender= 'm';
create or replace view aggJoin4690210008565343769 as (
with aggView465720000555133980 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView465720000555133980 where mk.keyword_id=aggView465720000555133980.v20);
create or replace view aggJoin8341596626637600771 as (
with aggView2231649159620607662 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView2231649159620607662 where cc.status_id=aggView2231649159620607662.v7);
create or replace view aggJoin4430471766592959490 as (
with aggView8519749882087960414 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView8519749882087960414 where mi.info_type_id=aggView8519749882087960414.v16 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggView5412549359718202704 as select v45, v26 from aggJoin4430471766592959490 group by v45,v26;
create or replace view aggJoin7081564995694297528 as (
with aggView8619151922504600398 as (select v45 from aggJoin4690210008565343769 group by v45)
select v45, v5 from aggJoin8341596626637600771 join aggView8619151922504600398 using(v45));
create or replace view aggJoin8287771428816566376 as (
with aggView3659641969668628596 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin7081564995694297528 join aggView3659641969668628596 using(v5));
create or replace view aggJoin1403069671293893716 as (
with aggView3439039229345337826 as (select v45 from aggJoin8287771428816566376 group by v45)
select id as v45, title as v46 from title as t, aggView3439039229345337826 where t.id=aggView3439039229345337826.v45);
create or replace view aggView7476665114061771762 as select v45, v46 from aggJoin1403069671293893716 group by v45,v46;
create or replace view aggJoin1870952609499207485 as (
with aggView7960693622849473445 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView7960693622849473445 where mi_idx.info_type_id=aggView7960693622849473445.v18);
create or replace view aggView2566358088315275994 as select v45, v31 from aggJoin1870952609499207485 group by v45,v31;
create or replace view aggJoin2684707563449327497 as (
with aggView8945308218827327630 as (select v45, MIN(v31) as v58 from aggView2566358088315275994 group by v45)
select v45, v46, v58 from aggView7476665114061771762 join aggView8945308218827327630 using(v45));
create or replace view aggJoin5961334968286969818 as (
with aggView7595159373321879619 as (select v36, MIN(v37) as v59 from aggView5485155697997713740 group by v36)
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView7595159373321879619 where ci.person_id=aggView7595159373321879619.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6960220665932101725 as (
with aggView3744949847559503893 as (select v45, MIN(v59) as v59 from aggJoin5961334968286969818 group by v45,v59)
select v45, v46, v58 as v58, v59 from aggJoin2684707563449327497 join aggView3744949847559503893 using(v45));
create or replace view aggJoin1847671847578714747 as (
with aggView2496130871322802728 as (select v45, MIN(v58) as v58, MIN(v59) as v59, MIN(v46) as v60 from aggJoin6960220665932101725 group by v45,v59,v58)
select v26, v58, v59, v60 from aggView5412549359718202704 join aggView2496130871322802728 using(v45));
select MIN(v26) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin1847671847578714747;
