create or replace view aggJoin7633519700149264050 as (
with aggView404553935996220607 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView404553935996220607 where ci.person_role_id=aggView404553935996220607.v9);
create or replace view aggJoin104363254713542052 as (
with aggView6868816178991816674 as (select id as v38, name as v61 from name as n)
select v47, v59, v61 from aggJoin7633519700149264050 join aggView6868816178991816674 using(v38));
create or replace view aggJoin8993646358919461955 as (
with aggView3766674347145952411 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView3766674347145952411 where t.kind_id=aggView3766674347145952411.v28 and production_year>2000);
create or replace view aggJoin1837626616010521843 as (
with aggView5932119178134243128 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView5932119178134243128 where mi_idx.info_type_id=aggView5932119178134243128.v23 and info>'7.0');
create or replace view aggJoin8665890762799282774 as (
with aggView5754809953412180535 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView5754809953412180535 where cc.subject_id=aggView5754809953412180535.v5);
create or replace view aggJoin7610838562355886373 as (
with aggView6843034536332903269 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin8665890762799282774 join aggView6843034536332903269 using(v7));
create or replace view aggJoin8294061793310470472 as (
with aggView2152718732192420654 as (select v47 from aggJoin7610838562355886373 group by v47)
select v47, v59 as v59, v61 as v61 from aggJoin104363254713542052 join aggView2152718732192420654 using(v47));
create or replace view aggJoin5682692665191514484 as (
with aggView573851542800441890 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView573851542800441890 where mk.keyword_id=aggView573851542800441890.v25);
create or replace view aggJoin8223654040756080464 as (
with aggView1593192227318271133 as (select v47 from aggJoin5682692665191514484 group by v47)
select v47, v48, v51 from aggJoin8993646358919461955 join aggView1593192227318271133 using(v47));
create or replace view aggJoin8057141340449081997 as (
with aggView1390914769358694355 as (select v47, MIN(v48) as v62 from aggJoin8223654040756080464 group by v47)
select v47, v33, v62 from aggJoin1837626616010521843 join aggView1390914769358694355 using(v47));
create or replace view aggJoin2931803213366074500 as (
with aggView9121232689975458858 as (select v47, MIN(v62) as v62, MIN(v33) as v60 from aggJoin8057141340449081997 group by v47,v62)
select v59 as v59, v61 as v61, v62, v60 from aggJoin8294061793310470472 join aggView9121232689975458858 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61,MIN(v62) as v62 from aggJoin2931803213366074500;
