create or replace view aggJoin1323323563674275625 as (
with aggView1768830266167259001 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView1768830266167259001 where mc.company_id=aggView1768830266167259001.v1);
create or replace view aggJoin6741908997557417116 as (
with aggView5512799727058779490 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin1323323563674275625 join aggView5512799727058779490 using(v8));
create or replace view aggJoin1619242783259622153 as (
with aggView7292477763566909719 as (select v22, MIN(v43) as v43 from aggJoin6741908997557417116 group by v22,v43)
select id as v22, title as v32, kind_id as v14, v43 from title as t, aggView7292477763566909719 where t.id=aggView7292477763566909719.v22 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggJoin1888352189825334319 as (
with aggView8999599356048459430 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView8999599356048459430 where miidx.info_type_id=aggView8999599356048459430.v10);
create or replace view aggJoin8253063348154163759 as (
with aggView3990701400553948993 as (select v22, MIN(v29) as v44 from aggJoin1888352189825334319 group by v22)
select v22, v32, v14, v43 as v43, v44 from aggJoin1619242783259622153 join aggView3990701400553948993 using(v22));
create or replace view aggJoin5485539076438849771 as (
with aggView3128101005603693655 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView3128101005603693655 where mi.info_type_id=aggView3128101005603693655.v12);
create or replace view aggJoin7512110995208089028 as (
with aggView1005368516617126007 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32, v43, v44 from aggJoin8253063348154163759 join aggView1005368516617126007 using(v14));
create or replace view aggJoin1624078916154313362 as (
with aggView8838037344088490546 as (select v22, MIN(v43) as v43, MIN(v44) as v44, MIN(v32) as v45 from aggJoin7512110995208089028 group by v22,v44,v43)
select v43, v44, v45 from aggJoin5485539076438849771 join aggView8838037344088490546 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1624078916154313362;
