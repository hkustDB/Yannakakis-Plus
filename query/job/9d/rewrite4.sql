create or replace view aggJoin2829341463878809615 as (
with aggView4524806324385365912 as (select id as v35, name as v60 from name as n where gender= 'f')
select person_id as v35, name as v3, v60 from aka_name as an, aggView4524806324385365912 where an.person_id=aggView4524806324385365912.v35);
create or replace view aggJoin2932572552700843966 as (
with aggView7723601288044061325 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin2829341463878809615 group by v35,v60)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60, v58 from cast_info as ci, aggView7723601288044061325 where ci.person_id=aggView7723601288044061325.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin867311216532968057 as (
with aggView262346403394884507 as (select id as v9, name as v59 from char_name as chn)
select v18, v20, v22, v60, v58, v59 from aggJoin2932572552700843966 join aggView262346403394884507 using(v9));
create or replace view aggJoin1365484712731062547 as (
with aggView4095229625670383274 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v60, v58, v59 from aggJoin867311216532968057 join aggView4095229625670383274 using(v22));
create or replace view aggJoin2076611295524132796 as (
with aggView5218210000900902892 as (select v18, MIN(v60) as v60, MIN(v58) as v58, MIN(v59) as v59 from aggJoin1365484712731062547 group by v18,v60,v59,v58)
select movie_id as v18, company_id as v32, v60, v58, v59 from movie_companies as mc, aggView5218210000900902892 where mc.movie_id=aggView5218210000900902892.v18);
create or replace view aggJoin60013490109516857 as (
with aggView2106953406420248727 as (select id as v32 from company_name as cn where country_code= '[us]')
select v18, v60, v58, v59 from aggJoin2076611295524132796 join aggView2106953406420248727 using(v32));
create or replace view aggJoin4238700844733841737 as (
with aggView6604907321725273167 as (select v18, MIN(v60) as v60, MIN(v58) as v58, MIN(v59) as v59 from aggJoin60013490109516857 group by v18,v60,v59,v58)
select title as v47, v60, v58, v59 from title as t, aggView6604907321725273167 where t.id=aggView6604907321725273167.v18);
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v47) as v61 from aggJoin4238700844733841737;
