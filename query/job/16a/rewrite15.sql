create or replace view aggJoin3892603648401316613 as (
with aggView7026676604448997284 as (select id as v11, title as v56 from title as t where episode_nr>=50 and episode_nr<100)
select movie_id as v11, company_id as v28, v56 from movie_companies as mc, aggView7026676604448997284 where mc.movie_id=aggView7026676604448997284.v11);
create or replace view aggJoin2715710137339519822 as (
with aggView6617908848845382768 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView6617908848845382768 where ci.person_id=aggView6617908848845382768.v2);
create or replace view aggJoin1553351511879262791 as (
with aggView9029085325760723515 as (select id as v2 from name as n)
select v11, v55 from aggJoin2715710137339519822 join aggView9029085325760723515 using(v2));
create or replace view aggJoin1439574295925835649 as (
with aggView4983056280525078146 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView4983056280525078146 where mk.keyword_id=aggView4983056280525078146.v33);
create or replace view aggJoin6088574902800236562 as (
with aggView6618287197920871395 as (select id as v28 from company_name as cn where country_code= '[us]')
select v11, v56 from aggJoin3892603648401316613 join aggView6618287197920871395 using(v28));
create or replace view aggJoin715181515771148486 as (
with aggView8378185068616617817 as (select v11 from aggJoin1439574295925835649 group by v11)
select v11, v56 as v56 from aggJoin6088574902800236562 join aggView8378185068616617817 using(v11));
create or replace view aggJoin1106647704355902860 as (
with aggView2916291127025398937 as (select v11, MIN(v56) as v56 from aggJoin715181515771148486 group by v11,v56)
select v55 as v55, v56 from aggJoin1553351511879262791 join aggView2916291127025398937 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin1106647704355902860;
