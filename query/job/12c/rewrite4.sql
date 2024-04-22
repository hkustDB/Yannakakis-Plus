create or replace view aggView8944400124012743294 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggView6746466570225469736 as select id as v29, title as v30 from title as t where production_year>=2000 and production_year<=2010;
create or replace view aggJoin749948120250923203 as (
with aggView7370039029263536641 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView7370039029263536641 where mi_idx.info_type_id=aggView7370039029263536641.v26);
create or replace view aggJoin4752225675951216388 as (
with aggView111397093349668739 as (select v29, v27 from aggJoin749948120250923203 group by v29,v27)
select v29, v27 from aggView111397093349668739 where v27>'7.0');
create or replace view aggJoin2828525156565676526 as (
with aggView9079743502599456142 as (select v1, MIN(v2) as v41 from aggView8944400124012743294 group by v1)
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView9079743502599456142 where mc.company_id=aggView9079743502599456142.v1);
create or replace view aggJoin3651321120175089406 as (
with aggView392958808381012342 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin2828525156565676526 join aggView392958808381012342 using(v8));
create or replace view aggJoin2285329327769235539 as (
with aggView3757688080941590596 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView3757688080941590596 where mi.info_type_id=aggView3757688080941590596.v21 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin8716430878222376079 as (
with aggView8614064021185471904 as (select v29 from aggJoin2285329327769235539 group by v29)
select v29, v41 as v41 from aggJoin3651321120175089406 join aggView8614064021185471904 using(v29));
create or replace view aggJoin7458526543673255330 as (
with aggView8229818079127109374 as (select v29, MIN(v41) as v41 from aggJoin8716430878222376079 group by v29,v41)
select v29, v30, v41 from aggView6746466570225469736 join aggView8229818079127109374 using(v29));
create or replace view aggJoin1981610573511681149 as (
with aggView5827444106432979747 as (select v29, MIN(v41) as v41, MIN(v30) as v43 from aggJoin7458526543673255330 group by v29,v41)
select v27, v41, v43 from aggJoin4752225675951216388 join aggView5827444106432979747 using(v29));
select MIN(v41) as v41,MIN(v27) as v42,MIN(v43) as v43 from aggJoin1981610573511681149;
