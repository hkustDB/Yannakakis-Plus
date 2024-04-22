create or replace view aggJoin4768912796160095507 as (
with aggView6690032129800664001 as (select id as v42, name as v43 from name as n where gender= 'f')
select v42, v43 from aggView6690032129800664001 where v43 LIKE '%Angel%');
create or replace view aggJoin2276689824751116665 as (
with aggView1189000333188647354 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView1189000333188647354 where mc.company_id=aggView1189000333188647354.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin6150717990767660090 as (
with aggView1291744499816278703 as (select v53 from aggJoin2276689824751116665 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView1291744499816278703 where t.id=aggView1291744499816278703.v53 and production_year>=2007 and production_year<=2008 and title LIKE '%Kung%Fu%Panda%');
create or replace view aggView4116696730278804167 as select v54, v53 from aggJoin6150717990767660090 group by v54,v53;
create or replace view aggJoin6962544731774868002 as (
with aggView4681358066134042848 as (select v42, MIN(v43) as v65 from aggJoin4768912796160095507 group by v42)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView4681358066134042848 where ci.person_id=aggView4681358066134042848.v42 and note= '(voice)');
create or replace view aggJoin6233782615040450171 as (
with aggView7317199617364513437 as (select person_id as v42 from aka_name as an group by person_id)
select v53, v9, v20, v51, v65 as v65 from aggJoin6962544731774868002 join aggView7317199617364513437 using(v42));
create or replace view aggJoin1816360204922566870 as (
with aggView4146083204428180151 as (select id as v9 from char_name as chn)
select v53, v20, v51, v65 from aggJoin6233782615040450171 join aggView4146083204428180151 using(v9));
create or replace view aggJoin2150526818579465250 as (
with aggView3058342137231911831 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v20, v65 from aggJoin1816360204922566870 join aggView3058342137231911831 using(v51));
create or replace view aggJoin7947943799359870790 as (
with aggView312524024021926081 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView312524024021926081 where mi.info_type_id=aggView312524024021926081.v30 and ((info LIKE 'Japan:%2007%') OR (info LIKE 'USA:%2008%')));
create or replace view aggJoin4743992604985293783 as (
with aggView5416450302067227808 as (select v53 from aggJoin7947943799359870790 group by v53)
select v53, v20, v65 as v65 from aggJoin2150526818579465250 join aggView5416450302067227808 using(v53));
create or replace view aggJoin2312375022537708905 as (
with aggView7629695704173609449 as (select v53, MIN(v65) as v65 from aggJoin4743992604985293783 group by v53,v65)
select v54, v65 from aggView4116696730278804167 join aggView7629695704173609449 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin2312375022537708905;
