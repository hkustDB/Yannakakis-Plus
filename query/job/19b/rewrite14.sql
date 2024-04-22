create or replace view aggJoin7290422622299103536 as (
with aggView2351904755439523300 as (select id as v42, name as v65 from name as n where gender= 'f' and name LIKE '%Angel%')
select person_id as v42, v65 from aka_name as an, aggView2351904755439523300 where an.person_id=aggView2351904755439523300.v42);
create or replace view aggJoin4465298898608729151 as (
with aggView5973665147029125845 as (select id as v53, title as v66 from title as t where production_year>=2007 and production_year<=2008 and title LIKE '%Kung%Fu%Panda%')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView5973665147029125845 where ci.movie_id=aggView5973665147029125845.v53 and note= '(voice)');
create or replace view aggJoin4192119395527714148 as (
with aggView3395309465365875287 as (select v42, MIN(v65) as v65 from aggJoin7290422622299103536 group by v42,v65)
select v53, v9, v20, v51, v66 as v66, v65 from aggJoin4465298898608729151 join aggView3395309465365875287 using(v42));
create or replace view aggJoin6865190907073886044 as (
with aggView5327904466631231377 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView5327904466631231377 where mc.company_id=aggView5327904466631231377.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin2659599863621174213 as (
with aggView3444813950321864678 as (select v53 from aggJoin6865190907073886044 group by v53)
select movie_id as v53, info_type_id as v30, info as v40 from movie_info as mi, aggView3444813950321864678 where mi.movie_id=aggView3444813950321864678.v53 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin741193411344782851 as (
with aggView4597257641708273266 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40 from aggJoin2659599863621174213 join aggView4597257641708273266 using(v30));
create or replace view aggJoin1825811727570549099 as (
with aggView8311821272885065046 as (select v53 from aggJoin741193411344782851 group by v53)
select v9, v20, v51, v66 as v66, v65 as v65 from aggJoin4192119395527714148 join aggView8311821272885065046 using(v53));
create or replace view aggJoin6422088673539473611 as (
with aggView1732689802451204415 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v66, v65 from aggJoin1825811727570549099 join aggView1732689802451204415 using(v51));
create or replace view aggJoin8112032057156140934 as (
with aggView3176940100194782956 as (select v9, MIN(v66) as v66, MIN(v65) as v65 from aggJoin6422088673539473611 group by v9,v65,v66)
select v66, v65 from char_name as chn, aggView3176940100194782956 where chn.id=aggView3176940100194782956.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin8112032057156140934;
