create or replace view aggView4623480079666939879 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin4700697862835038599 as (
with aggView5506415530020067521 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView5506415530020067521 where mk.keyword_id=aggView5506415530020067521.v33);
create or replace view aggJoin3433605225050264761 as (
with aggView6707661270484559502 as (select v11 from aggJoin4700697862835038599 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView6707661270484559502 where t.id=aggView6707661270484559502.v11 and episode_nr<100);
create or replace view aggView1919852866017420077 as select v44, v11 from aggJoin3433605225050264761 group by v44,v11;
create or replace view aggJoin5471081069832233638 as (
with aggView8841686112415902362 as (select v2, MIN(v3) as v55 from aggView4623480079666939879 group by v2)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView8841686112415902362 where ci.person_id=aggView8841686112415902362.v2);
create or replace view aggJoin2160299904378733289 as (
with aggView8009148507629770957 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView8009148507629770957 where mc.company_id=aggView8009148507629770957.v28);
create or replace view aggJoin5351868162765605241 as (
with aggView1744654451072186234 as (select v11 from aggJoin2160299904378733289 group by v11)
select v2, v11, v55 as v55 from aggJoin5471081069832233638 join aggView1744654451072186234 using(v11));
create or replace view aggJoin4331892370675181415 as (
with aggView622051424694596876 as (select id as v2 from name as n)
select v11, v55 from aggJoin5351868162765605241 join aggView622051424694596876 using(v2));
create or replace view aggJoin3848034527155993442 as (
with aggView6340425893478448764 as (select v11, MIN(v55) as v55 from aggJoin4331892370675181415 group by v11,v55)
select v44, v55 from aggView1919852866017420077 join aggView6340425893478448764 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin3848034527155993442;
