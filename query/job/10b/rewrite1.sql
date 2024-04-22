create or replace view aggView8781098118276096972 as select id as v1, name as v2 from char_name as chn;
create or replace view aggJoin6157826080348710387 as (
with aggView6735800012446838642 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView6735800012446838642 where mc.company_type_id=aggView6735800012446838642.v22);
create or replace view aggJoin2318695556878874322 as (
with aggView1308197692108438951 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31 from aggJoin6157826080348710387 join aggView1308197692108438951 using(v15));
create or replace view aggJoin5946652481038382981 as (
with aggView315817518834143147 as (select v31 from aggJoin2318695556878874322 group by v31)
select id as v31, title as v32, production_year as v35 from title as t, aggView315817518834143147 where t.id=aggView315817518834143147.v31 and production_year>2010);
create or replace view aggView1456233738860568273 as select v32, v31 from aggJoin5946652481038382981 group by v32,v31;
create or replace view aggJoin7204894115596448296 as (
with aggView3600193002407948874 as (select v1, MIN(v2) as v43 from aggView8781098118276096972 group by v1)
select movie_id as v31, note as v12, role_id as v29, v43 from cast_info as ci, aggView3600193002407948874 where ci.person_role_id=aggView3600193002407948874.v1 and note LIKE '%(producer)%');
create or replace view aggJoin7945664624988475989 as (
with aggView95654976109986969 as (select id as v29 from role_type as rt where role= 'actor')
select v31, v12, v43 from aggJoin7204894115596448296 join aggView95654976109986969 using(v29));
create or replace view aggJoin9021934283962951419 as (
with aggView7309456901803627614 as (select v31, MIN(v43) as v43 from aggJoin7945664624988475989 group by v31,v43)
select v32, v43 from aggView1456233738860568273 join aggView7309456901803627614 using(v31));
select MIN(v43) as v43,MIN(v32) as v44 from aggJoin9021934283962951419;
