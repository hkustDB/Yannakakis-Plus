create or replace view aggJoin449750357000855161 as (
with aggView2853101850068597057 as (select id as v31, name as v52 from name as n)
select movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView2853101850068597057 where ci.person_id=aggView2853101850068597057.v31);
create or replace view aggJoin7069010059770841724 as (
with aggView7089348626948897813 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v40, v52 from aggJoin449750357000855161 join aggView7089348626948897813 using(v9));
create or replace view aggJoin3351110261518753805 as (
with aggView3200906778190070211 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView3200906778190070211 where t.kind_id=aggView3200906778190070211.v26 and production_year>2000);
create or replace view aggJoin4973711122182938357 as (
with aggView5291572389167475309 as (select v40, MIN(v41) as v53 from aggJoin3351110261518753805 group by v40)
select movie_id as v40, keyword_id as v23, v53 from movie_keyword as mk, aggView5291572389167475309 where mk.movie_id=aggView5291572389167475309.v40);
create or replace view aggJoin1340982030886362816 as (
with aggView3802226934486839138 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView3802226934486839138 where cc.status_id=aggView3802226934486839138.v7);
create or replace view aggJoin2003659641288648961 as (
with aggView4517629026788766707 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select v40, v53 from aggJoin4973711122182938357 join aggView4517629026788766707 using(v23));
create or replace view aggJoin3772506511439197121 as (
with aggView5650507950863833257 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin1340982030886362816 join aggView5650507950863833257 using(v5));
create or replace view aggJoin3429280689793039089 as (
with aggView5059419223697107954 as (select v40 from aggJoin3772506511439197121 group by v40)
select v40, v53 as v53 from aggJoin2003659641288648961 join aggView5059419223697107954 using(v40));
create or replace view aggJoin5662571269164553033 as (
with aggView6699187540134439990 as (select v40, MIN(v53) as v53 from aggJoin3429280689793039089 group by v40,v53)
select v52 as v52, v53 from aggJoin7069010059770841724 join aggView6699187540134439990 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin5662571269164553033;
