create or replace view aggJoin989417694556626799 as (
with aggView865239638774525412 as (select id as v53, title as v66 from title as t where production_year>2000)
select movie_id as v53, company_id as v23, v66 from movie_companies as mc, aggView865239638774525412 where mc.movie_id=aggView865239638774525412.v53);
create or replace view aggJoin5648002314337175147 as (
with aggView3136956906659052044 as (select id as v42, name as v65 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v42, v65 from aka_name as an, aggView3136956906659052044 where an.person_id=aggView3136956906659052044.v42);
create or replace view aggJoin1282233289857212912 as (
with aggView1976558145716902537 as (select id as v51 from role_type as rt where role= 'actress')
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20 from cast_info as ci, aggView1976558145716902537 where ci.role_id=aggView1976558145716902537.v51 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin1886152198229457395 as (
with aggView6248581817759569310 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView6248581817759569310 where mi.info_type_id=aggView6248581817759569310.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin4003748962465739674 as (
with aggView4364982074275614925 as (select v42, MIN(v65) as v65 from aggJoin5648002314337175147 group by v42,v65)
select v53, v9, v20, v65 from aggJoin1282233289857212912 join aggView4364982074275614925 using(v42));
create or replace view aggJoin5184515997413444509 as (
with aggView1126602356021965036 as (select id as v23 from company_name as cn where country_code= '[us]')
select v53, v66 from aggJoin989417694556626799 join aggView1126602356021965036 using(v23));
create or replace view aggJoin8868155045850490955 as (
with aggView2761397178039922976 as (select v53 from aggJoin1886152198229457395 group by v53)
select v53, v9, v20, v65 as v65 from aggJoin4003748962465739674 join aggView2761397178039922976 using(v53));
create or replace view aggJoin1842913573320559380 as (
with aggView4022366399165947315 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin8868155045850490955 join aggView4022366399165947315 using(v9));
create or replace view aggJoin7400530263202091328 as (
with aggView955368679016864251 as (select v53, MIN(v65) as v65 from aggJoin1842913573320559380 group by v53,v65)
select v66 as v66, v65 from aggJoin5184515997413444509 join aggView955368679016864251 using(v53));
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin7400530263202091328;
