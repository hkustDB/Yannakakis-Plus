create or replace view aggView1356363137015229217 as select id as v9, name as v10 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin3669216569211628511 as (
with aggView7159527146914171285 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView7159527146914171285 where t.kind_id=aggView7159527146914171285.v25 and production_year>2005);
create or replace view aggJoin1326688500095147069 as (
with aggView880205870804789955 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView880205870804789955 where cc.subject_id=aggView880205870804789955.v5);
create or replace view aggJoin7302045809188948117 as (
with aggView1211334629647473645 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView1211334629647473645 where mi_idx.info_type_id=aggView1211334629647473645.v20);
create or replace view aggJoin7662806493327893763 as (
with aggView1277819619157614962 as (select v40, v45 from aggJoin7302045809188948117 group by v40,v45)
select v45, v40 from aggView1277819619157614962 where v40<'8.5');
create or replace view aggJoin5777869058364446521 as (
with aggView1123777771370413714 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin1326688500095147069 join aggView1123777771370413714 using(v7));
create or replace view aggJoin5116745727392806400 as (
with aggView6020515647207962358 as (select v45 from aggJoin5777869058364446521 group by v45)
select v45, v46, v49 from aggJoin3669216569211628511 join aggView6020515647207962358 using(v45));
create or replace view aggJoin769668904172728843 as (
with aggView2488215396754185962 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView2488215396754185962 where mk.keyword_id=aggView2488215396754185962.v22);
create or replace view aggJoin5098438316348761513 as (
with aggView4057939490126786404 as (select v45 from aggJoin769668904172728843 group by v45)
select v45, v46, v49 from aggJoin5116745727392806400 join aggView4057939490126786404 using(v45));
create or replace view aggView1247850872150593076 as select v46, v45 from aggJoin5098438316348761513 group by v46,v45;
create or replace view aggJoin2561440290529848735 as (
with aggView4606706595442067609 as (select v45, MIN(v40) as v58 from aggJoin7662806493327893763 group by v45)
select v46, v45, v58 from aggView1247850872150593076 join aggView4606706595442067609 using(v45));
create or replace view aggJoin1966373019582178421 as (
with aggView1455386275401480195 as (select v45, MIN(v58) as v58, MIN(v46) as v59 from aggJoin2561440290529848735 group by v45,v58)
select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v58, v59 from movie_companies as mc, aggView1455386275401480195 where mc.movie_id=aggView1455386275401480195.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin860720237244979218 as (
with aggView4629978173465543509 as (select id as v16 from company_type as ct)
select v45, v9, v31, v58, v59 from aggJoin1966373019582178421 join aggView4629978173465543509 using(v16));
create or replace view aggJoin9051230028203869548 as (
with aggView3250467696169012209 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView3250467696169012209 where mi.info_type_id=aggView3250467696169012209.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1460259755627669085 as (
with aggView1952368087659707013 as (select v45 from aggJoin9051230028203869548 group by v45)
select v9, v31, v58 as v58, v59 as v59 from aggJoin860720237244979218 join aggView1952368087659707013 using(v45));
create or replace view aggJoin1724723821661459849 as (
with aggView3531714247792023556 as (select v9, MIN(v58) as v58, MIN(v59) as v59 from aggJoin1460259755627669085 group by v9,v58,v59)
select v10, v58, v59 from aggView1356363137015229217 join aggView3531714247792023556 using(v9));
select MIN(v10) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin1724723821661459849;
