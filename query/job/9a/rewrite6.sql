create or replace view aggView6152577068770907706 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView8742111866617331882 as select id as v18, title as v47 from title as t where production_year>=2005 and production_year<=2015;
create or replace view aggJoin6524728490891023920 as (
with aggView8188497246923860335 as (select id as v35 from name as n where gender= 'f' and name LIKE '%Ang%')
select person_id as v35, name as v3 from aka_name as an, aggView8188497246923860335 where an.person_id=aggView8188497246923860335.v35);
create or replace view aggView3252038151562256554 as select v3, v35 from aggJoin6524728490891023920 group by v3,v35;
create or replace view aggJoin3190937633525899705 as (
with aggView5768911954473018090 as (select v18, MIN(v47) as v60 from aggView8742111866617331882 group by v18)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60 from cast_info as ci, aggView5768911954473018090 where ci.movie_id=aggView5768911954473018090.v18 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin5515685116386077924 as (
with aggView2224794735789790940 as (select v35, MIN(v3) as v58 from aggView3252038151562256554 group by v35)
select v18, v9, v20, v22, v60 as v60, v58 from aggJoin3190937633525899705 join aggView2224794735789790940 using(v35));
create or replace view aggJoin3902158247468101707 as (
with aggView1786273481225239045 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18, note as v34 from movie_companies as mc, aggView1786273481225239045 where mc.company_id=aggView1786273481225239045.v32 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')));
create or replace view aggJoin3085875477305578255 as (
with aggView8399123558623102016 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v9, v20, v60, v58 from aggJoin5515685116386077924 join aggView8399123558623102016 using(v22));
create or replace view aggJoin7182324362254143441 as (
with aggView8038039593194445608 as (select v18 from aggJoin3902158247468101707 group by v18)
select v9, v20, v60 as v60, v58 as v58 from aggJoin3085875477305578255 join aggView8038039593194445608 using(v18));
create or replace view aggJoin3707711348163372019 as (
with aggView4186311789752901648 as (select v9, MIN(v60) as v60, MIN(v58) as v58 from aggJoin7182324362254143441 group by v9,v60,v58)
select v10, v60, v58 from aggView6152577068770907706 join aggView4186311789752901648 using(v9));
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60 from aggJoin3707711348163372019;
