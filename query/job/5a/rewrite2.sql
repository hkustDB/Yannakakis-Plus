create or replace view aggJoin7991748876998972719 as (
with aggView1919318057193001342 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView1919318057193001342 where mc.company_type_id=aggView1919318057193001342.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%');
create or replace view aggJoin8330827525673529036 as (
with aggView7560250373836193685 as (select id as v3 from info_type as it)
select movie_id as v15, info as v13 from movie_info as mi, aggView7560250373836193685 where mi.info_type_id=aggView7560250373836193685.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view aggJoin862002275956365048 as (
with aggView3299037622271773292 as (select v15 from aggJoin8330827525673529036 group by v15)
select v15, v9 from aggJoin7991748876998972719 join aggView3299037622271773292 using(v15));
create or replace view aggJoin4829481498650266840 as (
with aggView9214130721435008396 as (select v15 from aggJoin862002275956365048 group by v15)
select title as v16, production_year as v19 from title as t, aggView9214130721435008396 where t.id=aggView9214130721435008396.v15 and production_year>2005);
create or replace view aggView4897274087240368113 as select v16 from aggJoin4829481498650266840 group by v16;
select MIN(v16) as v27 from aggView4897274087240368113;
