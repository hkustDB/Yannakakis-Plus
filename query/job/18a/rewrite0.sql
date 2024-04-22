create or replace view aggJoin3652996774422035328 as (
with aggView2119676388265194360 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView2119676388265194360 where mi_idx.info_type_id=aggView2119676388265194360.v10);
create or replace view aggView196825761640876037 as select v20, v31 from aggJoin3652996774422035328 group by v20,v31;
create or replace view aggJoin6645955195371655123 as (
with aggView5433779618315739270 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select movie_id as v31, note as v5 from cast_info as ci, aggView5433779618315739270 where ci.person_id=aggView5433779618315739270.v22 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin7029425370829282452 as (
with aggView1329491554599594545 as (select id as v8 from info_type as it1 where info= 'budget')
select movie_id as v31, info as v15 from movie_info as mi, aggView1329491554599594545 where mi.info_type_id=aggView1329491554599594545.v8);
create or replace view aggView29424063194242545 as select v15, v31 from aggJoin7029425370829282452 group by v15,v31;
create or replace view aggJoin6523286356341596070 as (
with aggView5682273266021275655 as (select v31 from aggJoin6645955195371655123 group by v31)
select id as v31, title as v32 from title as t, aggView5682273266021275655 where t.id=aggView5682273266021275655.v31);
create or replace view aggView1102981356076677847 as select v31, v32 from aggJoin6523286356341596070 group by v31,v32;
create or replace view aggJoin1884055536409087959 as (
with aggView7758043258223154378 as (select v31, MIN(v32) as v45 from aggView1102981356076677847 group by v31)
select v15, v31, v45 from aggView29424063194242545 join aggView7758043258223154378 using(v31));
create or replace view aggJoin4887233764521269253 as (
with aggView8618261005281120559 as (select v31, MIN(v45) as v45, MIN(v15) as v43 from aggJoin1884055536409087959 group by v31,v45)
select v20, v45, v43 from aggView196825761640876037 join aggView8618261005281120559 using(v31));
select MIN(v43) as v43,MIN(v20) as v44,MIN(v45) as v45 from aggJoin4887233764521269253;
