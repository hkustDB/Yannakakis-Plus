create or replace view aggJoin4359349561503496749 as (
with aggView8255333256289195602 as (select id as v11, title as v56 from title as t where episode_nr>=5 and episode_nr<100)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView8255333256289195602 where ci.movie_id=aggView8255333256289195602.v11);
create or replace view aggJoin1267344693171790869 as (
with aggView4776841221879111314 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView4776841221879111314 where mc.company_id=aggView4776841221879111314.v28);
create or replace view aggJoin1879960514542695641 as (
with aggView7229908339850681902 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView7229908339850681902 where an.person_id=aggView7229908339850681902.v2);
create or replace view aggJoin3731327212045512068 as (
with aggView7618840968492702090 as (select v2, MIN(v3) as v55 from aggJoin1879960514542695641 group by v2)
select v11, v56 as v56, v55 from aggJoin4359349561503496749 join aggView7618840968492702090 using(v2));
create or replace view aggJoin2977351755515155253 as (
with aggView5603045162197290628 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView5603045162197290628 where mk.keyword_id=aggView5603045162197290628.v33);
create or replace view aggJoin3476592086096929048 as (
with aggView3433719017673205712 as (select v11 from aggJoin2977351755515155253 group by v11)
select v11, v56 as v56, v55 as v55 from aggJoin3731327212045512068 join aggView3433719017673205712 using(v11));
create or replace view aggJoin3020222860808541471 as (
with aggView3596255193115189956 as (select v11 from aggJoin1267344693171790869 group by v11)
select v56 as v56, v55 as v55 from aggJoin3476592086096929048 join aggView3596255193115189956 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin3020222860808541471;
