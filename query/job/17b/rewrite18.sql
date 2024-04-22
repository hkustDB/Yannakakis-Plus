create or replace view aggJoin3910240323342114863 as (
with aggView9084687396541590092 as (select id as v26, name as v47 from name as n where name LIKE 'Z%')
select movie_id as v3, v47 from cast_info as ci, aggView9084687396541590092 where ci.person_id=aggView9084687396541590092.v26);
create or replace view aggJoin795065442676823200 as (
with aggView2869033101606485084 as (select id as v3 from title as t)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView2869033101606485084 where mk.movie_id=aggView2869033101606485084.v3);
create or replace view aggJoin1315403169788343928 as (
with aggView8496885314974603168 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView8496885314974603168 where mc.company_id=aggView8496885314974603168.v20);
create or replace view aggJoin5441271584913706463 as (
with aggView3164061051661107536 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin795065442676823200 join aggView3164061051661107536 using(v25));
create or replace view aggJoin1103024358075292490 as (
with aggView2989950108434404573 as (select v3 from aggJoin1315403169788343928 group by v3)
select v3 from aggJoin5441271584913706463 join aggView2989950108434404573 using(v3));
create or replace view aggJoin3996197302882054694 as (
with aggView5835976320709518893 as (select v3 from aggJoin1103024358075292490 group by v3)
select v47 as v47 from aggJoin3910240323342114863 join aggView5835976320709518893 using(v3));
select MIN(v47) as v47 from aggJoin3996197302882054694;
