create or replace view aggView4633268215414594732 as select name as v10, id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin739240802006631857 as (
with aggView7821498651590350287 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView7821498651590350287 where cc.status_id=aggView7821498651590350287.v7);
create or replace view aggJoin5778653978890498440 as (
with aggView5311203175440940837 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin739240802006631857 join aggView5311203175440940837 using(v5));
create or replace view aggJoin2886417668148299328 as (
with aggView1461907619389047467 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView1461907619389047467 where mi_idx.info_type_id=aggView1461907619389047467.v23);
create or replace view aggJoin877750567854293456 as (
with aggView1186078257959046211 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView1186078257959046211 where t.kind_id=aggView1186078257959046211.v28 and production_year>2000);
create or replace view aggView4096197276968284985 as select v48, v47 from aggJoin877750567854293456 group by v48,v47;
create or replace view aggJoin1909313914484575142 as (
with aggView3514761432031119634 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView3514761432031119634 where mk.keyword_id=aggView3514761432031119634.v25);
create or replace view aggJoin3676211327023782020 as (
with aggView2925841797762672851 as (select v47 from aggJoin1909313914484575142 group by v47)
select v47 from aggJoin5778653978890498440 join aggView2925841797762672851 using(v47));
create or replace view aggJoin1570270847518740845 as (
with aggView1019622383062860420 as (select v47 from aggJoin3676211327023782020 group by v47)
select v47, v33 from aggJoin2886417668148299328 join aggView1019622383062860420 using(v47));
create or replace view aggView5252970158491599905 as select v33, v47 from aggJoin1570270847518740845 group by v33,v47;
create or replace view aggJoin5061708267903853892 as (
with aggView8452255993572900695 as (select v47, MIN(v33) as v60 from aggView5252970158491599905 group by v47)
select v48, v47, v60 from aggView4096197276968284985 join aggView8452255993572900695 using(v47));
create or replace view aggJoin5336493934218462083 as (
with aggView3149789828215352600 as (select v47, MIN(v60) as v60, MIN(v48) as v61 from aggJoin5061708267903853892 group by v47,v60)
select person_id as v38, person_role_id as v9, v60, v61 from cast_info as ci, aggView3149789828215352600 where ci.movie_id=aggView3149789828215352600.v47);
create or replace view aggJoin509757325533844466 as (
with aggView7231715465800620504 as (select id as v38 from name as n)
select v9, v60, v61 from aggJoin5336493934218462083 join aggView7231715465800620504 using(v38));
create or replace view aggJoin7389224766174388141 as (
with aggView1810379301227498247 as (select v9, MIN(v60) as v60, MIN(v61) as v61 from aggJoin509757325533844466 group by v9,v61,v60)
select v10, v60, v61 from aggView4633268215414594732 join aggView1810379301227498247 using(v9));
select MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin7389224766174388141;
