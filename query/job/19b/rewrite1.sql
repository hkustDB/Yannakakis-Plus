create or replace view aggJoin7815910684919266995 as (
with aggView1803562873664345024 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView1803562873664345024 where n.id=aggView1803562873664345024.v42 and gender= 'f');
create or replace view aggJoin8057376197538150211 as (
with aggView7178802635330992603 as (select v42, v43 from aggJoin7815910684919266995 group by v42,v43)
select v42, v43 from aggView7178802635330992603 where v43 LIKE '%Angel%');
create or replace view aggJoin2554573696989472664 as (
with aggView875331287870151506 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView875331287870151506 where mc.company_id=aggView875331287870151506.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin3740081915872968203 as (
with aggView5502838854251362353 as (select v53 from aggJoin2554573696989472664 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView5502838854251362353 where t.id=aggView5502838854251362353.v53 and production_year>=2007 and production_year<=2008);
create or replace view aggJoin7622094261114558268 as (
with aggView8927426097395703169 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView8927426097395703169 where mi.info_type_id=aggView8927426097395703169.v30 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin5490802689462089397 as (
with aggView9174189604002331928 as (select v53 from aggJoin7622094261114558268 group by v53)
select v53, v54, v57 from aggJoin3740081915872968203 join aggView9174189604002331928 using(v53));
create or replace view aggJoin6782481462478777600 as (
with aggView403452077192522572 as (select v54, v53 from aggJoin5490802689462089397 group by v54,v53)
select v53, v54 from aggView403452077192522572 where v54 LIKE '%Kung%Fu%Panda%');
create or replace view aggJoin2488669068004098325 as (
with aggView8121410464285648673 as (select v42, MIN(v43) as v65 from aggJoin8057376197538150211 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView8121410464285648673 where ci.person_id=aggView8121410464285648673.v42 and note= '(voice)');
create or replace view aggJoin7246531127466976868 as (
with aggView8267564255143782797 as (select id as v9 from char_name as chn)
select v53, v20, v51, v65 from aggJoin2488669068004098325 join aggView8267564255143782797 using(v9));
create or replace view aggJoin5811095694340975855 as (
with aggView4504286155651186530 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v20, v65 from aggJoin7246531127466976868 join aggView4504286155651186530 using(v51));
create or replace view aggJoin8921829088627741916 as (
with aggView6989342159199989499 as (select v53, MIN(v65) as v65 from aggJoin5811095694340975855 group by v53,v65)
select v54, v65 from aggJoin6782481462478777600 join aggView6989342159199989499 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin8921829088627741916;
