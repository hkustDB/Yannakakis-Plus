create or replace view aggView1838953684861917253 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggView7774805307219600912 as select id as v29, title as v30 from title as t where production_year>=2000 and production_year<=2010;
create or replace view aggJoin922073144559050286 as (
with aggView1856486682303531568 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView1856486682303531568 where mi_idx.info_type_id=aggView1856486682303531568.v26);
create or replace view aggJoin3730666330977109335 as (
with aggView2784309845370643229 as (select v29, v27 from aggJoin922073144559050286 group by v29,v27)
select v29, v27 from aggView2784309845370643229 where v27>'7.0');
create or replace view aggJoin8808831104054337383 as (
with aggView1828426296862011604 as (select v29, MIN(v30) as v43 from aggView7774805307219600912 group by v29)
select v29, v27, v43 from aggJoin3730666330977109335 join aggView1828426296862011604 using(v29));
create or replace view aggJoin7977745979150377731 as (
with aggView3326852706585243650 as (select v29, MIN(v43) as v43, MIN(v27) as v42 from aggJoin8808831104054337383 group by v29,v43)
select movie_id as v29, company_id as v1, company_type_id as v8, v43, v42 from movie_companies as mc, aggView3326852706585243650 where mc.movie_id=aggView3326852706585243650.v29);
create or replace view aggJoin999057829661792966 as (
with aggView7284664982780002742 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v1, v43, v42 from aggJoin7977745979150377731 join aggView7284664982780002742 using(v8));
create or replace view aggJoin5689580673865033575 as (
with aggView1859406654208660695 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView1859406654208660695 where mi.info_type_id=aggView1859406654208660695.v21 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin1539970324958263297 as (
with aggView8475083646571996672 as (select v29 from aggJoin5689580673865033575 group by v29)
select v1, v43 as v43, v42 as v42 from aggJoin999057829661792966 join aggView8475083646571996672 using(v29));
create or replace view aggJoin5216168726047655936 as (
with aggView3226399477824083532 as (select v1, MIN(v43) as v43, MIN(v42) as v42 from aggJoin1539970324958263297 group by v1,v42,v43)
select v2, v43, v42 from aggView1838953684861917253 join aggView3226399477824083532 using(v1));
select MIN(v2) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin5216168726047655936;
