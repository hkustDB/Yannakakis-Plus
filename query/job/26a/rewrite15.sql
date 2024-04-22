create or replace view aggJoin3635365463371496904 as (
with aggView7910261693253112071 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView7910261693253112071 where ci.person_role_id=aggView7910261693253112071.v9);
create or replace view aggJoin9169581591405168252 as (
with aggView2853550567150045817 as (select id as v38, name as v61 from name as n)
select v47, v59, v61 from aggJoin3635365463371496904 join aggView2853550567150045817 using(v38));
create or replace view aggJoin2244157528699764674 as (
with aggView1411561033296646268 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView1411561033296646268 where t.kind_id=aggView1411561033296646268.v28 and production_year>2000);
create or replace view aggJoin8120269592114399046 as (
with aggView5139457580828422523 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView5139457580828422523 where mi_idx.info_type_id=aggView5139457580828422523.v23 and info>'7.0');
create or replace view aggJoin6008197204428404665 as (
with aggView4839057085536407331 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView4839057085536407331 where cc.subject_id=aggView4839057085536407331.v5);
create or replace view aggJoin4884163218781659085 as (
with aggView4321948429977615521 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin6008197204428404665 join aggView4321948429977615521 using(v7));
create or replace view aggJoin4496207543347644154 as (
with aggView5789783150179094587 as (select v47 from aggJoin4884163218781659085 group by v47)
select v47, v59 as v59, v61 as v61 from aggJoin9169581591405168252 join aggView5789783150179094587 using(v47));
create or replace view aggJoin2052766950516997289 as (
with aggView7293450526078411906 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView7293450526078411906 where mk.keyword_id=aggView7293450526078411906.v25);
create or replace view aggJoin8637447896919072563 as (
with aggView1654996209468998222 as (select v47 from aggJoin2052766950516997289 group by v47)
select v47, v33 from aggJoin8120269592114399046 join aggView1654996209468998222 using(v47));
create or replace view aggJoin8286348981419896066 as (
with aggView2377566758565815548 as (select v47, MIN(v33) as v60 from aggJoin8637447896919072563 group by v47)
select v47, v48, v51, v60 from aggJoin2244157528699764674 join aggView2377566758565815548 using(v47));
create or replace view aggJoin721613464675685605 as (
with aggView2598013405052063878 as (select v47, MIN(v60) as v60, MIN(v48) as v62 from aggJoin8286348981419896066 group by v47,v60)
select v59 as v59, v61 as v61, v60, v62 from aggJoin4496207543347644154 join aggView2598013405052063878 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61,MIN(v62) as v62 from aggJoin721613464675685605;
