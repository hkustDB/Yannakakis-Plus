create or replace view aggView2514995429464828137 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView2804533204402929556 as select id as v59, title as v60 from title as t where production_year>2010;
create or replace view aggView7033843589115030320 as select id as v48, name as v49 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggJoin3610964425941568688 as (
with aggView1356922577067014593 as (select v59, MIN(v60) as v73 from aggView2804533204402929556 group by v59)
select person_id as v48, movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v73 from cast_info as ci, aggView1356922577067014593 where ci.movie_id=aggView1356922577067014593.v59 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin7432760762217835427 as (
with aggView6132964394513942293 as (select v48, MIN(v49) as v72 from aggView7033843589115030320 group by v48)
select v48, v59, v9, v20, v57, v73 as v73, v72 from aggJoin3610964425941568688 join aggView6132964394513942293 using(v48));
create or replace view aggJoin1411861975453387662 as (
with aggView961341727688272708 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView961341727688272708 where mi.info_type_id=aggView961341727688272708.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin7930420032665247669 as (
with aggView1654084621129700495 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView1654084621129700495 where mc.company_id=aggView1654084621129700495.v23);
create or replace view aggJoin7890898088147227434 as (
with aggView1973924417040689495 as (select person_id as v48 from aka_name as an group by person_id)
select v59, v9, v20, v57, v73 as v73, v72 as v72 from aggJoin7432760762217835427 join aggView1973924417040689495 using(v48));
create or replace view aggJoin6741084983638121081 as (
with aggView3673969065373144583 as (select v59 from aggJoin1411861975453387662 group by v59)
select v59 from aggJoin7930420032665247669 join aggView3673969065373144583 using(v59));
create or replace view aggJoin7578722379402217840 as (
with aggView4576926219650058943 as (select v59 from aggJoin6741084983638121081 group by v59)
select v59, v9, v20, v57, v73 as v73, v72 as v72 from aggJoin7890898088147227434 join aggView4576926219650058943 using(v59));
create or replace view aggJoin7544812238295115195 as (
with aggView4040595826199564349 as (select id as v57 from role_type as rt where role= 'actress')
select v59, v9, v20, v73, v72 from aggJoin7578722379402217840 join aggView4040595826199564349 using(v57));
create or replace view aggJoin6261152392577037642 as (
with aggView2970867192970979970 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select movie_id as v59 from movie_keyword as mk, aggView2970867192970979970 where mk.keyword_id=aggView2970867192970979970.v32);
create or replace view aggJoin5195884342492009034 as (
with aggView219767746582590821 as (select v59 from aggJoin6261152392577037642 group by v59)
select v9, v20, v73 as v73, v72 as v72 from aggJoin7544812238295115195 join aggView219767746582590821 using(v59));
create or replace view aggJoin7581886636378583207 as (
with aggView5377951270967898269 as (select v9, MIN(v73) as v73, MIN(v72) as v72 from aggJoin5195884342492009034 group by v9,v73,v72)
select v10, v73, v72 from aggView2514995429464828137 join aggView5377951270967898269 using(v9));
select MIN(v10) as v71,MIN(v72) as v72,MIN(v73) as v73 from aggJoin7581886636378583207;
