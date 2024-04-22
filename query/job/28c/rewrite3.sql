create or replace view aggView1626942901272154396 as select id as v9, name as v10 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin8445181748955138922 as (
with aggView6090514458999304914 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView6090514458999304914 where t.kind_id=aggView6090514458999304914.v25 and production_year>2005);
create or replace view aggView5008075334532276160 as select v46, v45 from aggJoin8445181748955138922 group by v46,v45;
create or replace view aggJoin603859438166704687 as (
with aggView4021239123310935887 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView4021239123310935887 where cc.subject_id=aggView4021239123310935887.v5);
create or replace view aggJoin537824895345801607 as (
with aggView4814047837858808900 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView4814047837858808900 where mi_idx.info_type_id=aggView4814047837858808900.v20);
create or replace view aggJoin2496991404668562824 as (
with aggView9177151147651708942 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin603859438166704687 join aggView9177151147651708942 using(v7));
create or replace view aggJoin2466337390648323727 as (
with aggView4628324625385835246 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView4628324625385835246 where mk.keyword_id=aggView4628324625385835246.v22);
create or replace view aggJoin4338666267067806922 as (
with aggView8577637802306239372 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView8577637802306239372 where mi.info_type_id=aggView8577637802306239372.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin2172474212159151466 as (
with aggView2048789414898984412 as (select v45 from aggJoin4338666267067806922 group by v45)
select v45 from aggJoin2466337390648323727 join aggView2048789414898984412 using(v45));
create or replace view aggJoin7615661019403064264 as (
with aggView8577154978056881661 as (select v45 from aggJoin2172474212159151466 group by v45)
select v45 from aggJoin2496991404668562824 join aggView8577154978056881661 using(v45));
create or replace view aggJoin3736016144523220840 as (
with aggView1869864996407174190 as (select v45 from aggJoin7615661019403064264 group by v45)
select v45, v40 from aggJoin537824895345801607 join aggView1869864996407174190 using(v45));
create or replace view aggJoin4380755982270586538 as (
with aggView4633164822633588618 as (select v40, v45 from aggJoin3736016144523220840 group by v40,v45)
select v45, v40 from aggView4633164822633588618 where v40<'8.5');
create or replace view aggJoin3952870972155608889 as (
with aggView6389422369712604437 as (select v45, MIN(v40) as v58 from aggJoin4380755982270586538 group by v45)
select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v58 from movie_companies as mc, aggView6389422369712604437 where mc.movie_id=aggView6389422369712604437.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin2533563837349055246 as (
with aggView8734260747206502335 as (select v9, MIN(v10) as v57 from aggView1626942901272154396 group by v9)
select v45, v16, v31, v58 as v58, v57 from aggJoin3952870972155608889 join aggView8734260747206502335 using(v9));
create or replace view aggJoin7266238525741435862 as (
with aggView6822888600149490779 as (select id as v16 from company_type as ct)
select v45, v31, v58, v57 from aggJoin2533563837349055246 join aggView6822888600149490779 using(v16));
create or replace view aggJoin7676475684564121941 as (
with aggView6599058399323130760 as (select v45, MIN(v58) as v58, MIN(v57) as v57 from aggJoin7266238525741435862 group by v45,v57,v58)
select v46, v58, v57 from aggView5008075334532276160 join aggView6599058399323130760 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin7676475684564121941;
