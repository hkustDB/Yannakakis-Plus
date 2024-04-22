create or replace view aggJoin1788853031635078456 as (
with aggView3744903815267355246 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView3744903815267355246 where ml.link_type_id=aggView3744903815267355246.v21);
create or replace view aggJoin5262531329294755837 as (
with aggView8213401690423872760 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView8213401690423872760 where mc.company_id=aggView8213401690423872760.v25);
create or replace view aggJoin720311368680359858 as (
with aggView3650824919648218421 as (select id as v37, title as v54 from title as t where production_year= 1998)
select movie_id as v37, keyword_id as v35, v54 from movie_keyword as mk, aggView3650824919648218421 where mk.movie_id=aggView3650824919648218421.v37);
create or replace view aggJoin28564952627652323 as (
with aggView8905292954413247814 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView8905292954413247814 where cc.subject_id=aggView8905292954413247814.v5);
create or replace view aggJoin4192698901735768286 as (
with aggView5121609334611603247 as (select id as v35 from keyword as k where keyword= 'sequel')
select v37, v54 from aggJoin720311368680359858 join aggView5121609334611603247 using(v35));
create or replace view aggJoin3210560555914630058 as (
with aggView6174033674344900026 as (select v37, MIN(v53) as v53 from aggJoin1788853031635078456 group by v37,v53)
select movie_id as v37, info as v31, v53 from movie_info as mi, aggView6174033674344900026 where mi.movie_id=aggView6174033674344900026.v37 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin3009226879048306624 as (
with aggView251146202304737804 as (select v37, MIN(v53) as v53 from aggJoin3210560555914630058 group by v37,v53)
select v37, v7, v53 from aggJoin28564952627652323 join aggView251146202304737804 using(v37));
create or replace view aggJoin4774396853443394429 as (
with aggView913627620937359636 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37, v53 from aggJoin3009226879048306624 join aggView913627620937359636 using(v7));
create or replace view aggJoin2728394107704931923 as (
with aggView3823727164212123381 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin5262531329294755837 join aggView3823727164212123381 using(v26));
create or replace view aggJoin5151216478264147370 as (
with aggView8690560657352927387 as (select v37, MIN(v52) as v52 from aggJoin2728394107704931923 group by v37,v52)
select v37, v53 as v53, v52 from aggJoin4774396853443394429 join aggView8690560657352927387 using(v37));
create or replace view aggJoin4375976539660817055 as (
with aggView4099364980672109111 as (select v37, MIN(v53) as v53, MIN(v52) as v52 from aggJoin5151216478264147370 group by v37,v53,v52)
select v54 as v54, v53, v52 from aggJoin4192698901735768286 join aggView4099364980672109111 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin4375976539660817055;
