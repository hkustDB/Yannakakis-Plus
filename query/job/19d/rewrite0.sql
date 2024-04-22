create or replace view aggJoin4970808632696398067 as (
with aggView3397668255541001496 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView3397668255541001496 where mi.info_type_id=aggView3397668255541001496.v30);
create or replace view aggJoin4111812511556726949 as (
with aggView2665214421048788527 as (select v53 from aggJoin4970808632696398067 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView2665214421048788527 where t.id=aggView2665214421048788527.v53 and production_year>2000);
create or replace view aggJoin1345363724657647265 as (
with aggView487027363480334755 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView487027363480334755 where mc.company_id=aggView487027363480334755.v23);
create or replace view aggJoin8690760447319654233 as (
with aggView7540109937627055645 as (select v53 from aggJoin1345363724657647265 group by v53)
select v53, v54, v57 from aggJoin4111812511556726949 join aggView7540109937627055645 using(v53));
create or replace view aggView7855383872995208081 as select v53, v54 from aggJoin8690760447319654233 group by v53,v54;
create or replace view aggJoin1728839429966283841 as (
with aggView7968427565250084433 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView7968427565250084433 where n.id=aggView7968427565250084433.v42 and gender= 'f');
create or replace view aggView441071627801920487 as select v42, v43 from aggJoin1728839429966283841 group by v42,v43;
create or replace view aggJoin7391462974487395395 as (
with aggView6573343728640123184 as (select v42, MIN(v43) as v65 from aggView441071627801920487 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView6573343728640123184 where ci.person_id=aggView6573343728640123184.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1072062294354050230 as (
with aggView5729159425800270417 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v65 from aggJoin7391462974487395395 join aggView5729159425800270417 using(v51));
create or replace view aggJoin2653698261300663414 as (
with aggView4540788176052987359 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin1072062294354050230 join aggView4540788176052987359 using(v9));
create or replace view aggJoin1160125662466531382 as (
with aggView8007901650532190148 as (select v53, MIN(v65) as v65 from aggJoin2653698261300663414 group by v53,v65)
select v54, v65 from aggView7855383872995208081 join aggView8007901650532190148 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin1160125662466531382;
