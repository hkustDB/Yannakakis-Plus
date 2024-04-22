create or replace view aggJoin2507516244084144257 as (
with aggView4012391518178169606 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView4012391518178169606 where ci.person_id=aggView4012391518178169606.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3212325349547862591 as (
with aggView3815388059838644587 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView3815388059838644587 where mi_idx.info_type_id=aggView3815388059838644587.v10 and info>'8.0');
create or replace view aggJoin4639185478366668053 as (
with aggView6061468948347691985 as (select v31, MIN(v20) as v44 from aggJoin3212325349547862591 group by v31)
select movie_id as v31, info_type_id as v8, info as v15, v44 from movie_info as mi, aggView6061468948347691985 where mi.movie_id=aggView6061468948347691985.v31 and info IN ('Horror','Thriller'));
create or replace view aggJoin4216495161262747057 as (
with aggView43169866272301911 as (select id as v8 from info_type as it1 where info= 'genres')
select v31, v15, v44 from aggJoin4639185478366668053 join aggView43169866272301911 using(v8));
create or replace view aggJoin1210303161173533317 as (
with aggView5123957988387441355 as (select v31, MIN(v44) as v44, MIN(v15) as v43 from aggJoin4216495161262747057 group by v31,v44)
select id as v31, title as v32, production_year as v35, v44, v43 from title as t, aggView5123957988387441355 where t.id=aggView5123957988387441355.v31 and production_year>=2008 and production_year<=2014);
create or replace view aggJoin2481485411569926008 as (
with aggView9066536296779574879 as (select v31, MIN(v44) as v44, MIN(v43) as v43, MIN(v32) as v45 from aggJoin1210303161173533317 group by v31,v43,v44)
select v44, v43, v45 from aggJoin2507516244084144257 join aggView9066536296779574879 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin2481485411569926008;
