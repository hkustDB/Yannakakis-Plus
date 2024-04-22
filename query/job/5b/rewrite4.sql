create or replace view aggJoin2738530693777629605 as (
with aggView860772884007731545 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView860772884007731545 where mc.company_type_id=aggView860772884007731545.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%');
create or replace view aggJoin652445921819124978 as (
with aggView5386519804710735992 as (select v15 from aggJoin2738530693777629605 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView5386519804710735992 where t.id=aggView5386519804710735992.v15 and production_year>2010);
create or replace view aggJoin6137222029400490791 as (
with aggView6248398581618507946 as (select v15, MIN(v16) as v27 from aggJoin652445921819124978 group by v15)
select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView6248398581618507946 where mi.movie_id=aggView6248398581618507946.v15 and info IN ('USA','America'));
create or replace view aggJoin4465354722981018657 as (
with aggView5219589508680375877 as (select id as v3 from info_type as it)
select v27 from aggJoin6137222029400490791 join aggView5219589508680375877 using(v3));
select MIN(v27) as v27 from aggJoin4465354722981018657;
