create or replace view aggJoin1915591491861447313 as (
with aggView986214161472222257 as (select id as v31, title as v45 from title as t)
select movie_id as v31, info_type_id as v10, info as v20, v45 from movie_info_idx as mi_idx, aggView986214161472222257 where mi_idx.movie_id=aggView986214161472222257.v31);
create or replace view aggJoin7952566652286520838 as (
with aggView2378078082308813603 as (select id as v10 from info_type as it2 where info= 'votes')
select v31, v20, v45 from aggJoin1915591491861447313 join aggView2378078082308813603 using(v10));
create or replace view aggJoin1689638466428130738 as (
with aggView5387384397687943639 as (select v31, MIN(v45) as v45, MIN(v20) as v44 from aggJoin7952566652286520838 group by v31,v45)
select movie_id as v31, info_type_id as v8, info as v15, v45, v44 from movie_info as mi, aggView5387384397687943639 where mi.movie_id=aggView5387384397687943639.v31);
create or replace view aggJoin6305711999714649351 as (
with aggView286541344413164936 as (select id as v22 from name as n where gender= 'm' and name LIKE '%Tim%')
select movie_id as v31, note as v5 from cast_info as ci, aggView286541344413164936 where ci.person_id=aggView286541344413164936.v22 and note IN ('(producer)','(executive producer)'));
create or replace view aggJoin9022718204023262329 as (
with aggView5206878100256844103 as (select v31 from aggJoin6305711999714649351 group by v31)
select v8, v15, v45 as v45, v44 as v44 from aggJoin1689638466428130738 join aggView5206878100256844103 using(v31));
create or replace view aggJoin1754345617354237356 as (
with aggView2080027557968627372 as (select id as v8 from info_type as it1 where info= 'budget')
select v15, v45, v44 from aggJoin9022718204023262329 join aggView2080027557968627372 using(v8));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1754345617354237356;
