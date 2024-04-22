create or replace view aggView7137329047162505776 as select name as v10, id as v9 from char_name as chn;
create or replace view aggJoin6302591480282387493 as (
with aggView6427065600108884579 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView6427065600108884579 where mc.company_id=aggView6427065600108884579.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin5722744660665876535 as (
with aggView1083092862247421537 as (select v18 from aggJoin6302591480282387493 group by v18)
select id as v18, title as v47, production_year as v50 from title as t, aggView1083092862247421537 where t.id=aggView1083092862247421537.v18 and production_year>=2005 and production_year<=2015);
create or replace view aggView3185365751025646930 as select v18, v47 from aggJoin5722744660665876535 group by v18,v47;
create or replace view aggJoin2290786994777421069 as (
with aggView5296716933610261690 as (select id as v35 from name as n where gender= 'f' and name LIKE '%Ang%')
select person_id as v35, name as v3 from aka_name as an, aggView5296716933610261690 where an.person_id=aggView5296716933610261690.v35);
create or replace view aggView3422627297198072122 as select v3, v35 from aggJoin2290786994777421069 group by v3,v35;
create or replace view aggJoin4997716870582499585 as (
with aggView7200457335113417493 as (select v35, MIN(v3) as v58 from aggView3422627297198072122 group by v35)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v58 from cast_info as ci, aggView7200457335113417493 where ci.person_id=aggView7200457335113417493.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin785008315287740098 as (
with aggView5632890431184478186 as (select v18, MIN(v47) as v60 from aggView3185365751025646930 group by v18)
select v9, v20, v22, v58 as v58, v60 from aggJoin4997716870582499585 join aggView5632890431184478186 using(v18));
create or replace view aggJoin4996740552301326102 as (
with aggView993916349880717865 as (select id as v22 from role_type as rt where role= 'actress')
select v9, v20, v58, v60 from aggJoin785008315287740098 join aggView993916349880717865 using(v22));
create or replace view aggJoin4916889605183275096 as (
with aggView3898950976794669301 as (select v9, MIN(v58) as v58, MIN(v60) as v60 from aggJoin4996740552301326102 group by v9,v60,v58)
select v10, v58, v60 from aggView7137329047162505776 join aggView3898950976794669301 using(v9));
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60 from aggJoin4916889605183275096;
