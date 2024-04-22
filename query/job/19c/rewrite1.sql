create or replace view aggJoin6030262739665558528 as (
with aggView5648884599202356580 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView5648884599202356580 where mi.info_type_id=aggView5648884599202356580.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin4184713828824378678 as (
with aggView7131853492755747744 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView7131853492755747744 where mc.company_id=aggView7131853492755747744.v23);
create or replace view aggJoin6685177301778431188 as (
with aggView1811960213309813322 as (select v53 from aggJoin4184713828824378678 group by v53)
select v53, v40 from aggJoin6030262739665558528 join aggView1811960213309813322 using(v53));
create or replace view aggJoin7056499342520488558 as (
with aggView8796614910086909940 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView8796614910086909940 where n.id=aggView8796614910086909940.v42 and name LIKE '%An%' and gender= 'f');
create or replace view aggView403851883219011251 as select v43, v42 from aggJoin7056499342520488558 group by v43,v42;
create or replace view aggJoin7673692554492526173 as (
with aggView5763237476736969539 as (select v53 from aggJoin6685177301778431188 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView5763237476736969539 where t.id=aggView5763237476736969539.v53 and production_year>2000);
create or replace view aggView4417225205205942866 as select v53, v54 from aggJoin7673692554492526173 group by v53,v54;
create or replace view aggJoin4254002685365509539 as (
with aggView6561685208947922358 as (select v42, MIN(v43) as v65 from aggView403851883219011251 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView6561685208947922358 where ci.person_id=aggView6561685208947922358.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin948562650293269334 as (
with aggView8104822510547750247 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v65 from aggJoin4254002685365509539 join aggView8104822510547750247 using(v51));
create or replace view aggJoin6968467128213241934 as (
with aggView8029031118392621535 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin948562650293269334 join aggView8029031118392621535 using(v9));
create or replace view aggJoin7680755761465985561 as (
with aggView2471252165709039087 as (select v53, MIN(v65) as v65 from aggJoin6968467128213241934 group by v53,v65)
select v54, v65 from aggView4417225205205942866 join aggView2471252165709039087 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin7680755761465985561;
