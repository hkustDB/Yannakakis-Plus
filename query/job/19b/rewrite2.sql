create or replace view aggJoin5807870639786355817 as (
with aggView1444590335890344278 as (select id as v42, name as v65 from name as n where gender= 'f' and name LIKE '%Angel%')
select person_id as v42, v65 from aka_name as an, aggView1444590335890344278 where an.person_id=aggView1444590335890344278.v42);
create or replace view aggJoin4540363579088713485 as (
with aggView925944786870820668 as (select id as v53, title as v66 from title as t where production_year>=2007 and production_year<=2008 and title LIKE '%Kung%Fu%Panda%')
select movie_id as v53, info_type_id as v30, info as v40, v66 from movie_info as mi, aggView925944786870820668 where mi.movie_id=aggView925944786870820668.v53 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin6560230313471230513 as (
with aggView6861155286575765598 as (select v42, MIN(v65) as v65 from aggJoin5807870639786355817 group by v42,v65)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView6861155286575765598 where ci.person_id=aggView6861155286575765598.v42 and note= '(voice)');
create or replace view aggJoin647139462164067426 as (
with aggView2214881945106209247 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView2214881945106209247 where mc.company_id=aggView2214881945106209247.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin3858955421236425581 as (
with aggView1223317061249678215 as (select v53 from aggJoin647139462164067426 group by v53)
select v53, v30, v40, v66 as v66 from aggJoin4540363579088713485 join aggView1223317061249678215 using(v53));
create or replace view aggJoin8662474494150540903 as (
with aggView5503926128313016497 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40, v66 from aggJoin3858955421236425581 join aggView5503926128313016497 using(v30));
create or replace view aggJoin3222657680518498678 as (
with aggView944088390345649480 as (select v53, MIN(v66) as v66 from aggJoin8662474494150540903 group by v53,v66)
select v9, v20, v51, v65 as v65, v66 from aggJoin6560230313471230513 join aggView944088390345649480 using(v53));
create or replace view aggJoin674002161639409159 as (
with aggView1196558744783691434 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin3222657680518498678 join aggView1196558744783691434 using(v51));
create or replace view aggJoin2554108961849840896 as (
with aggView8506886601820517349 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin674002161639409159 group by v9,v65,v66)
select v65, v66 from char_name as chn, aggView8506886601820517349 where chn.id=aggView8506886601820517349.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin2554108961849840896;
