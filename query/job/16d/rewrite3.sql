create or replace view aggView1376157878049555404 as select title as v44, id as v11 from title as t where episode_nr>=5 and episode_nr<100;
create or replace view aggJoin2569517132578589668 as (
with aggView3126816593361737241 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView3126816593361737241 where an.person_id=aggView3126816593361737241.v2);
create or replace view aggView1298314639411472371 as select v2, v3 from aggJoin2569517132578589668 group by v2,v3;
create or replace view aggJoin7022024791255413010 as (
with aggView255747072822378612 as (select v11, MIN(v44) as v56 from aggView1376157878049555404 group by v11)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView255747072822378612 where ci.movie_id=aggView255747072822378612.v11);
create or replace view aggJoin4626603420851866416 as (
with aggView7561645345325042000 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView7561645345325042000 where mc.company_id=aggView7561645345325042000.v28);
create or replace view aggJoin930383319969695948 as (
with aggView4455087152831088685 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView4455087152831088685 where mk.keyword_id=aggView4455087152831088685.v33);
create or replace view aggJoin4295359360105009518 as (
with aggView7241970554469401868 as (select v11 from aggJoin4626603420851866416 group by v11)
select v11 from aggJoin930383319969695948 join aggView7241970554469401868 using(v11));
create or replace view aggJoin6722383123486771874 as (
with aggView1535618450505808223 as (select v11 from aggJoin4295359360105009518 group by v11)
select v2, v56 as v56 from aggJoin7022024791255413010 join aggView1535618450505808223 using(v11));
create or replace view aggJoin1161754783680109475 as (
with aggView1895685473480414991 as (select v2, MIN(v56) as v56 from aggJoin6722383123486771874 group by v2,v56)
select v3, v56 from aggView1298314639411472371 join aggView1895685473480414991 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin1161754783680109475;
