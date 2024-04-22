create or replace view aggView3066089052220048604 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin466577286636296577 as (
with aggView4328344346228113898 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView4328344346228113898 where mi_idx.info_type_id=aggView4328344346228113898.v26 and info>'7.0');
create or replace view aggView1633953243581063708 as select v29, v27 from aggJoin466577286636296577 group by v29,v27;
create or replace view aggJoin4034171792159199289 as (
with aggView5105571493772567466 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView5105571493772567466 where mi.info_type_id=aggView5105571493772567466.v21 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin1581198819568723486 as (
with aggView5643207404279908426 as (select v29 from aggJoin4034171792159199289 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView5643207404279908426 where t.id=aggView5643207404279908426.v29 and production_year>=2000 and production_year<=2010);
create or replace view aggView3245258106577250069 as select v29, v30 from aggJoin1581198819568723486 group by v29,v30;
create or replace view aggJoin338805972665380263 as (
with aggView2183907948621896056 as (select v1, MIN(v2) as v41 from aggView3066089052220048604 group by v1)
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView2183907948621896056 where mc.company_id=aggView2183907948621896056.v1);
create or replace view aggJoin633065969254041380 as (
with aggView8053348158929775988 as (select v29, MIN(v27) as v42 from aggView1633953243581063708 group by v29)
select v29, v8, v41 as v41, v42 from aggJoin338805972665380263 join aggView8053348158929775988 using(v29));
create or replace view aggJoin6300696008033235356 as (
with aggView7024812461866286536 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41, v42 from aggJoin633065969254041380 join aggView7024812461866286536 using(v8));
create or replace view aggJoin8158147886722576227 as (
with aggView1712421207802073046 as (select v29, MIN(v41) as v41, MIN(v42) as v42 from aggJoin6300696008033235356 group by v29,v42,v41)
select v30, v41, v42 from aggView3245258106577250069 join aggView1712421207802073046 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v30) as v43 from aggJoin8158147886722576227;
