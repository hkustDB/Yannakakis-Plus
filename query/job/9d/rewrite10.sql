create or replace view aggView3587036559581561496 as select id as v18, title as v47 from title as t;
create or replace view aggView4936117904638407554 as select id as v9, name as v10 from char_name as chn;
create or replace view aggView8876939130150683209 as select name as v36, id as v35 from name as n where gender= 'f';
create or replace view aggView8835945732934619501 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin6209277066670001917 as (
with aggView1128933785563478561 as (select v35, MIN(v3) as v58 from aggView8835945732934619501 group by v35)
select v36, v35, v58 from aggView8876939130150683209 join aggView1128933785563478561 using(v35));
create or replace view aggJoin6911585100328947954 as (
with aggView2548586090752019486 as (select v35, MIN(v58) as v58, MIN(v36) as v60 from aggJoin6209277066670001917 group by v35,v58)
select movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v58, v60 from cast_info as ci, aggView2548586090752019486 where ci.person_id=aggView2548586090752019486.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin4105248065576727075 as (
with aggView3738281589218338876 as (select v18, MIN(v47) as v61 from aggView3587036559581561496 group by v18)
select v18, v9, v20, v22, v58 as v58, v60 as v60, v61 from aggJoin6911585100328947954 join aggView3738281589218338876 using(v18));
create or replace view aggJoin7083218349571732081 as (
with aggView3326583331125915504 as (select id as v22 from role_type as rt where role= 'actress')
select v18, v9, v20, v58, v60, v61 from aggJoin4105248065576727075 join aggView3326583331125915504 using(v22));
create or replace view aggJoin3950234500527048636 as (
with aggView8777928801391814683 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView8777928801391814683 where mc.company_id=aggView8777928801391814683.v32);
create or replace view aggJoin995074385630824422 as (
with aggView5676673175496343309 as (select v18 from aggJoin3950234500527048636 group by v18)
select v9, v20, v58 as v58, v60 as v60, v61 as v61 from aggJoin7083218349571732081 join aggView5676673175496343309 using(v18));
create or replace view aggJoin988142403086189904 as (
with aggView748842177184694314 as (select v9, MIN(v58) as v58, MIN(v60) as v60, MIN(v61) as v61 from aggJoin995074385630824422 group by v9,v60,v58,v61)
select v10, v58, v60, v61 from aggView4936117904638407554 join aggView748842177184694314 using(v9));
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin988142403086189904;
