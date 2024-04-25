create or replace view aggView4060333007834860416 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin1838162190641119130 as (
with aggView3284070527376897527 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView3284070527376897527 where t.kind_id=aggView3284070527376897527.v25 and production_year>2005);
create or replace view aggView6001163544915568514 as select v45, v46 from aggJoin1838162190641119130 group by v45,v46;
create or replace view aggJoin338960397518013903 as (
with aggView4984066080440884143 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView4984066080440884143 where cc.subject_id=aggView4984066080440884143.v5);
create or replace view aggJoin7510684535263349136 as (
with aggView2338604424819048973 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView2338604424819048973 where mi_idx.info_type_id=aggView2338604424819048973.v20 and info<'8.5');
create or replace view aggJoin8196834292039305323 as (
with aggView5872897745403607062 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin338960397518013903 join aggView5872897745403607062 using(v7));
create or replace view aggJoin1419988721985794774 as (
with aggView2021014739888567342 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView2021014739888567342 where mk.keyword_id=aggView2021014739888567342.v22);
create or replace view aggJoin3996354780110134071 as (
with aggView229312392605917830 as (select v45 from aggJoin1419988721985794774 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView229312392605917830 where mi.movie_id=aggView229312392605917830.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1317084296175786487 as (
with aggView2708328373775336253 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin3996354780110134071 join aggView2708328373775336253 using(v18));
create or replace view aggJoin2005424187751928674 as (
with aggView1358394413786369348 as (select v45 from aggJoin1317084296175786487 group by v45)
select v45 from aggJoin8196834292039305323 join aggView1358394413786369348 using(v45));
create or replace view aggJoin1367535663387497753 as (
with aggView8244763801241469950 as (select v45 from aggJoin2005424187751928674 group by v45)
select v45, v40 from aggJoin7510684535263349136 join aggView8244763801241469950 using(v45));
create or replace view aggView16006435853087025 as select v45, v40 from aggJoin1367535663387497753 group by v45,v40;
create or replace view aggJoin4612216347940910509 as (
with aggView5717618133138483903 as (select v9, MIN(v10) as v57 from aggView4060333007834860416 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView5717618133138483903 where mc.company_id=aggView5717618133138483903.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin8085936675485706750 as (
with aggView7322286978130328676 as (select v45, MIN(v40) as v58 from aggView16006435853087025 group by v45)
select v45, v16, v31, v57 as v57, v58 from aggJoin4612216347940910509 join aggView7322286978130328676 using(v45));
create or replace view aggJoin1415725143838373967 as (
with aggView8285626444950500422 as (select id as v16 from company_type as ct)
select v45, v31, v57, v58 from aggJoin8085936675485706750 join aggView8285626444950500422 using(v16));
create or replace view aggJoin6464582308705394519 as (
with aggView2034569925068753026 as (select v45, MIN(v57) as v57, MIN(v58) as v58 from aggJoin1415725143838373967 group by v45)
select v46, v57, v58 from aggView6001163544915568514 join aggView2034569925068753026 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin6464582308705394519;
