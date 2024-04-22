create or replace view aggJoin7228072702103145721 as (
with aggView2266671371738428500 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView2266671371738428500 where mc.company_id=aggView2266671371738428500.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1568652653572192582 as (
with aggView1656228429690664588 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView1656228429690664588 where t.kind_id=aggView1656228429690664588.v25 and production_year>2005);
create or replace view aggJoin7614938119161610202 as (
with aggView7296914420921845055 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView7296914420921845055 where cc.subject_id=aggView7296914420921845055.v5);
create or replace view aggJoin8818850633779081035 as (
with aggView1775398124764721799 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin7228072702103145721 join aggView1775398124764721799 using(v16));
create or replace view aggJoin5382707182156966022 as (
with aggView982250050004350217 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView982250050004350217 where mi_idx.info_type_id=aggView982250050004350217.v20 and info<'8.5');
create or replace view aggJoin7255001389373249198 as (
with aggView5496856983078922413 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin7614938119161610202 join aggView5496856983078922413 using(v7));
create or replace view aggJoin6597903550749205287 as (
with aggView3448911044424490836 as (select v45, MIN(v57) as v57 from aggJoin8818850633779081035 group by v45,v57)
select movie_id as v45, info_type_id as v18, info as v35, v57 from movie_info as mi, aggView3448911044424490836 where mi.movie_id=aggView3448911044424490836.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8715325415276547115 as (
with aggView3439519196925459374 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView3439519196925459374 where mk.keyword_id=aggView3439519196925459374.v22);
create or replace view aggJoin7021596053637044509 as (
with aggView6461973695520574937 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35, v57 from aggJoin6597903550749205287 join aggView6461973695520574937 using(v18));
create or replace view aggJoin4612128774863332525 as (
with aggView6645366848575200666 as (select v45, MIN(v57) as v57 from aggJoin7021596053637044509 group by v45,v57)
select v45, v40, v57 from aggJoin5382707182156966022 join aggView6645366848575200666 using(v45));
create or replace view aggJoin6977218732199850394 as (
with aggView3485774592287372186 as (select v45, MIN(v57) as v57, MIN(v40) as v58 from aggJoin4612128774863332525 group by v45,v57)
select v45, v46, v49, v57, v58 from aggJoin1568652653572192582 join aggView3485774592287372186 using(v45));
create or replace view aggJoin381586045413164083 as (
with aggView4124409071847187946 as (select v45, MIN(v57) as v57, MIN(v58) as v58, MIN(v46) as v59 from aggJoin6977218732199850394 group by v45,v57,v58)
select v45, v57, v58, v59 from aggJoin7255001389373249198 join aggView4124409071847187946 using(v45));
create or replace view aggJoin7240674561142612130 as (
with aggView8518041798886359835 as (select v45, MIN(v57) as v57, MIN(v58) as v58, MIN(v59) as v59 from aggJoin381586045413164083 group by v45,v57,v58,v59)
select v57, v58, v59 from aggJoin8715325415276547115 join aggView8518041798886359835 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin7240674561142612130;
