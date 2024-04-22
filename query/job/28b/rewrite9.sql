create or replace view aggJoin6559682771404156642 as (
with aggView6460089593127890745 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView6460089593127890745 where mc.company_id=aggView6460089593127890745.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin7277798310674818804 as (
with aggView4171263081841020251 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView4171263081841020251 where mi_idx.info_type_id=aggView4171263081841020251.v20 and info>'6.5');
create or replace view aggJoin2253850895250203017 as (
with aggView5663375434976185156 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView5663375434976185156 where cc.status_id=aggView5663375434976185156.v7);
create or replace view aggJoin2137084263344737360 as (
with aggView2521379445414726316 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin6559682771404156642 join aggView2521379445414726316 using(v16));
create or replace view aggJoin7467016419442740320 as (
with aggView7151505561676652851 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView7151505561676652851 where t.kind_id=aggView7151505561676652851.v25 and production_year>2005);
create or replace view aggJoin1338111266661861616 as (
with aggView6418222168289333285 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin2253850895250203017 join aggView6418222168289333285 using(v5));
create or replace view aggJoin7562281037296716539 as (
with aggView685064547333637759 as (select v45 from aggJoin1338111266661861616 group by v45)
select v45, v46, v49 from aggJoin7467016419442740320 join aggView685064547333637759 using(v45));
create or replace view aggJoin9035706853804482670 as (
with aggView5896361718181503891 as (select v45, MIN(v46) as v59 from aggJoin7562281037296716539 group by v45)
select movie_id as v45, info_type_id as v18, info as v35, v59 from movie_info as mi, aggView5896361718181503891 where mi.movie_id=aggView5896361718181503891.v45 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin3940567091158778417 as (
with aggView4550863898557916314 as (select v45, MIN(v57) as v57 from aggJoin2137084263344737360 group by v45,v57)
select v45, v40, v57 from aggJoin7277798310674818804 join aggView4550863898557916314 using(v45));
create or replace view aggJoin985525573303639541 as (
with aggView7924293008001211432 as (select v45, MIN(v57) as v57, MIN(v40) as v58 from aggJoin3940567091158778417 group by v45,v57)
select v45, v18, v35, v59 as v59, v57, v58 from aggJoin9035706853804482670 join aggView7924293008001211432 using(v45));
create or replace view aggJoin3269372262101771533 as (
with aggView6162611605968578623 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35, v59, v57, v58 from aggJoin985525573303639541 join aggView6162611605968578623 using(v18));
create or replace view aggJoin6926733410644131472 as (
with aggView299277783074849179 as (select v45, MIN(v59) as v59, MIN(v57) as v57, MIN(v58) as v58 from aggJoin3269372262101771533 group by v45,v59,v58,v57)
select keyword_id as v22, v59, v57, v58 from movie_keyword as mk, aggView299277783074849179 where mk.movie_id=aggView299277783074849179.v45);
create or replace view aggJoin3346219970631835155 as (
with aggView8946761473471919129 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v59, v57, v58 from aggJoin6926733410644131472 join aggView8946761473471919129 using(v22));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin3346219970631835155;
