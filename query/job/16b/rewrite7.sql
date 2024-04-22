create or replace view aggJoin3435915508820846698 as (
with aggView964392758558717928 as (select id as v11, title as v56 from title as t)
select movie_id as v11, keyword_id as v33, v56 from movie_keyword as mk, aggView964392758558717928 where mk.movie_id=aggView964392758558717928.v11);
create or replace view aggJoin8540926185133904581 as (
with aggView8601271605844410509 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select v11, v56 from aggJoin3435915508820846698 join aggView8601271605844410509 using(v33));
create or replace view aggJoin4234938487686878087 as (
with aggView7561069961565671308 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView7561069961565671308 where mc.company_id=aggView7561069961565671308.v28);
create or replace view aggJoin7439800174125567385 as (
with aggView1667398071367217772 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView1667398071367217772 where an.person_id=aggView1667398071367217772.v2);
create or replace view aggJoin5834191034947351477 as (
with aggView6942766156829979746 as (select v2, MIN(v3) as v55 from aggJoin7439800174125567385 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView6942766156829979746 where ci.person_id=aggView6942766156829979746.v2);
create or replace view aggJoin4307370175528465934 as (
with aggView6295503656047545762 as (select v11, MIN(v56) as v56 from aggJoin8540926185133904581 group by v11,v56)
select v11, v56 from aggJoin4234938487686878087 join aggView6295503656047545762 using(v11));
create or replace view aggJoin2719582121542307805 as (
with aggView8447765537389283704 as (select v11, MIN(v56) as v56 from aggJoin4307370175528465934 group by v11,v56)
select v55 as v55, v56 from aggJoin5834191034947351477 join aggView8447765537389283704 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin2719582121542307805;
