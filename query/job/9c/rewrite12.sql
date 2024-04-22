create or replace view aggView6770481313638437891 as select id as v18, title as v47 from title as t;
create or replace view aggView6685595122687858584 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView6193796150155418024 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView5985041027863868094 as select name as v36, id as v35 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggJoin7605377638500096021 as (
with aggView4683005414399202646 as (select v18, MIN(v47) as v61 from aggView6770481313638437891 group by v18)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v61 from cast_info as ci, aggView4683005414399202646 where ci.movie_id=aggView4683005414399202646.v18 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6390762171546510023 as (
with aggView4826344836966836662 as (select v35, MIN(v3) as v58 from aggView6193796150155418024 group by v35)
select v36, v35, v58 from aggView5985041027863868094 join aggView4826344836966836662 using(v35));
create or replace view aggJoin2338318965007463701 as (
with aggView23536435049008289 as (select v35, MIN(v58) as v58, MIN(v36) as v60 from aggJoin6390762171546510023 group by v35,v58)
select v18, v9, v20, v22, v61 as v61, v58, v60 from aggJoin7605377638500096021 join aggView23536435049008289 using(v35));
create or replace view aggJoin5289962775798061875 as (
with aggView453464491621337209 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v9, v20, v61, v58, v60 from aggJoin2338318965007463701 join aggView453464491621337209 using(v22));
create or replace view aggJoin5776845384147142731 as (
with aggView5691493922989324695 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView5691493922989324695 where mc.company_id=aggView5691493922989324695.v32);
create or replace view aggJoin5955303991923132317 as (
with aggView1977887326028129572 as (select v18 from aggJoin5776845384147142731 group by v18)
select v9, v20, v61 as v61, v58 as v58, v60 as v60 from aggJoin5289962775798061875 join aggView1977887326028129572 using(v18));
create or replace view aggJoin4623418508288867030 as (
with aggView974754530644644933 as (select v9, MIN(v61) as v61, MIN(v58) as v58, MIN(v60) as v60 from aggJoin5955303991923132317 group by v9,v61,v60,v58)
select v10, v61, v58, v60 from aggView6685595122687858584 join aggView974754530644644933 using(v9));
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin4623418508288867030;
