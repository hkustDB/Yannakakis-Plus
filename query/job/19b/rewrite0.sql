create or replace view aggJoin1256147718230219248 as (
with aggView2903247677443607107 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView2903247677443607107 where n.id=aggView2903247677443607107.v42 and gender= 'f');
create or replace view aggJoin6312087264720976599 as (
with aggView4537687413331313878 as (select v42, v43 from aggJoin1256147718230219248 group by v42,v43)
select v42, v43 from aggView4537687413331313878 where v43 LIKE '%Angel%');
create or replace view aggJoin258481839040643116 as (
with aggView8209510538135560737 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView8209510538135560737 where mi.info_type_id=aggView8209510538135560737.v30 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin3432125603522876618 as (
with aggView6116443019454486337 as (select v53 from aggJoin258481839040643116 group by v53)
select movie_id as v53, company_id as v23, note as v36 from movie_companies as mc, aggView6116443019454486337 where mc.movie_id=aggView6116443019454486337.v53 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin6743258679436714121 as (
with aggView3375715081264898270 as (select id as v23 from company_name as cn where country_code= '[us]')
select v53, v36 from aggJoin3432125603522876618 join aggView3375715081264898270 using(v23));
create or replace view aggJoin8055221297194756742 as (
with aggView3729227384214589801 as (select v53 from aggJoin6743258679436714121 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView3729227384214589801 where t.id=aggView3729227384214589801.v53 and production_year>=2007 and production_year<=2008 and title LIKE '%Kung%Fu%Panda%');
create or replace view aggView7280332033268611951 as select v54, v53 from aggJoin8055221297194756742 group by v54,v53;
create or replace view aggJoin6782079539851547071 as (
with aggView4262783208366226858 as (select v42, MIN(v43) as v65 from aggJoin6312087264720976599 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView4262783208366226858 where ci.person_id=aggView4262783208366226858.v42 and note= '(voice)');
create or replace view aggJoin311655671025594741 as (
with aggView2308589695803967569 as (select id as v9 from char_name as chn)
select v53, v20, v51, v65 from aggJoin6782079539851547071 join aggView2308589695803967569 using(v9));
create or replace view aggJoin7516046599971724972 as (
with aggView8839997316665492761 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v20, v65 from aggJoin311655671025594741 join aggView8839997316665492761 using(v51));
create or replace view aggJoin3286160345816580501 as (
with aggView9162387455584860587 as (select v53, MIN(v65) as v65 from aggJoin7516046599971724972 group by v53,v65)
select v54, v65 from aggView7280332033268611951 join aggView9162387455584860587 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin3286160345816580501;
