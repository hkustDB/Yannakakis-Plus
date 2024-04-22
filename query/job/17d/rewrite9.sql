create or replace view aggJoin4005921877926402559 as (
with aggView2798843582198134409 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView2798843582198134409 where mc.company_id=aggView2798843582198134409.v20);
create or replace view aggJoin292603989997381454 as (
with aggView5262889798923959069 as (select v3 from aggJoin4005921877926402559 group by v3)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView5262889798923959069 where mk.movie_id=aggView5262889798923959069.v3);
create or replace view aggJoin2425090653832428487 as (
with aggView3503262948323646751 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin292603989997381454 join aggView3503262948323646751 using(v25));
create or replace view aggJoin7698438698505988792 as (
with aggView7867918783542544103 as (select v3 from aggJoin2425090653832428487 group by v3)
select id as v3 from title as t, aggView7867918783542544103 where t.id=aggView7867918783542544103.v3);
create or replace view aggJoin990849963653420825 as (
with aggView2028365020456501547 as (select v3 from aggJoin7698438698505988792 group by v3)
select person_id as v26 from cast_info as ci, aggView2028365020456501547 where ci.movie_id=aggView2028365020456501547.v3);
create or replace view aggJoin2993761888894234108 as (
with aggView3686300452674276939 as (select v26 from aggJoin990849963653420825 group by v26)
select name as v27 from name as n, aggView3686300452674276939 where n.id=aggView3686300452674276939.v26 and name LIKE '%Bert%');
create or replace view aggView1861751029409518738 as select v27 from aggJoin2993761888894234108 group by v27;
select MIN(v27) as v47 from aggView1861751029409518738;
