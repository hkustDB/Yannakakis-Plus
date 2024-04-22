create or replace view aggJoin8242282063120906664 as (
with aggView5512820678578912289 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView5512820678578912289 where mi_idx.info_type_id=aggView5512820678578912289.v10);
create or replace view aggJoin4942073750014098419 as (
with aggView5628367685603375873 as (select v31, MIN(v20) as v44 from aggJoin8242282063120906664 group by v31)
select person_id as v22, movie_id as v31, note as v5, v44 from cast_info as ci, aggView5628367685603375873 where ci.movie_id=aggView5628367685603375873.v31 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin6260834069002240063 as (
with aggView3091528494521357992 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select v31, v5, v44 from aggJoin4942073750014098419 join aggView3091528494521357992 using(v22));
create or replace view aggJoin2612395279267820813 as (
with aggView2787813028549633161 as (select id as v8 from info_type as it1 where info= 'budget')
select movie_id as v31, info as v15 from movie_info as mi, aggView2787813028549633161 where mi.info_type_id=aggView2787813028549633161.v8);
create or replace view aggJoin3993914742821072708 as (
with aggView7765204357089073057 as (select v31, MIN(v44) as v44 from aggJoin6260834069002240063 group by v31,v44)
select id as v31, title as v32, v44 from title as t, aggView7765204357089073057 where t.id=aggView7765204357089073057.v31);
create or replace view aggJoin898729128651344169 as (
with aggView3828739323533577287 as (select v31, MIN(v44) as v44, MIN(v32) as v45 from aggJoin3993914742821072708 group by v31,v44)
select v15, v44, v45 from aggJoin2612395279267820813 join aggView3828739323533577287 using(v31));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin898729128651344169;
