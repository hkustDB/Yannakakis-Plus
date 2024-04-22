create or replace view aggJoin567854721496210349 as (
with aggView1552010958332725472 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView1552010958332725472 where mc.company_id=aggView1552010958332725472.v1);
create or replace view aggJoin6126798509672735936 as (
with aggView953360745724511151 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView953360745724511151 where mi.info_type_id=aggView953360745724511151.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin7408167660584251059 as (
with aggView5042120170540836694 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin567854721496210349 join aggView5042120170540836694 using(v8));
create or replace view aggJoin7231788854245183924 as (
with aggView997897336739435339 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView997897336739435339 where mi_idx.info_type_id=aggView997897336739435339.v26 and info>'8.0');
create or replace view aggJoin7557585944122786278 as (
with aggView8506037823453174819 as (select v29, MIN(v27) as v42 from aggJoin7231788854245183924 group by v29)
select id as v29, title as v30, production_year as v33, v42 from title as t, aggView8506037823453174819 where t.id=aggView8506037823453174819.v29 and production_year<=2008 and production_year>=2005);
create or replace view aggJoin6376277789697112497 as (
with aggView5665175505684656385 as (select v29, MIN(v42) as v42, MIN(v30) as v43 from aggJoin7557585944122786278 group by v29,v42)
select v29, v22, v42, v43 from aggJoin6126798509672735936 join aggView5665175505684656385 using(v29));
create or replace view aggJoin3563689767674713014 as (
with aggView3898199406293084634 as (select v29, MIN(v42) as v42, MIN(v43) as v43 from aggJoin6376277789697112497 group by v29,v43,v42)
select v41 as v41, v42, v43 from aggJoin7408167660584251059 join aggView3898199406293084634 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin3563689767674713014;
