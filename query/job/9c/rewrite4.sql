create or replace view aggJoin584043476424640903 as (
with aggView8189267361277256118 as (select id as v35, name as v60 from name as n where name LIKE '%An%' and gender= 'f')
select person_id as v35, name as v3, v60 from aka_name as an, aggView8189267361277256118 where an.person_id=aggView8189267361277256118.v35);
create or replace view aggJoin3147537318959145800 as (
with aggView4147710658733916713 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin584043476424640903 group by v35,v60)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60, v58 from cast_info as ci, aggView4147710658733916713 where ci.person_id=aggView4147710658733916713.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin6143813137424279312 as (
with aggView1764479281809039173 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v9, v20, v60, v58 from aggJoin3147537318959145800 join aggView1764479281809039173 using(v22));
create or replace view aggJoin2930187929070236312 as (
with aggView2422320485377495909 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView2422320485377495909 where mc.company_id=aggView2422320485377495909.v32);
create or replace view aggJoin375651985536087976 as (
with aggView5351526376320253254 as (select v18 from aggJoin2930187929070236312 group by v18)
select id as v18, title as v47 from title as t, aggView5351526376320253254 where t.id=aggView5351526376320253254.v18);
create or replace view aggJoin6708592396410888262 as (
with aggView8539302716903123100 as (select v18, MIN(v47) as v61 from aggJoin375651985536087976 group by v18)
select v9, v20, v60 as v60, v58 as v58, v61 from aggJoin6143813137424279312 join aggView8539302716903123100 using(v18));
create or replace view aggJoin2788621375531115467 as (
with aggView6354057336316891465 as (select v9, MIN(v60) as v60, MIN(v58) as v58, MIN(v61) as v61 from aggJoin6708592396410888262 group by v9,v61,v60,v58)
select name as v10, v60, v58, v61 from char_name as chn, aggView6354057336316891465 where chn.id=aggView6354057336316891465.v9);
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin2788621375531115467;
