create or replace view aggView2717770939769707066 as select id as v31, title as v32 from title as t;
create or replace view aggJoin959880527013440346 as (
with aggView9080286577507525294 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView9080286577507525294 where mi_idx.info_type_id=aggView9080286577507525294.v10);
create or replace view aggView7327793139599160656 as select v20, v31 from aggJoin959880527013440346 group by v20,v31;
create or replace view aggJoin6105204962144657540 as (
with aggView2021781053444138482 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select movie_id as v31, note as v5 from cast_info as ci, aggView2021781053444138482 where ci.person_id=aggView2021781053444138482.v22 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin7339588919580149404 as (
with aggView8283481581102235421 as (select v31 from aggJoin6105204962144657540 group by v31)
select movie_id as v31, info_type_id as v8, info as v15 from movie_info as mi, aggView8283481581102235421 where mi.movie_id=aggView8283481581102235421.v31);
create or replace view aggJoin7524102815599008282 as (
with aggView4846135183522383708 as (select id as v8 from info_type as it1 where info= 'budget')
select v31, v15 from aggJoin7339588919580149404 join aggView4846135183522383708 using(v8));
create or replace view aggView6556244674090325851 as select v15, v31 from aggJoin7524102815599008282 group by v15,v31;
create or replace view aggJoin6839523957156100870 as (
with aggView7055657779608202686 as (select v31, MIN(v20) as v44 from aggView7327793139599160656 group by v31)
select v31, v32, v44 from aggView2717770939769707066 join aggView7055657779608202686 using(v31));
create or replace view aggJoin3335071716899683708 as (
with aggView3763425100575621580 as (select v31, MIN(v44) as v44, MIN(v32) as v45 from aggJoin6839523957156100870 group by v31,v44)
select v15, v44, v45 from aggView6556244674090325851 join aggView3763425100575621580 using(v31));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3335071716899683708;
