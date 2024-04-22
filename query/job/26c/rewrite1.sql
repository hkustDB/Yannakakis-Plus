create or replace view aggView2464124932746030710 as select name as v10, id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin8049320042546927239 as (
with aggView7173208762194901877 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView7173208762194901877 where cc.status_id=aggView7173208762194901877.v7);
create or replace view aggJoin68663744230015963 as (
with aggView8054324117533083608 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin8049320042546927239 join aggView8054324117533083608 using(v5));
create or replace view aggJoin9199513357279452591 as (
with aggView3188335432573688729 as (select v47 from aggJoin68663744230015963 group by v47)
select movie_id as v47, keyword_id as v25 from movie_keyword as mk, aggView3188335432573688729 where mk.movie_id=aggView3188335432573688729.v47);
create or replace view aggJoin5439133017167013401 as (
with aggView846745887940470089 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView846745887940470089 where mi_idx.info_type_id=aggView846745887940470089.v23);
create or replace view aggView6231461358960835133 as select v33, v47 from aggJoin5439133017167013401 group by v33,v47;
create or replace view aggJoin151116795013911692 as (
with aggView7501576282329827116 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView7501576282329827116 where t.kind_id=aggView7501576282329827116.v28 and production_year>2000);
create or replace view aggJoin3396336045551899878 as (
with aggView5279263816437997764 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select v47 from aggJoin9199513357279452591 join aggView5279263816437997764 using(v25));
create or replace view aggJoin3999851973777687270 as (
with aggView6013885228655850571 as (select v47 from aggJoin3396336045551899878 group by v47)
select v47, v48, v51 from aggJoin151116795013911692 join aggView6013885228655850571 using(v47));
create or replace view aggView4372934856463465544 as select v48, v47 from aggJoin3999851973777687270 group by v48,v47;
create or replace view aggJoin6207957913525893397 as (
with aggView3144930832052109496 as (select v9, MIN(v10) as v59 from aggView2464124932746030710 group by v9)
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView3144930832052109496 where ci.person_role_id=aggView3144930832052109496.v9);
create or replace view aggJoin5442146453013014262 as (
with aggView5380839989833855844 as (select v47, MIN(v48) as v61 from aggView4372934856463465544 group by v47)
select v33, v47, v61 from aggView6231461358960835133 join aggView5380839989833855844 using(v47));
create or replace view aggJoin6443666648170587545 as (
with aggView2382859299882750134 as (select id as v38 from name as n)
select v47, v59 from aggJoin6207957913525893397 join aggView2382859299882750134 using(v38));
create or replace view aggJoin7459876574098993605 as (
with aggView7385395882098870389 as (select v47, MIN(v59) as v59 from aggJoin6443666648170587545 group by v47,v59)
select v33, v61 as v61, v59 from aggJoin5442146453013014262 join aggView7385395882098870389 using(v47));
select MIN(v59) as v59,MIN(v33) as v60,MIN(v61) as v61 from aggJoin7459876574098993605;
