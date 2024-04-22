create or replace view aggJoin1993633531679607379 as (
with aggView8620633642425632592 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView8620633642425632592 where n.id=aggView8620633642425632592.v42 and name LIKE '%Ang%' and gender= 'f');
create or replace view aggJoin7418067044707718340 as (
with aggView8936062967318387640 as (select v42, MIN(v43) as v65 from aggJoin1993633531679607379 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView8936062967318387640 where ci.person_id=aggView8936062967318387640.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6472080394524616314 as (
with aggView3874972644470860525 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView3874972644470860525 where mc.company_id=aggView3874972644470860525.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin1660011115024404293 as (
with aggView5135555401151887970 as (select v53 from aggJoin6472080394524616314 group by v53)
select movie_id as v53, info_type_id as v30, info as v40 from movie_info as mi, aggView5135555401151887970 where mi.movie_id=aggView5135555401151887970.v53 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin8545131276999396595 as (
with aggView2922518555548762148 as (select id as v30 from info_type as it where info= 'release dates')
select v53, v40 from aggJoin1660011115024404293 join aggView2922518555548762148 using(v30));
create or replace view aggJoin7727827558160036189 as (
with aggView7460817213045410617 as (select v53 from aggJoin8545131276999396595 group by v53)
select id as v53, title as v54, production_year as v57 from title as t, aggView7460817213045410617 where t.id=aggView7460817213045410617.v53 and production_year>=2005 and production_year<=2009);
create or replace view aggJoin3201823830274272032 as (
with aggView2394302998648878182 as (select v53, MIN(v54) as v66 from aggJoin7727827558160036189 group by v53)
select v9, v20, v51, v65 as v65, v66 from aggJoin7418067044707718340 join aggView2394302998648878182 using(v53));
create or replace view aggJoin6322406923446767281 as (
with aggView6366617778831761579 as (select id as v51 from role_type as rt where role= 'actress')
select v9, v20, v65, v66 from aggJoin3201823830274272032 join aggView6366617778831761579 using(v51));
create or replace view aggJoin784262180921837951 as (
with aggView5306260550136466549 as (select v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin6322406923446767281 group by v9,v66,v65)
select v65, v66 from char_name as chn, aggView5306260550136466549 where chn.id=aggView5306260550136466549.v9);
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin784262180921837951;
