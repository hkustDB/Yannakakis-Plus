create or replace view aggJoin3216377873935054231 as (
with aggView4469405465229282617 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView4469405465229282617 where ci.person_id=aggView4469405465229282617.v2);
create or replace view aggJoin7774579386079404928 as (
with aggView7202769579947245897 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView7202769579947245897 where mk.keyword_id=aggView7202769579947245897.v33);
create or replace view aggJoin8409017463216837456 as (
with aggView5915346640377378904 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView5915346640377378904 where mc.company_id=aggView5915346640377378904.v28);
create or replace view aggJoin3307992550423046670 as (
with aggView2208944587531990944 as (select v11 from aggJoin7774579386079404928 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView2208944587531990944 where t.id=aggView2208944587531990944.v11 and episode_nr<100);
create or replace view aggJoin4707828083401894818 as (
with aggView8273273526724442114 as (select v11 from aggJoin8409017463216837456 group by v11)
select v11, v44, v52 from aggJoin3307992550423046670 join aggView8273273526724442114 using(v11));
create or replace view aggJoin9102477025432771850 as (
with aggView1919403340037594071 as (select v11, MIN(v44) as v56 from aggJoin4707828083401894818 group by v11)
select v2, v55 as v55, v56 from aggJoin3216377873935054231 join aggView1919403340037594071 using(v11));
create or replace view aggJoin245949963291913742 as (
with aggView2439634641434454694 as (select id as v2 from name as n)
select v55, v56 from aggJoin9102477025432771850 join aggView2439634641434454694 using(v2));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin245949963291913742;
