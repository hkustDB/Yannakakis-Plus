create or replace view aggJoin6889253960178639969 as (
with aggView7090346413166917409 as (select id as v42, name as v65 from name as n where gender= 'f')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView7090346413166917409 where ci.person_id=aggView7090346413166917409.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin7155427828361574908 as (
with aggView662816054620815714 as (select id as v53, title as v66 from title as t where production_year>2000)
select movie_id as v53, company_id as v23, v66 from movie_companies as mc, aggView662816054620815714 where mc.movie_id=aggView662816054620815714.v53);
create or replace view aggJoin2976730577746294963 as (
with aggView6527149288789502371 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v51, v65 as v65 from aggJoin6889253960178639969 join aggView6527149288789502371 using(v42));
create or replace view aggJoin6198270249930344410 as (
with aggView6769062199575573611 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v65 from aggJoin2976730577746294963 join aggView6769062199575573611 using(v51));
create or replace view aggJoin663019602092705584 as (
with aggView7161496366639066070 as (select id as v23 from company_name as cn where country_code= '[us]')
select v53, v66 from aggJoin7155427828361574908 join aggView7161496366639066070 using(v23));
create or replace view aggJoin2204976027117048042 as (
with aggView3383979813306471164 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView3383979813306471164 where mi.info_type_id=aggView3383979813306471164.v30);
create or replace view aggJoin7416249345500206903 as (
with aggView8048607617036383446 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin6198270249930344410 join aggView8048607617036383446 using(v9));
create or replace view aggJoin4934906989808640002 as (
with aggView414714638071191265 as (select v53, MIN(v65) as v65 from aggJoin7416249345500206903 group by v53,v65)
select v53, v66 as v66, v65 from aggJoin663019602092705584 join aggView414714638071191265 using(v53));
create or replace view aggJoin6201650166111848144 as (
with aggView1506616168191079891 as (select v53, MIN(v66) as v66, MIN(v65) as v65 from aggJoin4934906989808640002 group by v53,v65,v66)
select v66, v65 from aggJoin2204976027117048042 join aggView1506616168191079891 using(v53));
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin6201650166111848144;
