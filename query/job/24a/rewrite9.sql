create or replace view aggJoin2994261897227188028 as (
with aggView5518321714268362921 as (select id as v59, title as v73 from title as t where production_year>2010)
select movie_id as v59, info_type_id as v30, info as v43, v73 from movie_info as mi, aggView5518321714268362921 where mi.movie_id=aggView5518321714268362921.v59 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin7941591122762924721 as (
with aggView2445871060001184957 as (select id as v9, name as v71 from char_name as chn)
select person_id as v48, movie_id as v59, note as v20, role_id as v57, v71 from cast_info as ci, aggView2445871060001184957 where ci.person_role_id=aggView2445871060001184957.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3759781286860816808 as (
with aggView3653748861538056764 as (select person_id as v48 from aka_name as an group by person_id)
select id as v48, name as v49, gender as v52 from name as n, aggView3653748861538056764 where n.id=aggView3653748861538056764.v48 and name LIKE '%An%' and gender= 'f');
create or replace view aggJoin4068139616432723948 as (
with aggView6538573894462561607 as (select v48, MIN(v49) as v72 from aggJoin3759781286860816808 group by v48)
select v59, v20, v57, v71 as v71, v72 from aggJoin7941591122762924721 join aggView6538573894462561607 using(v48));
create or replace view aggJoin1369835946626037281 as (
with aggView563242489357232007 as (select id as v30 from info_type as it where info= 'release dates')
select v59, v43, v73 from aggJoin2994261897227188028 join aggView563242489357232007 using(v30));
create or replace view aggJoin8141089135181186920 as (
with aggView2249513786921145862 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView2249513786921145862 where mc.company_id=aggView2249513786921145862.v23);
create or replace view aggJoin82520856475376320 as (
with aggView1814191233999804040 as (select id as v57 from role_type as rt where role= 'actress')
select v59, v20, v71, v72 from aggJoin4068139616432723948 join aggView1814191233999804040 using(v57));
create or replace view aggJoin4994073285236025677 as (
with aggView3330333019798558603 as (select v59, MIN(v71) as v71, MIN(v72) as v72 from aggJoin82520856475376320 group by v59,v72,v71)
select v59, v43, v73 as v73, v71, v72 from aggJoin1369835946626037281 join aggView3330333019798558603 using(v59));
create or replace view aggJoin5150737564630142301 as (
with aggView5216953071321846144 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView5216953071321846144 where mk.keyword_id=aggView5216953071321846144.v32);
create or replace view aggJoin5290517160539303292 as (
with aggView4817081036626657039 as (select v59 from aggJoin5150737564630142301 group by v59)
select v59 from aggJoin8141089135181186920 join aggView4817081036626657039 using(v59));
create or replace view aggJoin7497346760330209115 as (
with aggView1898834772326111310 as (select v59 from aggJoin5290517160539303292 group by v59)
select v73 as v73, v71 as v71, v72 as v72 from aggJoin4994073285236025677 join aggView1898834772326111310 using(v59));
select MIN(v71) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin7497346760330209115;
