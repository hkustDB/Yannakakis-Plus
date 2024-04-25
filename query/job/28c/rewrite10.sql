create or replace view aggJoin2689955919414200306 as (
with aggView7373434352899902934 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView7373434352899902934 where mc.company_id=aggView7373434352899902934.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3370681127065554065 as (
with aggView2064167556534250306 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView2064167556534250306 where t.kind_id=aggView2064167556534250306.v25 and production_year>2005);
create or replace view aggJoin176357165272318646 as (
with aggView6530473180172492602 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView6530473180172492602 where mi_idx.info_type_id=aggView6530473180172492602.v20 and info<'8.5');
create or replace view aggJoin1788684536173483437 as (
with aggView5144789482152218908 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView5144789482152218908 where cc.subject_id=aggView5144789482152218908.v5);
create or replace view aggJoin2609012074437816505 as (
with aggView5668507960063383050 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin2689955919414200306 join aggView5668507960063383050 using(v16));
create or replace view aggJoin8812852694627202160 as (
with aggView1683600780981256762 as (select v45, MIN(v57) as v57 from aggJoin2609012074437816505 group by v45)
select movie_id as v45, keyword_id as v22, v57 from movie_keyword as mk, aggView1683600780981256762 where mk.movie_id=aggView1683600780981256762.v45);
create or replace view aggJoin8080967645274336338 as (
with aggView3284041832209819052 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin1788684536173483437 join aggView3284041832209819052 using(v7));
create or replace view aggJoin5283537284284377817 as (
with aggView6531526716150881646 as (select v45 from aggJoin8080967645274336338 group by v45)
select v45, v40 from aggJoin176357165272318646 join aggView6531526716150881646 using(v45));
create or replace view aggJoin2640047934600586222 as (
with aggView5632622447899198591 as (select v45, MIN(v40) as v58 from aggJoin5283537284284377817 group by v45)
select v45, v46, v49, v58 from aggJoin3370681127065554065 join aggView5632622447899198591 using(v45));
create or replace view aggJoin5252209376550185359 as (
with aggView5328889182691835962 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView5328889182691835962 where mi.info_type_id=aggView5328889182691835962.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin3415157491096181666 as (
with aggView6344643064823704566 as (select v45 from aggJoin5252209376550185359 group by v45)
select v45, v46, v49, v58 as v58 from aggJoin2640047934600586222 join aggView6344643064823704566 using(v45));
create or replace view aggJoin944278422003571645 as (
with aggView177594155939361184 as (select v45, MIN(v58) as v58, MIN(v46) as v59 from aggJoin3415157491096181666 group by v45)
select v22, v57 as v57, v58, v59 from aggJoin8812852694627202160 join aggView177594155939361184 using(v45));
create or replace view aggJoin2116136721612761867 as (
with aggView911747694920436908 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v57, v58, v59 from aggJoin944278422003571645 join aggView911747694920436908 using(v22));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin2116136721612761867;
