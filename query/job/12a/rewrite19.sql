create or replace view aggJoin7940767777261986874 as (
with aggView81864942020189837 as (select id as v29, title as v43 from title as t where production_year<=2008 and production_year>=2005)
select movie_id as v29, company_id as v1, company_type_id as v8, v43 from movie_companies as mc, aggView81864942020189837 where mc.movie_id=aggView81864942020189837.v29);
create or replace view aggJoin8588665592445623856 as (
with aggView2506650027326930831 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select v29, v8, v43, v41 from aggJoin7940767777261986874 join aggView2506650027326930831 using(v1));
create or replace view aggJoin1326216209157907247 as (
with aggView2385473052369332249 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView2385473052369332249 where mi.info_type_id=aggView2385473052369332249.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin6743559964560728920 as (
with aggView7637197749349604022 as (select v29 from aggJoin1326216209157907247 group by v29)
select movie_id as v29, info_type_id as v26, info as v27 from movie_info_idx as mi_idx, aggView7637197749349604022 where mi_idx.movie_id=aggView7637197749349604022.v29 and info>'8.0');
create or replace view aggJoin7068896320794274727 as (
with aggView5973609265395715047 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v43, v41 from aggJoin8588665592445623856 join aggView5973609265395715047 using(v8));
create or replace view aggJoin9090478586432322232 as (
with aggView4888660049062481470 as (select id as v26 from info_type as it2 where info= 'rating')
select v29, v27 from aggJoin6743559964560728920 join aggView4888660049062481470 using(v26));
create or replace view aggJoin7350305154264227928 as (
with aggView3248603943895083914 as (select v29, MIN(v27) as v42 from aggJoin9090478586432322232 group by v29)
select v43 as v43, v41 as v41, v42 from aggJoin7068896320794274727 join aggView3248603943895083914 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin7350305154264227928;
