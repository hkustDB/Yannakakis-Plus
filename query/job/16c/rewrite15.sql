create or replace view aggJoin728256656486859956 as (
with aggView6011826792027209762 as (select person_id as v2, MIN(name) as v55 from aka_name as an group by person_id)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView6011826792027209762 where ci.person_id=aggView6011826792027209762.v2);
create or replace view aggJoin1059924400767977537 as (
with aggView5668376164769185460 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView5668376164769185460 where mk.keyword_id=aggView5668376164769185460.v33);
create or replace view aggJoin8126248681840218486 as (
with aggView248671012467159186 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView248671012467159186 where mc.company_id=aggView248671012467159186.v28);
create or replace view aggJoin6250273862019789062 as (
with aggView6042260951885639234 as (select v11 from aggJoin8126248681840218486 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView6042260951885639234 where t.id=aggView6042260951885639234.v11 and episode_nr<100);
create or replace view aggJoin129775094388373569 as (
with aggView6703683834026910375 as (select v11, MIN(v44) as v56 from aggJoin6250273862019789062 group by v11)
select v11, v56 from aggJoin1059924400767977537 join aggView6703683834026910375 using(v11));
create or replace view aggJoin4623799105400115362 as (
with aggView4644407867112626616 as (select v11, MIN(v56) as v56 from aggJoin129775094388373569 group by v11,v56)
select v2, v55 as v55, v56 from aggJoin728256656486859956 join aggView4644407867112626616 using(v11));
create or replace view aggJoin4409253898380039689 as (
with aggView7654615792163052373 as (select id as v2 from name as n)
select v55, v56 from aggJoin4623799105400115362 join aggView7654615792163052373 using(v2));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin4409253898380039689;
