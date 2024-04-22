create or replace view aggJoin3100867958643090990 as (
with aggView4037760148231849224 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView4037760148231849224 where mc.company_type_id=aggView4037760148231849224.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%');
create or replace view aggJoin1969116875253307808 as (
with aggView699522887534616220 as (select id as v3 from info_type as it)
select movie_id as v15, info as v13 from movie_info as mi, aggView699522887534616220 where mi.info_type_id=aggView699522887534616220.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view aggJoin727332218081012333 as (
with aggView2730700034258615398 as (select v15 from aggJoin1969116875253307808 group by v15)
select v15, v9 from aggJoin3100867958643090990 join aggView2730700034258615398 using(v15));
create or replace view aggJoin6946673686951299299 as (
with aggView8813410347874912324 as (select v15 from aggJoin727332218081012333 group by v15)
select title as v16 from title as t, aggView8813410347874912324 where t.id=aggView8813410347874912324.v15 and production_year>2005);
select MIN(v16) as v27 from aggJoin6946673686951299299;
