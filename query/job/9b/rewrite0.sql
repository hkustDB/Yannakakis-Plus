create or replace view aggView4668611245775010630 as select name as v3, person_id as v35 from aka_name as an group by name,person_id;
create or replace view aggJoin9141542170672399439 as (
with aggView3500779326754033830 as (select name as v36, id as v35 from name as n where gender= 'f')
select v35, v36 from aggView3500779326754033830 where v36 LIKE '%Angel%');
create or replace view aggView6894147537972746771 as select id as v9, name as v10 from char_name as chn;
create or replace view aggJoin2312011740936872468 as (
with aggView5112615833874609272 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView5112615833874609272 where mc.company_id=aggView5112615833874609272.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%');
create or replace view aggJoin5129572784023906595 as (
with aggView8387860814241475282 as (select v18 from aggJoin2312011740936872468 group by v18)
select id as v18, title as v47, production_year as v50 from title as t, aggView8387860814241475282 where t.id=aggView8387860814241475282.v18 and production_year>=2007 and production_year<=2010);
create or replace view aggView8965872728591849957 as select v47, v18 from aggJoin5129572784023906595 group by v47,v18;
create or replace view aggJoin8936403293926157854 as (
with aggView5441338222416758716 as (select v35, MIN(v36) as v60 from aggJoin9141542170672399439 group by v35)
select v3, v35, v60 from aggView4668611245775010630 join aggView5441338222416758716 using(v35));
create or replace view aggJoin1848287178697989858 as (
with aggView5418968989003654386 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin8936403293926157854 group by v35,v60)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60, v58 from cast_info as ci, aggView5418968989003654386 where ci.person_id=aggView5418968989003654386.v35 and note= '(voice)');
create or replace view aggJoin792183266584437463 as (
with aggView1287924626220247124 as (select v9, MIN(v10) as v59 from aggView6894147537972746771 group by v9)
select v18, v20, v22, v60 as v60, v58 as v58, v59 from aggJoin1848287178697989858 join aggView1287924626220247124 using(v9));
create or replace view aggJoin5586476009605110445 as (
with aggView8615059673660648909 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v20, v60, v58, v59 from aggJoin792183266584437463 join aggView8615059673660648909 using(v22));
create or replace view aggJoin1066476544877323745 as (
with aggView4673606510517983446 as (select v18, MIN(v60) as v60, MIN(v58) as v58, MIN(v59) as v59 from aggJoin5586476009605110445 group by v18,v59,v58,v60)
select v47, v60, v58, v59 from aggView8965872728591849957 join aggView4673606510517983446 using(v18));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60,MIN(v47) as v61 from aggJoin1066476544877323745;
