create or replace view aggView2460800026644103056 as select id as v42, name as v43 from name as n where gender= 'f';
create or replace view aggView6974975968480293802 as select id as v53, title as v54 from title as t where production_year>2000;
create or replace view aggJoin5543394962940597034 as (
with aggView932989137166220187 as (select v53, MIN(v54) as v66 from aggView6974975968480293802 group by v53)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView932989137166220187 where ci.movie_id=aggView932989137166220187.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3440395645884771412 as (
with aggView5767876404691651540 as (select person_id as v42 from aka_name as an group by person_id)
select v42, v53, v9, v20, v51, v66 as v66 from aggJoin5543394962940597034 join aggView5767876404691651540 using(v42));
create or replace view aggJoin6514827549332215406 as (
with aggView1910888074039264298 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView1910888074039264298 where mi.info_type_id=aggView1910888074039264298.v30);
create or replace view aggJoin8348573238706753574 as (
with aggView6582852775729527568 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView6582852775729527568 where mc.company_id=aggView6582852775729527568.v23);
create or replace view aggJoin6809668749156207254 as (
with aggView5202832207873279754 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v53, v9, v20, v66 from aggJoin3440395645884771412 join aggView5202832207873279754 using(v51));
create or replace view aggJoin9021333859743739461 as (
with aggView8250134726578607548 as (select v53 from aggJoin6514827549332215406 group by v53)
select v53 from aggJoin8348573238706753574 join aggView8250134726578607548 using(v53));
create or replace view aggJoin4710930797555202066 as (
with aggView1977513053895008934 as (select id as v9 from char_name as chn)
select v42, v53, v20, v66 from aggJoin6809668749156207254 join aggView1977513053895008934 using(v9));
create or replace view aggJoin7417752036654363767 as (
with aggView780162169366976548 as (select v53 from aggJoin9021333859743739461 group by v53)
select v42, v20, v66 as v66 from aggJoin4710930797555202066 join aggView780162169366976548 using(v53));
create or replace view aggJoin7544266411091078847 as (
with aggView6956410667736083580 as (select v42, MIN(v66) as v66 from aggJoin7417752036654363767 group by v42,v66)
select v43, v66 from aggView2460800026644103056 join aggView6956410667736083580 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin7544266411091078847;
