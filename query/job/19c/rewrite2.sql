create or replace view aggJoin4563218430344742774 as (
with aggView8250866739401493166 as (select id as v53, title as v66 from title as t where production_year>2000)
select movie_id as v53, info_type_id as v30, info as v40, v66 from movie_info as mi, aggView8250866739401493166 where mi.movie_id=aggView8250866739401493166.v53 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin7052849642575930371 as (
with aggView154472962784243256 as (select id as v51 from role_type as rt where role= 'actress')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20 from cast_info as ci, aggView154472962784243256 where ci.role_id=aggView154472962784243256.v51 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2711800704034094666 as (
with aggView8558317012976495356 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40, v66 from aggJoin4563218430344742774 join aggView8558317012976495356 using(v30));
create or replace view aggJoin9121761894190260004 as (
with aggView8237714546427495933 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView8237714546427495933 where mc.company_id=aggView8237714546427495933.v23);
create or replace view aggJoin355761324179508180 as (
with aggView7466794349209161080 as (select id as v9 from char_name as chn)
select v42, v53, v20 from aggJoin7052849642575930371 join aggView7466794349209161080 using(v9));
create or replace view aggJoin5106512062516814155 as (
with aggView2720886418501844507 as (select v53, MIN(v66) as v66 from aggJoin2711800704034094666 group by v53,v66)
select v53, v66 from aggJoin9121761894190260004 join aggView2720886418501844507 using(v53));
create or replace view aggJoin9161216924238062576 as (
with aggView1895131474023311418 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView1895131474023311418 where n.id=aggView1895131474023311418.v42 and name LIKE '%An%' and gender= 'f');
create or replace view aggJoin7085499280542460854 as (
with aggView5500579273309774694 as (select v42, MIN(v43) as v65 from aggJoin9161216924238062576 group by v42)
select v53, v20, v65 from aggJoin355761324179508180 join aggView5500579273309774694 using(v42));
create or replace view aggJoin8663609566727134415 as (
with aggView237318398144924676 as (select v53, MIN(v65) as v65 from aggJoin7085499280542460854 group by v53,v65)
select v66 as v66, v65 from aggJoin5106512062516814155 join aggView237318398144924676 using(v53));
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin8663609566727134415;
