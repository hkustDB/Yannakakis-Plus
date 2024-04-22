create or replace view aggView3726469992478019097 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin1150190252577221056 as (
with aggView995662426308208012 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView995662426308208012 where mi_idx.info_type_id=aggView995662426308208012.v26 and info>'7.0');
create or replace view aggView4596467129192182134 as select v29, v27 from aggJoin1150190252577221056 group by v29,v27;
create or replace view aggJoin3021803052636241173 as (
with aggView3395204775803889671 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView3395204775803889671 where mi.info_type_id=aggView3395204775803889671.v21 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin8065094198198073027 as (
with aggView2601965129251497451 as (select v29 from aggJoin3021803052636241173 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView2601965129251497451 where t.id=aggView2601965129251497451.v29 and production_year>=2000 and production_year<=2010);
create or replace view aggView5017873590183213586 as select v29, v30 from aggJoin8065094198198073027 group by v29,v30;
create or replace view aggJoin543065488555934872 as (
with aggView2523760529454389242 as (select v29, MIN(v30) as v43 from aggView5017873590183213586 group by v29)
select v29, v27, v43 from aggView4596467129192182134 join aggView2523760529454389242 using(v29));
create or replace view aggJoin6110056287893118674 as (
with aggView5123768564761879060 as (select v29, MIN(v43) as v43, MIN(v27) as v42 from aggJoin543065488555934872 group by v29,v43)
select company_id as v1, company_type_id as v8, v43, v42 from movie_companies as mc, aggView5123768564761879060 where mc.movie_id=aggView5123768564761879060.v29);
create or replace view aggJoin4467313790319078460 as (
with aggView3821999505656860398 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v43, v42 from aggJoin6110056287893118674 join aggView3821999505656860398 using(v8));
create or replace view aggJoin1517778346276118677 as (
with aggView8838742601048605516 as (select v1, MIN(v43) as v43, MIN(v42) as v42 from aggJoin4467313790319078460 group by v1,v42,v43)
select v2, v43, v42 from aggView3726469992478019097 join aggView8838742601048605516 using(v1));
select MIN(v2) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin1517778346276118677;
