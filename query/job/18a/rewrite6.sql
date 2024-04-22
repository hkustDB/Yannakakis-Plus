create or replace view aggView1255824413978845478 as select id as v31, title as v32 from title as t;
create or replace view aggJoin8830958658819180553 as (
with aggView8938202281133886866 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView8938202281133886866 where mi_idx.info_type_id=aggView8938202281133886866.v10);
create or replace view aggJoin2801830456465257365 as (
with aggView8283352456407740524 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select movie_id as v31, note as v5 from cast_info as ci, aggView8283352456407740524 where ci.person_id=aggView8283352456407740524.v22 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin3305823372600047222 as (
with aggView7676167979065279801 as (select v31 from aggJoin2801830456465257365 group by v31)
select v31, v20 from aggJoin8830958658819180553 join aggView7676167979065279801 using(v31));
create or replace view aggView2631112263852446023 as select v20, v31 from aggJoin3305823372600047222 group by v20,v31;
create or replace view aggJoin7394439663740123943 as (
with aggView4658227901551591775 as (select id as v8 from info_type as it1 where info= 'budget')
select movie_id as v31, info as v15 from movie_info as mi, aggView4658227901551591775 where mi.info_type_id=aggView4658227901551591775.v8);
create or replace view aggView2433515597142570527 as select v15, v31 from aggJoin7394439663740123943 group by v15,v31;
create or replace view aggJoin436040900296327920 as (
with aggView8871474391248707834 as (select v31, MIN(v32) as v45 from aggView1255824413978845478 group by v31)
select v15, v31, v45 from aggView2433515597142570527 join aggView8871474391248707834 using(v31));
create or replace view aggJoin765326293181066280 as (
with aggView2472014165769908707 as (select v31, MIN(v45) as v45, MIN(v15) as v43 from aggJoin436040900296327920 group by v31,v45)
select v20, v45, v43 from aggView2631112263852446023 join aggView2472014165769908707 using(v31));
select MIN(v43) as v43,MIN(v20) as v44,MIN(v45) as v45 from aggJoin765326293181066280;
