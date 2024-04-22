create or replace view aggJoin8701911510733403962 as (
with aggView936980319302499491 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView936980319302499491 where mc.company_id=aggView936980319302499491.v25);
create or replace view aggJoin8520013149609938289 as (
with aggView6832877954000584539 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView6832877954000584539 where ml.link_type_id=aggView6832877954000584539.v21);
create or replace view aggJoin1468239934794744930 as (
with aggView993992703696713059 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView993992703696713059 where cc.subject_id=aggView993992703696713059.v5);
create or replace view aggJoin2919348572933082532 as (
with aggView7493670986038288561 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView7493670986038288561 where mk.keyword_id=aggView7493670986038288561.v35);
create or replace view aggJoin5246484486186476263 as (
with aggView8899816361957395514 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin1468239934794744930 join aggView8899816361957395514 using(v7));
create or replace view aggJoin480004362317930690 as (
with aggView2075839632487404903 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin8701911510733403962 join aggView2075839632487404903 using(v26));
create or replace view aggJoin7572936350748781156 as (
with aggView6664758712285496377 as (select v37 from aggJoin5246484486186476263 group by v37)
select v37, v53 as v53 from aggJoin8520013149609938289 join aggView6664758712285496377 using(v37));
create or replace view aggJoin5007519375512020651 as (
with aggView6775214374216296526 as (select v37, MIN(v53) as v53 from aggJoin7572936350748781156 group by v37,v53)
select v37, v53 from aggJoin2919348572933082532 join aggView6775214374216296526 using(v37));
create or replace view aggJoin8502961983336518144 as (
with aggView2402576888994228751 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Germany','Swedish','German') group by movie_id)
select id as v37, title as v41, production_year as v44 from title as t, aggView2402576888994228751 where t.id=aggView2402576888994228751.v37 and production_year= 1998);
create or replace view aggJoin6032860473864545395 as (
with aggView3777380972275467673 as (select v37, MIN(v41) as v54 from aggJoin8502961983336518144 group by v37)
select v37, v52 as v52, v54 from aggJoin480004362317930690 join aggView3777380972275467673 using(v37));
create or replace view aggJoin4124011919758320203 as (
with aggView1789305114627824293 as (select v37, MIN(v52) as v52, MIN(v54) as v54 from aggJoin6032860473864545395 group by v37,v52,v54)
select v53 as v53, v52, v54 from aggJoin5007519375512020651 join aggView1789305114627824293 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin4124011919758320203;
