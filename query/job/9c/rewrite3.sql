create or replace view aggView7749787541516536026 as select name as v36, id as v35 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggView4921513090148030172 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView6263364892825452473 as select name as v10, id as v9 from char_name as chn;
create or replace view aggJoin8315037545824254937 as (
with aggView6242424974500705826 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView6242424974500705826 where mc.company_id=aggView6242424974500705826.v32);
create or replace view aggJoin395198841182193762 as (
with aggView1309358271024350425 as (select v18 from aggJoin8315037545824254937 group by v18)
select id as v18, title as v47 from title as t, aggView1309358271024350425 where t.id=aggView1309358271024350425.v18);
create or replace view aggView5043564212423584028 as select v18, v47 from aggJoin395198841182193762 group by v18,v47;
create or replace view aggJoin6152073461735338879 as (
with aggView5946896376618565160 as (select v35, MIN(v36) as v60 from aggView7749787541516536026 group by v35)
select v35, v3, v60 from aggView4921513090148030172 join aggView5946896376618565160 using(v35));
create or replace view aggJoin1691858355142174691 as (
with aggView6917471462582732355 as (select v9, MIN(v10) as v59 from aggView6263364892825452473 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView6917471462582732355 where ci.person_role_id=aggView6917471462582732355.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4608108437857763957 as (
with aggView8561739796672500435 as (select v18, MIN(v47) as v61 from aggView5043564212423584028 group by v18)
select v35, v20, v22, v59 as v59, v61 from aggJoin1691858355142174691 join aggView8561739796672500435 using(v18));
create or replace view aggJoin929726290639106753 as (
with aggView3668996581964640828 as (select id as v22 from role_type as rt where role= 'actress')
select v35, v20, v59, v61 from aggJoin4608108437857763957 join aggView3668996581964640828 using(v22));
create or replace view aggJoin1429412556059978843 as (
with aggView6858299386748728684 as (select v35, MIN(v59) as v59, MIN(v61) as v61 from aggJoin929726290639106753 group by v35,v61,v59)
select v3, v60 as v60, v59, v61 from aggJoin6152073461735338879 join aggView6858299386748728684 using(v35));
select MIN(v3) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin1429412556059978843;
