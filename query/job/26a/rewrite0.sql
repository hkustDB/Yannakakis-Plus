create or replace view aggView3313657491377085643 as select id as v38, name as v39 from name as n;
create or replace view aggView6581998876565236446 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin8877534164939792992 as (
with aggView8999169148248416596 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView8999169148248416596 where t.kind_id=aggView8999169148248416596.v28 and production_year>2000);
create or replace view aggJoin8405875674082968544 as (
with aggView5576769297182612807 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView5576769297182612807 where mi_idx.info_type_id=aggView5576769297182612807.v23);
create or replace view aggJoin5447687979417019519 as (
with aggView815784664127129898 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView815784664127129898 where cc.subject_id=aggView815784664127129898.v5);
create or replace view aggJoin2652373514724151500 as (
with aggView5663887314491651029 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin5447687979417019519 join aggView5663887314491651029 using(v7));
create or replace view aggJoin949704778276101757 as (
with aggView960848705218322130 as (select v47 from aggJoin2652373514724151500 group by v47)
select v47, v33 from aggJoin8405875674082968544 join aggView960848705218322130 using(v47));
create or replace view aggJoin554071814201881760 as (
with aggView3238789301767829113 as (select v33, v47 from aggJoin949704778276101757 group by v33,v47)
select v47, v33 from aggView3238789301767829113 where v33>'7.0');
create or replace view aggJoin846476251700160666 as (
with aggView4246049063101344502 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView4246049063101344502 where mk.keyword_id=aggView4246049063101344502.v25);
create or replace view aggJoin3301090593119768456 as (
with aggView3837538745128284126 as (select v47 from aggJoin846476251700160666 group by v47)
select v47, v48, v51 from aggJoin8877534164939792992 join aggView3837538745128284126 using(v47));
create or replace view aggView3244352376705742182 as select v48, v47 from aggJoin3301090593119768456 group by v48,v47;
create or replace view aggJoin5380583251398680610 as (
with aggView2896040614721349421 as (select v47, MIN(v33) as v60 from aggJoin554071814201881760 group by v47)
select v48, v47, v60 from aggView3244352376705742182 join aggView2896040614721349421 using(v47));
create or replace view aggJoin1863738673324062204 as (
with aggView5721419882530924390 as (select v47, MIN(v60) as v60, MIN(v48) as v62 from aggJoin5380583251398680610 group by v47,v60)
select person_id as v38, person_role_id as v9, v60, v62 from cast_info as ci, aggView5721419882530924390 where ci.movie_id=aggView5721419882530924390.v47);
create or replace view aggJoin4577753373526193171 as (
with aggView858369444243117412 as (select v38, MIN(v39) as v61 from aggView3313657491377085643 group by v38)
select v9, v60 as v60, v62 as v62, v61 from aggJoin1863738673324062204 join aggView858369444243117412 using(v38));
create or replace view aggJoin7967277142167398244 as (
with aggView8778290322106628814 as (select v9, MIN(v60) as v60, MIN(v62) as v62, MIN(v61) as v61 from aggJoin4577753373526193171 group by v9,v61,v60,v62)
select v10, v60, v62, v61 from aggView6581998876565236446 join aggView8778290322106628814 using(v9));
select MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61,MIN(v62) as v62 from aggJoin7967277142167398244;
