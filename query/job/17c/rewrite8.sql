create or replace view aggJoin8293810545286351777 as (
with aggView3579390487720699309 as (select id as v3 from title as t)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView3579390487720699309 where mc.movie_id=aggView3579390487720699309.v3);
create or replace view aggJoin3242298001788502180 as (
with aggView6225632527737321352 as (select id as v20 from company_name as cn)
select v3 from aggJoin8293810545286351777 join aggView6225632527737321352 using(v20));
create or replace view aggJoin1483199540954157375 as (
with aggView8723323481117865557 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView8723323481117865557 where mk.keyword_id=aggView8723323481117865557.v25);
create or replace view aggJoin7316537223360287286 as (
with aggView474703053346625370 as (select v3 from aggJoin3242298001788502180 group by v3)
select v3 from aggJoin1483199540954157375 join aggView474703053346625370 using(v3));
create or replace view aggJoin5545055544925204397 as (
with aggView1588343786180502694 as (select v3 from aggJoin7316537223360287286 group by v3)
select person_id as v26 from cast_info as ci, aggView1588343786180502694 where ci.movie_id=aggView1588343786180502694.v3);
create or replace view aggJoin6496440150482911161 as (
with aggView5553862592668252 as (select v26 from aggJoin5545055544925204397 group by v26)
select name as v27 from name as n, aggView5553862592668252 where n.id=aggView5553862592668252.v26 and name LIKE 'X%');
create or replace view aggView8474543330146962547 as select v27 from aggJoin6496440150482911161 group by v27;
select MIN(v27) as v47 from aggView8474543330146962547;
