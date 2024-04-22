create or replace view aggJoin7080330881998432535 as (
with aggView8230064052076510717 as (select id as v11, title as v56 from title as t where episode_nr>=50 and episode_nr<100)
select movie_id as v11, keyword_id as v33, v56 from movie_keyword as mk, aggView8230064052076510717 where mk.movie_id=aggView8230064052076510717.v11);
create or replace view aggJoin6664731708371481180 as (
with aggView6377154644012645507 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView6377154644012645507 where ci.person_id=aggView6377154644012645507.v2);
create or replace view aggJoin9086524177578972003 as (
with aggView6933749001024430276 as (select id as v2 from name as n)
select v11, v55 from aggJoin6664731708371481180 join aggView6933749001024430276 using(v2));
create or replace view aggJoin4510385063658279970 as (
with aggView4345304386890821739 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView4345304386890821739 where mc.company_id=aggView4345304386890821739.v28);
create or replace view aggJoin6622437255484217483 as (
with aggView821458160797054076 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select v11, v56 from aggJoin7080330881998432535 join aggView821458160797054076 using(v33));
create or replace view aggJoin5483227954096034509 as (
with aggView9160064674555848178 as (select v11 from aggJoin4510385063658279970 group by v11)
select v11, v56 as v56 from aggJoin6622437255484217483 join aggView9160064674555848178 using(v11));
create or replace view aggJoin8097806609996805602 as (
with aggView5228637501959891852 as (select v11, MIN(v56) as v56 from aggJoin5483227954096034509 group by v11,v56)
select v55 as v55, v56 from aggJoin9086524177578972003 join aggView5228637501959891852 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin8097806609996805602;
