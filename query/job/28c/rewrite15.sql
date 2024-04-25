create or replace view aggJoin8841924833238908449 as (
with aggView4648276334038754855 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView4648276334038754855 where mc.company_id=aggView4648276334038754855.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin2425567165808508076 as (
with aggView7526782845959801480 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView7526782845959801480 where t.kind_id=aggView7526782845959801480.v25 and production_year>2005);
create or replace view aggJoin2598806784432570232 as (
with aggView2984497079700262730 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView2984497079700262730 where mi_idx.info_type_id=aggView2984497079700262730.v20 and info<'8.5');
create or replace view aggJoin3575742366525562061 as (
with aggView3271127882023008761 as (select v45, MIN(v40) as v58 from aggJoin2598806784432570232 group by v45)
select movie_id as v45, subject_id as v5, status_id as v7, v58 from complete_cast as cc, aggView3271127882023008761 where cc.movie_id=aggView3271127882023008761.v45);
create or replace view aggJoin5863662633527714660 as (
with aggView7586593444909171354 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45, v7, v58 from aggJoin3575742366525562061 join aggView7586593444909171354 using(v5));
create or replace view aggJoin2098450506375837106 as (
with aggView4106070110007167156 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin8841924833238908449 join aggView4106070110007167156 using(v16));
create or replace view aggJoin4008148124459903751 as (
with aggView1607857521637866075 as (select v45, MIN(v57) as v57 from aggJoin2098450506375837106 group by v45)
select movie_id as v45, keyword_id as v22, v57 from movie_keyword as mk, aggView1607857521637866075 where mk.movie_id=aggView1607857521637866075.v45);
create or replace view aggJoin2514418846232884797 as (
with aggView5535196007283472222 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45, v58 from aggJoin5863662633527714660 join aggView5535196007283472222 using(v7));
create or replace view aggJoin2429915079918613050 as (
with aggView8551440955423808053 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView8551440955423808053 where mi.info_type_id=aggView8551440955423808053.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin7041269305277432034 as (
with aggView1562710693849325523 as (select v45 from aggJoin2429915079918613050 group by v45)
select v45, v58 as v58 from aggJoin2514418846232884797 join aggView1562710693849325523 using(v45));
create or replace view aggJoin3506603575067447148 as (
with aggView1350895442972426257 as (select v45, MIN(v58) as v58 from aggJoin7041269305277432034 group by v45)
select v45, v46, v49, v58 from aggJoin2425567165808508076 join aggView1350895442972426257 using(v45));
create or replace view aggJoin5658861410628313019 as (
with aggView7026899174819780352 as (select v45, MIN(v58) as v58, MIN(v46) as v59 from aggJoin3506603575067447148 group by v45)
select v22, v57 as v57, v58, v59 from aggJoin4008148124459903751 join aggView7026899174819780352 using(v45));
create or replace view aggJoin4362080789054937943 as (
with aggView3731340661939664340 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v57, v58, v59 from aggJoin5658861410628313019 join aggView3731340661939664340 using(v22));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin4362080789054937943;
