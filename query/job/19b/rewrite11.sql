create or replace view aggJoin1422323394134070965 as (
with aggView6256999516052995536 as (select id as v53, title as v66 from title as t where production_year>=2007 and production_year<=2008 and title LIKE '%Kung%Fu%Panda%')
select movie_id as v53, company_id as v23, note as v36, v66 from movie_companies as mc, aggView6256999516052995536 where mc.movie_id=aggView6256999516052995536.v53 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin5291705516137908000 as (
with aggView4577380180690885634 as (select id as v42, name as v65 from name as n where gender= 'f' and name LIKE '%Angel%')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView4577380180690885634 where ci.person_id=aggView4577380180690885634.v42 and note= '(voice)');
create or replace view aggJoin5306943707607846640 as (
with aggView4070930205569253668 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v51, v65 as v65 from aggJoin5291705516137908000 join aggView4070930205569253668 using(v42));
create or replace view aggJoin480441168116431203 as (
with aggView8878587089083412307 as (select id as v23 from company_name as cn where country_code= '[us]')
select v53, v36, v66 from aggJoin1422323394134070965 join aggView8878587089083412307 using(v23));
create or replace view aggJoin447114699372626459 as (
with aggView5864188968126160227 as (select v53, MIN(v66) as v66 from aggJoin480441168116431203 group by v53,v66)
select movie_id as v53, info_type_id as v30, info as v40, v66 from movie_info as mi, aggView5864188968126160227 where mi.movie_id=aggView5864188968126160227.v53 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin7558872198583508949 as (
with aggView2712935812700821454 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40, v66 from aggJoin447114699372626459 join aggView2712935812700821454 using(v30));
create or replace view aggJoin1463341076084388421 as (
with aggView4938417695151425284 as (select v53, MIN(v66) as v66 from aggJoin7558872198583508949 group by v53,v66)
select v9, v20, v51, v65 as v65, v66 from aggJoin5306943707607846640 join aggView4938417695151425284 using(v53));
create or replace view aggJoin4707991168970008941 as (
with aggView8435433047111010705 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin1463341076084388421 join aggView8435433047111010705 using(v51));
create or replace view aggJoin2562838533037860446 as (
with aggView2688020240443940819 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin4707991168970008941 group by v9,v65,v66)
select v65, v66 from char_name as chn, aggView2688020240443940819 where chn.id=aggView2688020240443940819.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin2562838533037860446;
