create or replace view aggJoin448215194377037279 as (
with aggView3778887799413438628 as (select id as v31, title as v45 from title as t where production_year>=2008 and production_year<=2014)
select movie_id as v31, info_type_id as v8, info as v15, v45 from movie_info as mi, aggView3778887799413438628 where mi.movie_id=aggView3778887799413438628.v31 and info IN ('Horror','Thriller'));
create or replace view aggJoin432712462415032977 as (
with aggView2887296480957404922 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView2887296480957404922 where ci.person_id=aggView2887296480957404922.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5802616320160071300 as (
with aggView4079570850894227573 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView4079570850894227573 where mi_idx.info_type_id=aggView4079570850894227573.v10 and info>'8.0');
create or replace view aggJoin6805324495187265100 as (
with aggView5380346516948259709 as (select v31, MIN(v20) as v44 from aggJoin5802616320160071300 group by v31)
select v31, v5, v44 from aggJoin432712462415032977 join aggView5380346516948259709 using(v31));
create or replace view aggJoin6985091106894865297 as (
with aggView4278060380026042938 as (select id as v8 from info_type as it1 where info= 'genres')
select v31, v15, v45 from aggJoin448215194377037279 join aggView4278060380026042938 using(v8));
create or replace view aggJoin365253864107593559 as (
with aggView8434840067217644474 as (select v31, MIN(v45) as v45, MIN(v15) as v43 from aggJoin6985091106894865297 group by v31,v45)
select v44 as v44, v45, v43 from aggJoin6805324495187265100 join aggView8434840067217644474 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin365253864107593559;
