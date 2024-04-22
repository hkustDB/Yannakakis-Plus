create or replace view aggJoin1319828962960789663 as (
with aggView4947217032528344808 as (select id as v11, title as v56 from title as t where episode_nr>=5 and episode_nr<100)
select movie_id as v11, keyword_id as v33, v56 from movie_keyword as mk, aggView4947217032528344808 where mk.movie_id=aggView4947217032528344808.v11);
create or replace view aggJoin3855506412404015717 as (
with aggView2236030148138245504 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView2236030148138245504 where mc.company_id=aggView2236030148138245504.v28);
create or replace view aggJoin7691591093332203610 as (
with aggView8857050833641352754 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select v11, v56 from aggJoin1319828962960789663 join aggView8857050833641352754 using(v33));
create or replace view aggJoin3505976451640401788 as (
with aggView5283373688271547544 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView5283373688271547544 where an.person_id=aggView5283373688271547544.v2);
create or replace view aggJoin968510183925636542 as (
with aggView2644743424021003612 as (select v2, MIN(v3) as v55 from aggJoin3505976451640401788 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView2644743424021003612 where ci.person_id=aggView2644743424021003612.v2);
create or replace view aggJoin2209998251470600329 as (
with aggView7134634070408292890 as (select v11 from aggJoin3855506412404015717 group by v11)
select v11, v56 as v56 from aggJoin7691591093332203610 join aggView7134634070408292890 using(v11));
create or replace view aggJoin1172759967376400750 as (
with aggView5860111013106841438 as (select v11, MIN(v56) as v56 from aggJoin2209998251470600329 group by v11,v56)
select v55 as v55, v56 from aggJoin968510183925636542 join aggView5860111013106841438 using(v11));
select MIN(v55) as v55,MIN(v56) as v56 from aggJoin1172759967376400750;
