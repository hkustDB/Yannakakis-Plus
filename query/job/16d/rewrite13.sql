create or replace view aggJoin4355928784573937314 as (
with aggView3351304465841434303 as (select id as v11, title as v56 from title as t where episode_nr>=5 and episode_nr<100)
select movie_id as v11, keyword_id as v33, v56 from movie_keyword as mk, aggView3351304465841434303 where mk.movie_id=aggView3351304465841434303.v11);
create or replace view aggJoin2510386288031673717 as (
with aggView5768544297363839064 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView5768544297363839064 where mc.company_id=aggView5768544297363839064.v28);
create or replace view aggJoin6433783022296088227 as (
with aggView5786696288609040316 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView5786696288609040316 where an.person_id=aggView5786696288609040316.v2);
create or replace view aggJoin1604280196291401742 as (
with aggView4228406933095351795 as (select v2, MIN(v3) as v55 from aggJoin6433783022296088227 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView4228406933095351795 where ci.person_id=aggView4228406933095351795.v2);
create or replace view aggJoin3906021422144019867 as (
with aggView9194712117407112681 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select v11, v56 from aggJoin4355928784573937314 join aggView9194712117407112681 using(v33));
create or replace view aggJoin1543666374763325289 as (
with aggView2916274175255899541 as (select v11, MIN(v56) as v56 from aggJoin3906021422144019867 group by v11,v56)
select v11, v55 as v55, v56 from aggJoin1604280196291401742 join aggView2916274175255899541 using(v11));
create or replace view aggJoin1725586510136298842 as (
with aggView3748241351501011101 as (select v11 from aggJoin2510386288031673717 group by v11)
select v55 as v55, v56 as v56 from aggJoin1543666374763325289 join aggView3748241351501011101 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin1725586510136298842;
