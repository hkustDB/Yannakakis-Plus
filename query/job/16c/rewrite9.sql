create or replace view aggView5696333251942203429 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin2454439990543370897 as (
with aggView7286421283243384918 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView7286421283243384918 where mc.company_id=aggView7286421283243384918.v28);
create or replace view aggJoin2081477382154605501 as (
with aggView8313655263078259680 as (select v11 from aggJoin2454439990543370897 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView8313655263078259680 where t.id=aggView8313655263078259680.v11 and episode_nr<100);
create or replace view aggView3395786098499290464 as select v44, v11 from aggJoin2081477382154605501 group by v44,v11;
create or replace view aggJoin3626613594302844843 as (
with aggView9186719509581258178 as (select v2, MIN(v3) as v55 from aggView5696333251942203429 group by v2)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView9186719509581258178 where ci.person_id=aggView9186719509581258178.v2);
create or replace view aggJoin1516562883074749476 as (
with aggView4701949013342321461 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView4701949013342321461 where mk.keyword_id=aggView4701949013342321461.v33);
create or replace view aggJoin2588154960820298342 as (
with aggView8296677530278607095 as (select v11 from aggJoin1516562883074749476 group by v11)
select v2, v11, v55 as v55 from aggJoin3626613594302844843 join aggView8296677530278607095 using(v11));
create or replace view aggJoin4082533770901616142 as (
with aggView695159465647169871 as (select id as v2 from name as n)
select v11, v55 from aggJoin2588154960820298342 join aggView695159465647169871 using(v2));
create or replace view aggJoin2103621582604949826 as (
with aggView4130244660124424206 as (select v11, MIN(v55) as v55 from aggJoin4082533770901616142 group by v11,v55)
select v44, v55 from aggView3395786098499290464 join aggView4130244660124424206 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin2103621582604949826;
