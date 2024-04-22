create or replace view aggJoin8688064049804142643 as (
with aggView4205675126487816258 as (select id as v42, name as v65 from name as n where gender= 'f')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView4205675126487816258 where ci.person_id=aggView4205675126487816258.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3607158767358176176 as (
with aggView8126127509154429343 as (select id as v53, title as v66 from title as t where production_year>2000)
select v42, v53, v9, v20, v51, v65, v66 from aggJoin8688064049804142643 join aggView8126127509154429343 using(v53));
create or replace view aggJoin8156093063543134562 as (
with aggView6523316432107565519 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v51, v65 as v65, v66 as v66 from aggJoin3607158767358176176 join aggView6523316432107565519 using(v42));
create or replace view aggJoin7229657477435176156 as (
with aggView8062058824683890640 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v65, v66 from aggJoin8156093063543134562 join aggView8062058824683890640 using(v51));
create or replace view aggJoin6753814756346986424 as (
with aggView8230311294415554318 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView8230311294415554318 where mc.company_id=aggView8230311294415554318.v23);
create or replace view aggJoin5534843483054864935 as (
with aggView2659041611966328533 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView2659041611966328533 where mi.info_type_id=aggView2659041611966328533.v30);
create or replace view aggJoin4873156595456949123 as (
with aggView4194528481567401826 as (select id as v9 from char_name as chn)
select v53, v20, v65, v66 from aggJoin7229657477435176156 join aggView4194528481567401826 using(v9));
create or replace view aggJoin4329583787705825156 as (
with aggView7073081887831302451 as (select v53, MIN(v65) as v65, MIN(v66) as v66 from aggJoin4873156595456949123 group by v53,v65,v66)
select v53, v65, v66 from aggJoin6753814756346986424 join aggView7073081887831302451 using(v53));
create or replace view aggJoin7863268883400654766 as (
with aggView8313430593209489481 as (select v53, MIN(v65) as v65, MIN(v66) as v66 from aggJoin4329583787705825156 group by v53,v65,v66)
select v65, v66 from aggJoin5534843483054864935 join aggView8313430593209489481 using(v53));
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin7863268883400654766;
