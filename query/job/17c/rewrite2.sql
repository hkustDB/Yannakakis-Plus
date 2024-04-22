create or replace view aggJoin8452505785649584129 as (
with aggView5998894857857473154 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView5998894857857473154 where mk.keyword_id=aggView5998894857857473154.v25);
create or replace view aggJoin7171465773590974337 as (
with aggView4589071990623548343 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView4589071990623548343 where mc.company_id=aggView4589071990623548343.v20);
create or replace view aggJoin2718499104541529823 as (
with aggView6119186485459389001 as (select v3 from aggJoin8452505785649584129 group by v3)
select id as v3 from title as t, aggView6119186485459389001 where t.id=aggView6119186485459389001.v3);
create or replace view aggJoin5457098129121794117 as (
with aggView3561782568521643980 as (select v3 from aggJoin2718499104541529823 group by v3)
select v3 from aggJoin7171465773590974337 join aggView3561782568521643980 using(v3));
create or replace view aggJoin9042426193636426477 as (
with aggView2980123041276724764 as (select v3 from aggJoin5457098129121794117 group by v3)
select person_id as v26 from cast_info as ci, aggView2980123041276724764 where ci.movie_id=aggView2980123041276724764.v3);
create or replace view aggJoin5333283411737624205 as (
with aggView6587427693239687386 as (select v26 from aggJoin9042426193636426477 group by v26)
select name as v27 from name as n, aggView6587427693239687386 where n.id=aggView6587427693239687386.v26 and name LIKE 'X%');
create or replace view aggView6068823047306041740 as select v27 from aggJoin5333283411737624205 group by v27;
select MIN(v27) as v47 from aggView6068823047306041740;
