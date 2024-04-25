create or replace view aggView1166395723482454554 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin4604265564803009846 as (
with aggView2853545156160176391 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView2853545156160176391 where t.kind_id=aggView2853545156160176391.v25 and production_year>2005);
create or replace view aggView7031254476610199571 as select v45, v46 from aggJoin4604265564803009846 group by v45,v46;
create or replace view aggJoin8526177629186645342 as (
with aggView1278423701238180735 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView1278423701238180735 where cc.subject_id=aggView1278423701238180735.v5);
create or replace view aggJoin7426074899038070207 as (
with aggView1802069695870161337 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView1802069695870161337 where mi_idx.info_type_id=aggView1802069695870161337.v20 and info<'8.5');
create or replace view aggJoin8423241076348423237 as (
with aggView8606034829464066890 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin8526177629186645342 join aggView8606034829464066890 using(v7));
create or replace view aggJoin5272539555158144822 as (
with aggView8928558339575563970 as (select v45 from aggJoin8423241076348423237 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView8928558339575563970 where mi.movie_id=aggView8928558339575563970.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8314524875569257751 as (
with aggView6746823314031733427 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView6746823314031733427 where mk.keyword_id=aggView6746823314031733427.v22);
create or replace view aggJoin1315695832354869112 as (
with aggView2731055833707755233 as (select v45 from aggJoin8314524875569257751 group by v45)
select v45, v18, v35 from aggJoin5272539555158144822 join aggView2731055833707755233 using(v45));
create or replace view aggJoin1578251604548376991 as (
with aggView5697151087956091368 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin1315695832354869112 join aggView5697151087956091368 using(v18));
create or replace view aggJoin7852091484868821320 as (
with aggView8331392675761245457 as (select v45 from aggJoin1578251604548376991 group by v45)
select v45, v40 from aggJoin7426074899038070207 join aggView8331392675761245457 using(v45));
create or replace view aggView1476520616697536954 as select v45, v40 from aggJoin7852091484868821320 group by v45,v40;
create or replace view aggJoin7398808587096081141 as (
with aggView6624015943157648742 as (select v45, MIN(v40) as v58 from aggView1476520616697536954 group by v45)
select v45, v46, v58 from aggView7031254476610199571 join aggView6624015943157648742 using(v45));
create or replace view aggJoin12080253535766536 as (
with aggView5378073033997561766 as (select v45, MIN(v58) as v58, MIN(v46) as v59 from aggJoin7398808587096081141 group by v45)
select company_id as v9, company_type_id as v16, note as v31, v58, v59 from movie_companies as mc, aggView5378073033997561766 where mc.movie_id=aggView5378073033997561766.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1813471465010439281 as (
with aggView7384128749473782438 as (select id as v16 from company_type as ct)
select v9, v31, v58, v59 from aggJoin12080253535766536 join aggView7384128749473782438 using(v16));
create or replace view aggJoin4440884152470891681 as (
with aggView7420484742480513726 as (select v9, MIN(v58) as v58, MIN(v59) as v59 from aggJoin1813471465010439281 group by v9)
select v10, v58, v59 from aggView1166395723482454554 join aggView7420484742480513726 using(v9));
select MIN(v10) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin4440884152470891681;
