create or replace view aggJoin4849167518378456557 as (
with aggView6091690500547993158 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView6091690500547993158 where mc.company_id=aggView6091690500547993158.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3502893191255112195 as (
with aggView8764861172664927905 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView8764861172664927905 where mi_idx.info_type_id=aggView8764861172664927905.v20 and info>'6.5');
create or replace view aggJoin6332914944730514377 as (
with aggView4242204970509293426 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView4242204970509293426 where cc.status_id=aggView4242204970509293426.v7);
create or replace view aggJoin2209293681658710356 as (
with aggView3381576898514820748 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin4849167518378456557 join aggView3381576898514820748 using(v16));
create or replace view aggJoin7821336387168513966 as (
with aggView8322620097887895117 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView8322620097887895117 where t.kind_id=aggView8322620097887895117.v25 and production_year>2005);
create or replace view aggJoin7761548194092090179 as (
with aggView6232239749231952112 as (select v45, MIN(v46) as v59 from aggJoin7821336387168513966 group by v45)
select v45, v31, v57 as v57, v59 from aggJoin2209293681658710356 join aggView6232239749231952112 using(v45));
create or replace view aggJoin3903412611662268951 as (
with aggView3328787550651025044 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin6332914944730514377 join aggView3328787550651025044 using(v5));
create or replace view aggJoin1208576211147889333 as (
with aggView5656722354019638078 as (select v45 from aggJoin3903412611662268951 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView5656722354019638078 where mi.movie_id=aggView5656722354019638078.v45 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin4920672373079470337 as (
with aggView7447827756120787313 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin1208576211147889333 join aggView7447827756120787313 using(v18));
create or replace view aggJoin5764534085204513573 as (
with aggView7913330340346449163 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView7913330340346449163 where mk.keyword_id=aggView7913330340346449163.v22);
create or replace view aggJoin4565439921956352485 as (
with aggView8853595673948223522 as (select v45, MIN(v57) as v57, MIN(v59) as v59 from aggJoin7761548194092090179 group by v45,v59,v57)
select v45, v35, v57, v59 from aggJoin4920672373079470337 join aggView8853595673948223522 using(v45));
create or replace view aggJoin8786448357605986195 as (
with aggView391910923918314008 as (select v45, MIN(v57) as v57, MIN(v59) as v59 from aggJoin4565439921956352485 group by v45,v59,v57)
select v45, v40, v57, v59 from aggJoin3502893191255112195 join aggView391910923918314008 using(v45));
create or replace view aggJoin1028605458539761022 as (
with aggView5712940525460002768 as (select v45, MIN(v57) as v57, MIN(v59) as v59, MIN(v40) as v58 from aggJoin8786448357605986195 group by v45,v59,v57)
select v57, v59, v58 from aggJoin5764534085204513573 join aggView5712940525460002768 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin1028605458539761022;
