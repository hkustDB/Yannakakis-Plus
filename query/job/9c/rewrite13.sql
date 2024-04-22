create or replace view aggView8800927896226597875 as select id as v18, title as v47 from title as t;
create or replace view aggView7424503358175238604 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView4574837469761448224 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView2777454741616380181 as select name as v36, id as v35 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggJoin3408273300415760817 as (
with aggView9201620502327403297 as (select v18, MIN(v47) as v61 from aggView8800927896226597875 group by v18)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v61 from cast_info as ci, aggView9201620502327403297 where ci.movie_id=aggView9201620502327403297.v18 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin8080308554252599764 as (
with aggView8635757990027124895 as (select v35, MIN(v36) as v60 from aggView2777454741616380181 group by v35)
select v35, v3, v60 from aggView4574837469761448224 join aggView8635757990027124895 using(v35));
create or replace view aggJoin941210524171163217 as (
with aggView6895576464069027178 as (select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin8080308554252599764 group by v35,v60)
select v18, v9, v20, v22, v61 as v61, v60, v58 from aggJoin3408273300415760817 join aggView6895576464069027178 using(v35));
create or replace view aggJoin7979454299361022872 as (
with aggView6542891750261214301 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v9, v20, v61, v60, v58 from aggJoin941210524171163217 join aggView6542891750261214301 using(v22));
create or replace view aggJoin4154968626188298694 as (
with aggView8996789244484071151 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView8996789244484071151 where mc.company_id=aggView8996789244484071151.v32);
create or replace view aggJoin885953531625499316 as (
with aggView1507821453149202531 as (select v18 from aggJoin4154968626188298694 group by v18)
select v9, v20, v61 as v61, v60 as v60, v58 as v58 from aggJoin7979454299361022872 join aggView1507821453149202531 using(v18));
create or replace view aggJoin6473949591189274095 as (
with aggView559409310997904264 as (select v9, MIN(v61) as v61, MIN(v60) as v60, MIN(v58) as v58 from aggJoin885953531625499316 group by v9,v61,v60,v58)
select v10, v61, v60, v58 from aggView7424503358175238604 join aggView559409310997904264 using(v9));
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin6473949591189274095;
