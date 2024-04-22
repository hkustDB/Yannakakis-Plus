create or replace view aggJoin1574127383859291223 as (
with aggView8126427052934746245 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView8126427052934746245 where mc.company_id=aggView8126427052934746245.v20);
create or replace view aggJoin545876345597011217 as (
with aggView2065187750277708407 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView2065187750277708407 where mk.keyword_id=aggView2065187750277708407.v25);
create or replace view aggJoin4681599052161239052 as (
with aggView8960770003023776126 as (select id as v3 from title as t)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView8960770003023776126 where ci.movie_id=aggView8960770003023776126.v3);
create or replace view aggJoin1781080546212299950 as (
with aggView7327716089950681255 as (select v3 from aggJoin545876345597011217 group by v3)
select v3 from aggJoin1574127383859291223 join aggView7327716089950681255 using(v3));
create or replace view aggJoin7154068570215658779 as (
with aggView8323405207264815913 as (select v3 from aggJoin1781080546212299950 group by v3)
select v26 from aggJoin4681599052161239052 join aggView8323405207264815913 using(v3));
create or replace view aggJoin6795177290302651321 as (
with aggView3147375589654405091 as (select v26 from aggJoin7154068570215658779 group by v26)
select name as v27 from name as n, aggView3147375589654405091 where n.id=aggView3147375589654405091.v26);
create or replace view aggJoin2199009147991040145 as (
with aggView272802400758091942 as (select v27 from aggJoin6795177290302651321 group by v27)
select v27 from aggView272802400758091942 where v27 LIKE 'Z%');
select MIN(v27) as v47 from aggJoin2199009147991040145;
