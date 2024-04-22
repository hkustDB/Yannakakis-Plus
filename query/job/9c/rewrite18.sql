create or replace view aggJoin6777805485062810261 as (
with aggView9011409648212737593 as (select id as v9, name as v59 from char_name as chn)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView9011409648212737593 where ci.person_role_id=aggView9011409648212737593.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3762812664607367593 as (
with aggView6005488208311557778 as (select id as v35, name as v60 from name as n where name LIKE '%An%' and gender= 'f')
select v35, v18, v20, v22, v59, v60 from aggJoin6777805485062810261 join aggView6005488208311557778 using(v35));
create or replace view aggJoin5580550641457443412 as (
with aggView8632117295599676882 as (select person_id as v35, MIN(name) as v58 from aka_name as an group by person_id)
select v18, v20, v22, v59 as v59, v60 as v60, v58 from aggJoin3762812664607367593 join aggView8632117295599676882 using(v35));
create or replace view aggJoin4653968157642653953 as (
with aggView5416765223863622769 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v59, v60, v58 from aggJoin5580550641457443412 join aggView5416765223863622769 using(v22));
create or replace view aggJoin1611702465208821060 as (
with aggView7511789341708261524 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView7511789341708261524 where mc.company_id=aggView7511789341708261524.v32);
create or replace view aggJoin6035942465145806863 as (
with aggView3440456647256215483 as (select v18 from aggJoin1611702465208821060 group by v18)
select id as v18, title as v47 from title as t, aggView3440456647256215483 where t.id=aggView3440456647256215483.v18);
create or replace view aggJoin3610848883451590321 as (
with aggView5450500717453064840 as (select v18, MIN(v59) as v59, MIN(v60) as v60, MIN(v58) as v58 from aggJoin4653968157642653953 group by v18,v58,v60,v59)
select v47, v59, v60, v58 from aggJoin6035942465145806863 join aggView5450500717453064840 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v47) as v61 from aggJoin3610848883451590321;
