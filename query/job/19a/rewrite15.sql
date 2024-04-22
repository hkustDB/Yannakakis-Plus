create or replace view aggView5676772623134398790 as select id as v53, title as v54 from title as t where production_year>=2005 and production_year<=2009;
create or replace view aggJoin8999764479178065295 as (
with aggView7710648200025749834 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView7710648200025749834 where n.id=aggView7710648200025749834.v42 and name LIKE '%Ang%' and gender= 'f');
create or replace view aggView4018274132690598629 as select v42, v43 from aggJoin8999764479178065295 group by v42,v43;
create or replace view aggJoin2032951592802824641 as (
with aggView7689130113015022491 as (select v53, MIN(v54) as v66 from aggView5676772623134398790 group by v53)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView7689130113015022491 where ci.movie_id=aggView7689130113015022491.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin2905254714971332319 as (
with aggView8635717485238244483 as (select id as v9 from char_name as chn)
select v42, v53, v20, v51, v66 from aggJoin2032951592802824641 join aggView8635717485238244483 using(v9));
create or replace view aggJoin4785696173582483236 as (
with aggView3889344470627778431 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53, note as v36 from movie_companies as mc, aggView3889344470627778431 where mc.company_id=aggView3889344470627778431.v23 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin3003344389367655704 as (
with aggView2029467698785227728 as (select v53 from aggJoin4785696173582483236 group by v53)
select v42, v53, v20, v51, v66 as v66 from aggJoin2905254714971332319 join aggView2029467698785227728 using(v53));
create or replace view aggJoin3512426481344130615 as (
with aggView3417531290308817850 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView3417531290308817850 where mi.info_type_id=aggView3417531290308817850.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin5246025118419740070 as (
with aggView2410691001772900925 as (select v53 from aggJoin3512426481344130615 group by v53)
select v42, v20, v51, v66 as v66 from aggJoin3003344389367655704 join aggView2410691001772900925 using(v53));
create or replace view aggJoin682536925004685269 as (
with aggView2742185946315295088 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v20, v66 from aggJoin5246025118419740070 join aggView2742185946315295088 using(v51));
create or replace view aggJoin3273779362081059960 as (
with aggView8910130374629481831 as (select v42, MIN(v66) as v66 from aggJoin682536925004685269 group by v42,v66)
select v43, v66 from aggView4018274132690598629 join aggView8910130374629481831 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin3273779362081059960;
