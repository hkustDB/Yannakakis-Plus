create or replace view aggView8063249289662992016 as select id as v31, title as v32 from title as t;
create or replace view aggJoin5216865718266087167 as (
with aggView6883137667183846648 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView6883137667183846648 where mi_idx.info_type_id=aggView6883137667183846648.v10);
create or replace view aggJoin2210930352752718390 as (
with aggView8370304556001690369 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select movie_id as v31, note as v5 from cast_info as ci, aggView8370304556001690369 where ci.person_id=aggView8370304556001690369.v22 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin6040509753209776912 as (
with aggView5509710316759222428 as (select v31 from aggJoin2210930352752718390 group by v31)
select v31, v20 from aggJoin5216865718266087167 join aggView5509710316759222428 using(v31));
create or replace view aggView6804281917532513787 as select v20, v31 from aggJoin6040509753209776912 group by v20,v31;
create or replace view aggJoin4782325015687195798 as (
with aggView562385038409832274 as (select id as v8 from info_type as it1 where info= 'budget')
select movie_id as v31, info as v15 from movie_info as mi, aggView562385038409832274 where mi.info_type_id=aggView562385038409832274.v8);
create or replace view aggView230512748889160807 as select v15, v31 from aggJoin4782325015687195798 group by v15,v31;
create or replace view aggJoin3814112547562050095 as (
with aggView4889494116375806938 as (select v31, MIN(v15) as v43 from aggView230512748889160807 group by v31)
select v31, v32, v43 from aggView8063249289662992016 join aggView4889494116375806938 using(v31));
create or replace view aggJoin3959885088946136398 as (
with aggView8293566995914158276 as (select v31, MIN(v43) as v43, MIN(v32) as v45 from aggJoin3814112547562050095 group by v31,v43)
select v20, v43, v45 from aggView6804281917532513787 join aggView8293566995914158276 using(v31));
select MIN(v43) as v43,MIN(v20) as v44,MIN(v45) as v45 from aggJoin3959885088946136398;
