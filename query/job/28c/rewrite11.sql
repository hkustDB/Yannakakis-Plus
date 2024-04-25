create or replace view aggView6660742921536936383 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin3563388791885489399 as (
with aggView155668850442045341 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView155668850442045341 where t.kind_id=aggView155668850442045341.v25 and production_year>2005);
create or replace view aggView7002320542869726266 as select v45, v46 from aggJoin3563388791885489399 group by v45,v46;
create or replace view aggJoin2288375956598026445 as (
with aggView3553184526116066496 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView3553184526116066496 where mi_idx.info_type_id=aggView3553184526116066496.v20 and info<'8.5');
create or replace view aggJoin4540379461509524064 as (
with aggView4425126368517748931 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView4425126368517748931 where mi.info_type_id=aggView4425126368517748931.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin4420890451561087175 as (
with aggView5831365720366787097 as (select v45 from aggJoin4540379461509524064 group by v45)
select v45, v40 from aggJoin2288375956598026445 join aggView5831365720366787097 using(v45));
create or replace view aggView7158793948872273017 as select v45, v40 from aggJoin4420890451561087175 group by v45,v40;
create or replace view aggJoin2077678908933625536 as (
with aggView5185054615553245931 as (select v45, MIN(v46) as v59 from aggView7002320542869726266 group by v45)
select v45, v40, v59 from aggView7158793948872273017 join aggView5185054615553245931 using(v45));
create or replace view aggJoin8430802559222628603 as (
with aggView5073407916969767053 as (select v9, MIN(v10) as v57 from aggView6660742921536936383 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView5073407916969767053 where mc.company_id=aggView5073407916969767053.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3726035066473579099 as (
with aggView4315597905490941752 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView4315597905490941752 where cc.subject_id=aggView4315597905490941752.v5);
create or replace view aggJoin782591423028893340 as (
with aggView3837330467604470667 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin8430802559222628603 join aggView3837330467604470667 using(v16));
create or replace view aggJoin4430819342931956291 as (
with aggView182318242813604040 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin3726035066473579099 join aggView182318242813604040 using(v7));
create or replace view aggJoin3512226786023755106 as (
with aggView2087312905309469643 as (select v45 from aggJoin4430819342931956291 group by v45)
select v45, v31, v57 as v57 from aggJoin782591423028893340 join aggView2087312905309469643 using(v45));
create or replace view aggJoin1051018287497905945 as (
with aggView337123177181947994 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView337123177181947994 where mk.keyword_id=aggView337123177181947994.v22);
create or replace view aggJoin132335081162142052 as (
with aggView996325970926053854 as (select v45 from aggJoin1051018287497905945 group by v45)
select v45, v31, v57 as v57 from aggJoin3512226786023755106 join aggView996325970926053854 using(v45));
create or replace view aggJoin7843152923737875293 as (
with aggView2540929365581298730 as (select v45, MIN(v57) as v57 from aggJoin132335081162142052 group by v45)
select v40, v59 as v59, v57 from aggJoin2077678908933625536 join aggView2540929365581298730 using(v45));
select MIN(v57) as v57,MIN(v40) as v58,MIN(v59) as v59 from aggJoin7843152923737875293;
