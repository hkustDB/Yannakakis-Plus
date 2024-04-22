create or replace view aggJoin6466704384642516489 as (
with aggView2369356094516055330 as (select person_id as v35, MIN(name) as v58 from aka_name as an group by person_id)
select id as v35, name as v36, gender as v39, v58 from name as n, aggView2369356094516055330 where n.id=aggView2369356094516055330.v35 and gender= 'f');
create or replace view aggJoin5915818864007073587 as (
with aggView2497417063542563205 as (select id as v18, title as v61 from title as t)
select movie_id as v18, company_id as v32, v61 from movie_companies as mc, aggView2497417063542563205 where mc.movie_id=aggView2497417063542563205.v18);
create or replace view aggJoin4093174579122220879 as (
with aggView8438054039840588812 as (select v35, MIN(v58) as v58, MIN(v36) as v60 from aggJoin6466704384642516489 group by v35,v58)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v58, v60 from cast_info as ci, aggView8438054039840588812 where ci.person_id=aggView8438054039840588812.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4558527046068828787 as (
with aggView4491972988378409046 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v9, v20, v58, v60 from aggJoin4093174579122220879 join aggView4491972988378409046 using(v22));
create or replace view aggJoin783956625974602458 as (
with aggView7860038269565898801 as (select id as v32 from company_name as cn where country_code= '[us]')
select v18, v61 from aggJoin5915818864007073587 join aggView7860038269565898801 using(v32));
create or replace view aggJoin1805028012423538030 as (
with aggView314565526900386143 as (select v18, MIN(v61) as v61 from aggJoin783956625974602458 group by v18,v61)
select v9, v20, v58 as v58, v60 as v60, v61 from aggJoin4558527046068828787 join aggView314565526900386143 using(v18));
create or replace view aggJoin1524183588909474414 as (
with aggView5535356049341939939 as (select v9, MIN(v58) as v58, MIN(v60) as v60, MIN(v61) as v61 from aggJoin1805028012423538030 group by v9,v60,v58,v61)
select name as v10, v58, v60, v61 from char_name as chn, aggView5535356049341939939 where chn.id=aggView5535356049341939939.v9);
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin1524183588909474414;
