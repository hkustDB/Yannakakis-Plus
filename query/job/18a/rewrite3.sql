create or replace view aggJoin3559607764161422707 as (
with aggView7453460558425870703 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView7453460558425870703 where mi_idx.info_type_id=aggView7453460558425870703.v10);
create or replace view aggView6296521795733562865 as select v20, v31 from aggJoin3559607764161422707 group by v20,v31;
create or replace view aggJoin3556054359200518201 as (
with aggView6684986884047210799 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select movie_id as v31, note as v5 from cast_info as ci, aggView6684986884047210799 where ci.person_id=aggView6684986884047210799.v22 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin7216192048614335460 as (
with aggView4409750580134525937 as (select id as v8 from info_type as it1 where info= 'budget')
select movie_id as v31, info as v15 from movie_info as mi, aggView4409750580134525937 where mi.info_type_id=aggView4409750580134525937.v8);
create or replace view aggView8652620050318968688 as select v15, v31 from aggJoin7216192048614335460 group by v15,v31;
create or replace view aggJoin8766295403845243952 as (
with aggView6503632744333133657 as (select v31 from aggJoin3556054359200518201 group by v31)
select id as v31, title as v32 from title as t, aggView6503632744333133657 where t.id=aggView6503632744333133657.v31);
create or replace view aggView7670692955991652233 as select v31, v32 from aggJoin8766295403845243952 group by v31,v32;
create or replace view aggJoin4395438172763683983 as (
with aggView8818862142417100637 as (select v31, MIN(v20) as v44 from aggView6296521795733562865 group by v31)
select v31, v32, v44 from aggView7670692955991652233 join aggView8818862142417100637 using(v31));
create or replace view aggJoin2531913016843146092 as (
with aggView8625175951467090518 as (select v31, MIN(v44) as v44, MIN(v32) as v45 from aggJoin4395438172763683983 group by v31,v44)
select v15, v44, v45 from aggView8652620050318968688 join aggView8625175951467090518 using(v31));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin2531913016843146092;
