create or replace view aggJoin7000486933566210079 as (
with aggView1051452934829103788 as (select id as v53, title as v66 from title as t where production_year>2000)
select movie_id as v53, info_type_id as v30, info as v40, v66 from movie_info as mi, aggView1051452934829103788 where mi.movie_id=aggView1051452934829103788.v53 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin2268109842888939229 as (
with aggView2023564910221566711 as (select id as v51 from role_type as rt where role= 'actress')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20 from cast_info as ci, aggView2023564910221566711 where ci.role_id=aggView2023564910221566711.v51 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4669296613645601912 as (
with aggView4303718519221694559 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40, v66 from aggJoin7000486933566210079 join aggView4303718519221694559 using(v30));
create or replace view aggJoin517152688945916188 as (
with aggView5530743532887663401 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView5530743532887663401 where mc.company_id=aggView5530743532887663401.v23);
create or replace view aggJoin2201012322483130031 as (
with aggView8037726517230297180 as (select v53, MIN(v66) as v66 from aggJoin4669296613645601912 group by v53,v66)
select v53, v66 from aggJoin517152688945916188 join aggView8037726517230297180 using(v53));
create or replace view aggJoin4136432064298337649 as (
with aggView4764561704503787954 as (select v53, MIN(v66) as v66 from aggJoin2201012322483130031 group by v53,v66)
select v42, v9, v20, v66 from aggJoin2268109842888939229 join aggView4764561704503787954 using(v53));
create or replace view aggJoin7686585292823111152 as (
with aggView3009793343212351428 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView3009793343212351428 where n.id=aggView3009793343212351428.v42 and name LIKE '%An%' and gender= 'f');
create or replace view aggJoin5301316090388987471 as (
with aggView680022221365274755 as (select v42, MIN(v43) as v65 from aggJoin7686585292823111152 group by v42)
select v9, v20, v66 as v66, v65 from aggJoin4136432064298337649 join aggView680022221365274755 using(v42));
create or replace view aggJoin8029332391744705365 as (
with aggView5816524424601924289 as (select v9, MIN(v66) as v66, MIN(v65) as v65 from aggJoin5301316090388987471 group by v9,v66,v65)
select v66, v65 from char_name as chn, aggView5816524424601924289 where chn.id=aggView5816524424601924289.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin8029332391744705365;
