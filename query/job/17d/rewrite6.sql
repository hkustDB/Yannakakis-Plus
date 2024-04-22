create or replace view aggJoin5074092476276503559 as (
with aggView3020488886462806655 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView3020488886462806655 where mc.company_id=aggView3020488886462806655.v20);
create or replace view aggJoin842792870243362094 as (
with aggView2559918302256837125 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView2559918302256837125 where mk.keyword_id=aggView2559918302256837125.v25);
create or replace view aggJoin3436350429980583349 as (
with aggView5431401888451656939 as (select v3 from aggJoin842792870243362094 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView5431401888451656939 where ci.movie_id=aggView5431401888451656939.v3);
create or replace view aggJoin7056936390102624769 as (
with aggView6512583591245174539 as (select id as v3 from title as t)
select v3 from aggJoin5074092476276503559 join aggView6512583591245174539 using(v3));
create or replace view aggJoin4029359604582278587 as (
with aggView399323052662065813 as (select v3 from aggJoin7056936390102624769 group by v3)
select v26 from aggJoin3436350429980583349 join aggView399323052662065813 using(v3));
create or replace view aggJoin7004711242846265038 as (
with aggView3103334371011519148 as (select v26 from aggJoin4029359604582278587 group by v26)
select name as v27 from name as n, aggView3103334371011519148 where n.id=aggView3103334371011519148.v26 and name LIKE '%Bert%');
create or replace view aggView7945637915005152587 as select v27 from aggJoin7004711242846265038 group by v27;
select MIN(v27) as v47 from aggView7945637915005152587;
