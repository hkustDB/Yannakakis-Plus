create or replace view aggJoin8593941739064849576 as (
with aggView3150767327429672600 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView3150767327429672600 where mc.company_id=aggView3150767327429672600.v28);
create or replace view aggJoin4912775906715235250 as (
with aggView6743859264247371332 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView6743859264247371332 where mk.keyword_id=aggView6743859264247371332.v33);
create or replace view aggJoin8910145767465695864 as (
with aggView3808049109117155837 as (select v11 from aggJoin8593941739064849576 group by v11)
select v11 from aggJoin4912775906715235250 join aggView3808049109117155837 using(v11));
create or replace view aggJoin5433353449762163908 as (
with aggView567253413287517588 as (select v11 from aggJoin8910145767465695864 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView567253413287517588 where t.id=aggView567253413287517588.v11 and episode_nr>=50 and episode_nr<100);
create or replace view aggView5474092248560628767 as select v11, v44 from aggJoin5433353449762163908 group by v11,v44;
create or replace view aggJoin5004350145402601492 as (
with aggView370497943517539843 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView370497943517539843 where an.person_id=aggView370497943517539843.v2);
create or replace view aggView5920291423551461502 as select v2, v3 from aggJoin5004350145402601492 group by v2,v3;
create or replace view aggJoin4040248372990347333 as (
with aggView4141638759601263740 as (select v11, MIN(v44) as v56 from aggView5474092248560628767 group by v11)
select person_id as v2, v56 from cast_info as ci, aggView4141638759601263740 where ci.movie_id=aggView4141638759601263740.v11);
create or replace view aggJoin9211256559963101653 as (
with aggView2905028385846280611 as (select v2, MIN(v56) as v56 from aggJoin4040248372990347333 group by v2,v56)
select v3, v56 from aggView5920291423551461502 join aggView2905028385846280611 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin9211256559963101653;
